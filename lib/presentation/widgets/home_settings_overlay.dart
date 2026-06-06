import 'package:flutter/material.dart';

import '../../data/local_storage_service.dart';
import '../../l10n/app_localizations.dart';
import 'locale_picker_button.dart';
import 'theme_picker_button.dart';
import '_settings_panel.dart';

class HomeSettingsOverlay extends StatefulWidget {
  const HomeSettingsOverlay({
    super.key,
    required this.storage,
    required this.onClose,
  });

  final LocalStorageService storage;
  final VoidCallback onClose;

  @override
  State<HomeSettingsOverlay> createState() => _HomeSettingsOverlayState();
}

class _HomeSettingsOverlayState extends State<HomeSettingsOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

  late bool _soundEnabled;

  @override
  void initState() {
    super.initState();
    _soundEnabled = widget.storage.getSoundEnabled();

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
    widget.storage.saveSoundEnabled(value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) => FadeTransition(opacity: _fade, child: child),
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
                  bottom: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      onPressed: _close,
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        l10n.cancel,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
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
