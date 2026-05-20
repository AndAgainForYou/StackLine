import 'package:flutter/material.dart';

/// Supported app locales with native labels for the language picker.
class AppLocale {
  const AppLocale({
    required this.id,
    required this.locale,
    required this.nativeLabel,
  });

  final String id;
  final Locale locale;
  final String nativeLabel;

  static const english = AppLocale(
    id: 'en',
    locale: Locale('en'),
    nativeLabel: 'English',
  );

  static const russian = AppLocale(
    id: 'ru',
    locale: Locale('ru'),
    nativeLabel: 'Русский',
  );

  static const ukrainian = AppLocale(
    id: 'uk',
    locale: Locale('uk'),
    nativeLabel: 'Українська',
  );

  static const chineseSimplified = AppLocale(
    id: 'zh',
    locale: Locale('zh'),
    nativeLabel: '简体中文',
  );

  static const chineseTraditional = AppLocale(
    id: 'zh_TW',
    locale: Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hant',
      countryCode: 'TW',
    ),
    nativeLabel: '繁體中文',
  );

  static const german = AppLocale(
    id: 'de',
    locale: Locale('de'),
    nativeLabel: 'Deutsch',
  );

  static const french = AppLocale(
    id: 'fr',
    locale: Locale('fr'),
    nativeLabel: 'Français',
  );

  static const polish = AppLocale(
    id: 'pl',
    locale: Locale('pl'),
    nativeLabel: 'Polski',
  );

  static const spanish = AppLocale(
    id: 'es',
    locale: Locale('es'),
    nativeLabel: 'Español',
  );

  static const portuguese = AppLocale(
    id: 'pt',
    locale: Locale('pt'),
    nativeLabel: 'Português',
  );

  static const italian = AppLocale(
    id: 'it',
    locale: Locale('it'),
    nativeLabel: 'Italiano',
  );

  static const japanese = AppLocale(
    id: 'ja',
    locale: Locale('ja'),
    nativeLabel: '日本語',
  );

  static const korean = AppLocale(
    id: 'ko',
    locale: Locale('ko'),
    nativeLabel: '한국어',
  );

  static const arabic = AppLocale(
    id: 'ar',
    locale: Locale('ar'),
    nativeLabel: 'العربية',
  );

  static const hindi = AppLocale(
    id: 'hi',
    locale: Locale('hi'),
    nativeLabel: 'हिन्दी',
  );

  static const turkish = AppLocale(
    id: 'tr',
    locale: Locale('tr'),
    nativeLabel: 'Türkçe',
  );

  static const indonesian = AppLocale(
    id: 'id',
    locale: Locale('id'),
    nativeLabel: 'Bahasa Indonesia',
  );

  static const vietnamese = AppLocale(
    id: 'vi',
    locale: Locale('vi'),
    nativeLabel: 'Tiếng Việt',
  );

  static const dutch = AppLocale(
    id: 'nl',
    locale: Locale('nl'),
    nativeLabel: 'Nederlands',
  );

  static const List<AppLocale> supported = [
    english,
    russian,
    ukrainian,
    chineseSimplified,
    chineseTraditional,
    german,
    french,
    polish,
    spanish,
    portuguese,
    italian,
    japanese,
    korean,
    arabic,
    hindi,
    turkish,
    indonesian,
    vietnamese,
    dutch,
  ];

  static AppLocale fromId(String id) {
    return supported.firstWhere(
      (locale) => locale.id == id,
      orElse: () => english,
    );
  }

  static AppLocale resolve(Locale locale) {
    if (locale.languageCode == 'zh') {
      final isTraditional = locale.scriptCode == 'Hant' ||
          locale.countryCode == 'TW' ||
          locale.countryCode == 'HK' ||
          locale.countryCode == 'MO';
      return isTraditional ? chineseTraditional : chineseSimplified;
    }

    return supported.firstWhere(
      (appLocale) => appLocale.locale.languageCode == locale.languageCode,
      orElse: () => english,
    );
  }

  static bool matches(Locale a, Locale b) {
    if (a.languageCode != b.languageCode) return false;
    if (a.languageCode != 'zh') return true;

    final aTraditional = a.scriptCode == 'Hant' ||
        a.countryCode == 'TW' ||
        a.countryCode == 'HK' ||
        a.countryCode == 'MO';
    final bTraditional = b.scriptCode == 'Hant' ||
        b.countryCode == 'TW' ||
        b.countryCode == 'HK' ||
        b.countryCode == 'MO';
    return aTraditional == bTraditional;
  }
}
