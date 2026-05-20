import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/locale/app_locale.dart';
import '../../core/locale/locale_cubit.dart';
import '../../l10n/app_localizations.dart';

class LocalePickerButton extends StatelessWidget {
  const LocalePickerButton({super.key});

  static Future<void> show(BuildContext context) {
    final maxHeight = MediaQuery.sizeOf(context).height * 0.65;

    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: const _LocalePickerSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return IconButton(
      tooltip: l10n.languageTooltip,
      onPressed: () => LocalePickerButton.show(context),
      icon: const Icon(Icons.language_rounded),
    );
  }
}

class _LocalePickerSheet extends StatelessWidget {
  const _LocalePickerSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.chooseLanguage,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: BlocBuilder<LocaleCubit, Locale>(
            builder: (context, selectedLocale) {
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                itemCount: AppLocale.supported.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final appLocale = AppLocale.supported[index];
                  final isSelected = AppLocale.matches(
                    appLocale.locale,
                    selectedLocale,
                  );

                  return _LocaleOption(
                    label: appLocale.nativeLabel,
                    isSelected: isSelected,
                    onTap: () {
                      context.read<LocaleCubit>().setLocale(appLocale);
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LocaleOption extends StatelessWidget {
  const _LocaleOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: isSelected
          ? theme.colorScheme.primaryContainer.withValues(alpha: 0.45)
          : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_rounded,
                  color: theme.colorScheme.primary,
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
