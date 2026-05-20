// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline =>
      'ब्लॉक रखें। लाइनें साफ़ करें। अपना रिकॉर्ड तोड़ें।';

  @override
  String get highScore => 'उच्च स्कोर';

  @override
  String get play => 'खेलें';

  @override
  String get gameOver => 'गेम ओवर';

  @override
  String get scoreLabel => 'स्कोर';

  @override
  String gameOverScore(int score) {
    return 'स्कोर: $score';
  }

  @override
  String get playAgain => 'फिर से खेलें';

  @override
  String get retry => 'पुनः प्रयास';

  @override
  String get best => 'सर्वश्रेष्ठ';

  @override
  String get combo => 'कॉम्बो';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => 'अगला';

  @override
  String get themesTooltip => 'थीम';

  @override
  String get chooseTheme => 'थीम चुनें';

  @override
  String get languageTooltip => 'भाषा';

  @override
  String get chooseLanguage => 'भाषा चुनें';

  @override
  String get themeWhite => 'सफ़ेद';

  @override
  String get themeBlack => 'काला';

  @override
  String get themeOcean => 'महासागर';

  @override
  String get themeSunset => 'सूर्यास्त';

  @override
  String get themeForest => 'जंगल';

  @override
  String get themeRose => 'गुलाब';

  @override
  String get themeAmethyst => 'नीलम';

  @override
  String get themeSky => 'आकाश';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get exitGameTitle => 'गेम छोड़ें?';

  @override
  String exitGameMessage(int score) {
    return 'आपका वर्तमान स्कोर $score है। प्रगति सहेजें या रद्द करें?';
  }

  @override
  String get exitGameSave => 'सहेजें';

  @override
  String get exitGameDiscard => 'रद्द करें';

  @override
  String get continueGame => 'जारी रखें';

  @override
  String get newGame => 'नया गेम';

  @override
  String get howToPlay => 'कैसे खेलें';

  @override
  String get aboutTitle => 'गेम के बारे में';

  @override
  String get aboutIntro =>
      'Stackline Tetris से प्रेरित ब्लॉक पज़ल है — लेकिन टुकड़े ऊपर से नहीं गिरते। आप 10×10 बोर्ड पर खुद रखते हैं।';

  @override
  String get aboutPlaceTitle => 'आकृतियाँ रखें';

  @override
  String get aboutPlaceBody =>
      'नीचे की ट्रे से बोर्ड पर खींचें। हमेशा तीन आकृतियाँ उपलब्ध होती हैं, छह और पूर्वावलोकन में।';

  @override
  String get aboutClearTitle => 'लाइनें साफ़ करें';

  @override
  String get aboutClearBody =>
      'पूरी पंक्ति या स्तंभ भरें तो वह साफ़ होकर अंक मिलते हैं।';

  @override
  String get aboutComboTitle => 'कॉम्बो बनाएँ';

  @override
  String get aboutComboBody =>
      'एक साथ कई लाइनें साफ़ करें तो कॉम्बो गुणक बढ़ता है।';

  @override
  String get aboutScoreTitle => 'रिकॉर्ड तोड़ें';

  @override
  String get aboutScoreBody =>
      'हर रखने और हर साफ़ लाइन पर अंक मिलते हैं। सर्वश्रेष्ठ स्कोर स्वतः सहेजा जाता है।';

  @override
  String get aboutEndTitle => 'गेम ओवर';

  @override
  String get aboutEndBody =>
      'जब कोई आकृति नहीं रखी जा सकती, गेम खत्म। कभी भी बाहर जाकर प्रगति सहेज सकते हैं।';
}
