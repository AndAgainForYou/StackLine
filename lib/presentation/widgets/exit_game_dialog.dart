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
    builder: (dialogContext) {
      final theme = Theme.of(dialogContext);

      return AlertDialog(
        title: Text(
          l10n.exitGameTitle,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.exitGameMessage(score),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(ExitGameChoice.save),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 8),  
              ),
              child: Text(l10n.exitGameSave),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.of(dialogContext).pop(ExitGameChoice.cancel),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Text(l10n.cancel),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(dialogContext)
                        .pop(ExitGameChoice.discard),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      foregroundColor: theme.colorScheme.error,
                      side: BorderSide(color: theme.colorScheme.error),
                    ),
                    child: Text(l10n.exitGameDiscard),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
