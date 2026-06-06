import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

enum ExitGameChoice { cancel, save, discard }

Future<ExitGameChoice?> showExitGameDialog(
  BuildContext context, {
  required int score,
}) {
  final l10n = AppLocalizations.of(context)!;

  return showDialog<ExitGameChoice>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.60),
    builder: (dialogContext) {
      final theme = Theme.of(dialogContext);
      final cs = theme.colorScheme;

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                // ── Header chip ─────────────────────────────
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 7),
                    decoration: BoxDecoration(
                      color: cs.error.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: cs.error.withValues(alpha: 0.30),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      l10n.exitGameTitle.toUpperCase(),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: cs.error,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // ── Score card ──────────────────────────────
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest
                        .withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.sports_score_rounded,
                          size: 22,
                          color: cs.onSurface.withValues(alpha: 0.60)),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          l10n.exitGameMessage(score),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: cs.onSurface.withValues(alpha: 0.85),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                Divider(
                    color:
                        cs.outlineVariant.withValues(alpha: 0.5),
                    height: 1),
                const SizedBox(height: 16),

                // ── Save button ─────────────────────────────
                SizedBox(
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: () => Navigator.of(dialogContext)
                        .pop(ExitGameChoice.save),
                    icon: const Icon(Icons.save_rounded, size: 18),
                    label: Text(l10n.exitGameSave),
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // ── Cancel + Discard row ─────────────────────
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(dialogContext)
                              .pop(ExitGameChoice.cancel),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: cs.outlineVariant
                                    .withValues(alpha: 0.6)),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(14)),
                          ),
                          child: Text(
                            l10n.cancel,
                            style: TextStyle(
                                color: cs.onSurface
                                    .withValues(alpha: 0.65),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: () => Navigator.of(dialogContext)
                              .pop(ExitGameChoice.discard),
                          icon: Icon(Icons.delete_outline_rounded,
                              color: cs.error, size: 18),
                          label: Text(
                            l10n.exitGameDiscard,
                            style: TextStyle(
                                color: cs.error,
                                fontWeight: FontWeight.w700),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: cs.error
                                    .withValues(alpha: 0.55),
                                width: 1.5),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
