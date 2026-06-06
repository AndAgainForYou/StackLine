import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local_storage_service.dart';
import '../../features/game/bloc/game_cubit.dart';
import '../../features/game/bloc/game_state.dart';
import '../../l10n/app_localizations.dart';
import '../services/sound_service.dart';
import '../widgets/drag_hover_tracker.dart';
import '../widgets/exit_game_dialog.dart';
import '../widgets/game_board_view.dart';
import '../widgets/game_over_overlay.dart';
import '../widgets/game_settings_overlay.dart';
import '../widgets/piece_tray.dart';
import '../widgets/score_header.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({
    super.key,
    required this.soundService,
    required this.storage,
  });

  final SoundService soundService;
  final LocalStorageService storage;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _settingsVisible = false;

  Future<void> _handleSystemBack(BuildContext context, GameState state) async {
    if (!state.needsExitConfirmation) {
      await widget.soundService.dispose();
      if (context.mounted) Navigator.of(context).pop();
      return;
    }

    final choice = await showExitGameDialog(context, score: state.score);
    if (!context.mounted || choice == null || choice == ExitGameChoice.cancel) {
      return;
    }

    final cubit = context.read<GameCubit>();
    if (choice == ExitGameChoice.save) {
      await cubit.saveProgressAndExit();
    } else {
      await cubit.discardProgressAndExit();
    }

    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return PopScope(
          canPop: !state.needsExitConfirmation,
          onPopInvokedWithResult: (didPop, _) async {
            if (didPop) {
              await widget.soundService.dispose();
              return;
            }
            await _handleSystemBack(context, state);
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── Main scaffold ──────────────────────────────────────────
              Scaffold(
                appBar: AppBar(
                  title: Text(l10n.appTitle),
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      tooltip: l10n.settingsTitle,
                      icon: const Icon(Icons.settings_rounded),
                      onPressed: () =>
                          setState(() => _settingsVisible = true),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
                body: Stack(
                  children: [
                    SafeArea(
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            const ScoreHeader(),
                            const SizedBox(height: 8),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: PreviewPanel(),
                            ),
                            const SizedBox(height: 12),
                            const Expanded(child: GameBoardView()),
                            const SizedBox(height: 12),
                            const PieceTray(),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                    const DragHoverTracker(),
                  ],
                ),
              ),

              // ── Game over overlay (covers AppBar) ──────────────────────
              const GameOverOverlay(),

              // ── Settings overlay (covers everything) ───────────────────
              if (_settingsVisible)
                GameSettingsOverlay(
                  soundService: widget.soundService,
                  storage: widget.storage,
                  onClose: () => setState(() => _settingsVisible = false),
                ),
            ],
          ),
        );
      },
    );
  }
}
