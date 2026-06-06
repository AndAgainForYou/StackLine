import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/locale/app_locale.dart';
import '../../core/locale/locale_cubit.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_theme_variant.dart';
import '../../core/theme/theme_cubit.dart';
import '../../l10n/app_localizations.dart';

/// Shared card body used by both HomeSettingsOverlay and GameSettingsOverlay.
class SettingsPanel extends StatelessWidget {
  const SettingsPanel({
    super.key,
    required this.title,
    required this.soundEnabled,
    required this.onSoundToggle,
    required this.onThemeTap,
    required this.onLanguageTap,
    /// Widget rendered below the divider (e.g. action buttons).
    required this.bottom,
  });

  final String title;
  final bool soundEnabled;
  final ValueChanged<bool> onSoundToggle;
  final VoidCallback onThemeTap;
  final VoidCallback onLanguageTap;
  final Widget bottom;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Material(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(24),
        elevation: 8,
        shadowColor: Colors.black.withValues(alpha: 0.4),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header chip ─────────────────────────────────
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: cs.primary.withValues(alpha: 0.30),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    title.toUpperCase(),
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Divider(
                  color: cs.outlineVariant.withValues(alpha: 0.5),
                  height: 1),
              const SizedBox(height: 16),

              // ── Theme row ────────────────────────────────────
              _SettingsRow(
                label: l10n.themesTooltip,
                icon: Icons.palette_outlined,
                trailing: _ThemePreviewButton(onTap: onThemeTap),
              ),
              const SizedBox(height: 12),

              // ── Language row ─────────────────────────────────
              _SettingsRow(
                label: l10n.languageTooltip,
                icon: Icons.language_rounded,
                trailing: _LanguagePreviewButton(onTap: onLanguageTap),
              ),
              const SizedBox(height: 12),

              // ── Sound row ────────────────────────────────────
              _SettingsRow(
                label: l10n.sound,
                icon: soundEnabled
                    ? Icons.volume_up_rounded
                    : Icons.volume_off_rounded,
                trailing: Switch(
                  value: soundEnabled,
                  onChanged: onSoundToggle,
                  thumbIcon:
                      WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return const Icon(Icons.volume_up_rounded,
                          size: 14);
                    }
                    return const Icon(Icons.volume_off_rounded,
                        size: 14);
                  }),
                ),
              ),

              const SizedBox(height: 16),
              Divider(
                  color: cs.outlineVariant.withValues(alpha: 0.5),
                  height: 1),
              const SizedBox(height: 16),

              // ── Bottom actions (caller-provided) ─────────────
              bottom,
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Row helper
// ---------------------------------------------------------------------------

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.label,
    required this.icon,
    required this.trailing,
  });

  final String label;
  final IconData icon;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon,
            size: 20,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.65)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        trailing,
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Theme preview chip
// ---------------------------------------------------------------------------

class _ThemePreviewButton extends StatelessWidget {
  const _ThemePreviewButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ThemeCubit, AppThemeVariant>(
      builder: (context, variant) {
        final previewTheme = AppTheme.fromVariant(variant);
        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: 44,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: variant.seedColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: previewTheme.scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Language preview chip
// ---------------------------------------------------------------------------

class _LanguagePreviewButton extends StatelessWidget {
  const _LanguagePreviewButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final appLocale = AppLocale.supported.firstWhere(
          (l) => AppLocale.matches(l.locale, locale),
          orElse: () => AppLocale.supported.first,
        );

        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1.5,
              ),
            ),
            child: Text(
              appLocale.nativeLabel,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}
