import '../theme/app_theme_variant.dart';
import '../../l10n/app_localizations.dart';

extension AppLocalizationsTheme on AppLocalizations {
  String themeLabel(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.light:
        return themeWhite;
      case AppThemeVariant.dark:
        return themeBlack;
      case AppThemeVariant.ocean:
        return themeOcean;
      case AppThemeVariant.sunset:
        return themeSunset;
      case AppThemeVariant.forest:
        return themeForest;
      case AppThemeVariant.rose:
        return themeRose;
      case AppThemeVariant.amethyst:
        return themeAmethyst;
      case AppThemeVariant.sky:
        return themeSky;
    }
  }
}
