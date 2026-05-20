import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/locale/app_locale.dart';
import '../core/locale/locale_cubit.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/app_theme_variant.dart';
import '../core/theme/theme_cubit.dart';
import '../data/local_storage_service.dart';
import '../l10n/app_localizations.dart';
import 'presentation/screens/home_screen.dart';

class StacklineApp extends StatelessWidget {
  const StacklineApp({super.key, required this.storage});

  final LocalStorageService storage;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit(storage)..load()),
        BlocProvider(create: (_) => LocaleCubit(storage)..load()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, AppThemeVariant>(
            builder: (context, variant) {
              return MaterialApp(
                title: 'Stackline',
                debugShowCheckedModeBanner: false,
                locale: locale,
                supportedLocales: AppLocale.supported
                    .map((appLocale) => appLocale.locale)
                    .toList(),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: AppTheme.fromVariant(variant),
                home: HomeScreen(storage: storage),
              );
            },
          );
        },
      ),
    );
  }
}
