import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/game/bloc/game_cubit.dart';
import '../../features/game/bloc/game_state.dart';
import '../../l10n/app_localizations.dart';
import '../services/sound_service.dart';
import '../widgets/drag_hover_tracker.dart';
import '../widgets/exit_game_dialog.dart';
import '../widgets/game_board_view.dart';
import '../widgets/locale_picker_button.dart';
import '../widgets/piece_tray.dart';
import '../widgets/score_header.dart';
import '../widgets/theme_picker_button.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.soundService});

  final SoundService soundService;

  Future<void> _handleExitRequest(BuildContext context, GameState state) async {
    if (!state.needsExitConfirmation) {
      Navigator.of(context).pop();
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
              await soundService.dispose();
              return;
            }
            await _handleExitRequest(context, state);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(l10n.appTitle),
              centerTitle: true,
              actions: const [
                LocalePickerButton(),
                ThemePickerButton(),
              ],
            ),
            body: Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                BlocBuilder<GameCubit, GameState>(
                  builder: (context, state) {
                    if (state.status != GameStatus.gameOver) {
                      return const SizedBox.shrink();
                    }

                    return Container(
                      color: Colors.black54,
                      alignment: Alignment.center,
                      child: Card(
                        margin: const EdgeInsets.all(32),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                l10n.gameOver,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 8),
                              Text(l10n.gameOverScore(state.score)),
                              const SizedBox(height: 16),
                              FilledButton(
                                onPressed: () =>
                                    context.read<GameCubit>().startGame(),
                                child: Text(l10n.playAgain),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
