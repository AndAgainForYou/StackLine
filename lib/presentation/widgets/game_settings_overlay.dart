import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local_storage_service.dart';
import '../../features/game/bloc/game_cubit.dart';
import '../../l10n/app_localizations.dart';
import '../services/sound_service.dart';
import 'exit_game_dialog.dart';
import 'locale_picker_button.dart';
import 'theme_picker_button.dart';
import '_settings_panel.dart';

class GameSettingsOverlay extends StatefulWidget {
  const GameSettingsOverlay({
    super.key,
    required this.soundService,
    required this.storage,
    required this.onClose,
  });

  final SoundService soundService;
  final LocalStorageService storage;
  final VoidCallback onClose;

  @override
  State<GameSettingsOverlay> createState() => _GameSettingsOverlayState();
}

class _GameSettingsOverlayState extends State<GameSettingsOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

  late bool _soundEnabled;

  @override
  void initState() {
    super.initState();
    _soundEnabled = widget.soundService.enabled;

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _close() async {
    await _ctrl.reverse();
    widget.onClose();
  }

  void _toggleSound(bool value) {
    setState(() => _soundEnabled = value);
    widget.soundService.enabled = value;
    widget.storage.saveSoundEnabled(value);
  }

  Future<void> _exitToMenu() async {
    final state = context.read<GameCubit>().state;

    if (state.needsExitConfirmation) {
      final choice = await showExitGameDialog(context, score: state.score);
      if (!mounted || choice == null || choice == ExitGameChoice.cancel) {
        return;
      }
      final cubit = context.read<GameCubit>();
      if (choice == ExitGameChoice.save) {
        await cubit.saveProgressAndExit();
      } else {
        await cubit.discardProgressAndExit();
      }
    }

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  static const _btnHeight = 48.0;
  static const _btnRadius = 14.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) => FadeTransition(
        opacity: _fade,
        child: child,
      ),
      child: GestureDetector(
        onTap: _close,
        child: Container(
          color: Colors.black.withValues(alpha: 0.60),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {},
            child: SlideTransition(
              position: _slide,
              child: ScaleTransition(
                scale: _scale,
                child: SettingsPanel(
                  title: l10n.settingsTitle,
                  soundEnabled: _soundEnabled,
                  onSoundToggle: _toggleSound,
                  onThemeTap: () => ThemePickerButton.show(context),
                  onLanguageTap: () => LocalePickerButton.show(context),
                  bottom: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: _btnHeight,
                          child: OutlinedButton(
                            onPressed: _close,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  color: cs.outlineVariant
                                      .withValues(alpha: 0.6)),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(_btnRadius),
                              ),
                            ),
                            child: Text(
                              l10n.cancel,
                              style: TextStyle(
                                color: cs.onSurface
                                    .withValues(alpha: 0.65),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: _btnHeight,
                          child: OutlinedButton(
                            onPressed: _exitToMenu,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  color: cs.error.withValues(alpha: 0.55),
                                  width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(_btnRadius),
                              ),
                            ),
                            child: Text(
                              l10n.exitToMenu,
                              style: TextStyle(
                                color: cs.error,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
