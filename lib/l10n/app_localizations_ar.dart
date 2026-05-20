// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline => 'ضع المكعبات. امسح الخطوط. اكسر رقمك القياسي.';

  @override
  String get highScore => 'أعلى نتيجة';

  @override
  String get play => 'العب';

  @override
  String get gameOver => 'انتهت اللعبة';

  @override
  String get scoreLabel => 'النتيجة';

  @override
  String gameOverScore(int score) {
    return 'النتيجة: $score';
  }

  @override
  String get playAgain => 'العب مجددًا';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get best => 'الأفضل';

  @override
  String get combo => 'كومبو';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => 'التالي';

  @override
  String get themesTooltip => 'السمات';

  @override
  String get chooseTheme => 'اختر سمة';

  @override
  String get languageTooltip => 'اللغة';

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get themeWhite => 'أبيض';

  @override
  String get themeBlack => 'أسود';

  @override
  String get themeOcean => 'المحيط';

  @override
  String get themeSunset => 'الغروب';

  @override
  String get themeForest => 'الغابة';

  @override
  String get themeRose => 'الورد';

  @override
  String get themeAmethyst => 'جمشت';

  @override
  String get themeSky => 'السماء';

  @override
  String get cancel => 'إلغاء';

  @override
  String get exitGameTitle => 'مغادرة اللعبة؟';

  @override
  String exitGameMessage(int score) {
    return 'نتيجتك الحالية $score. هل تريد حفظ التقدم أم تجاهله؟';
  }

  @override
  String get exitGameSave => 'حفظ';

  @override
  String get exitGameDiscard => 'تجاهل';

  @override
  String get continueGame => 'متابعة';

  @override
  String get newGame => 'لعبة جديدة';

  @override
  String get howToPlay => 'كيفية اللعب';

  @override
  String get aboutTitle => 'عن اللعبة';

  @override
  String get aboutIntro =>
      'Stackline لعبة ألغاز مكعبات مستوحاة من Tetris — لكن القطع لا تسقط من الأعلى. أنت تختار مكان كل شكل على لوحة 10×10.';

  @override
  String get aboutPlaceTitle => 'ضع الأشكال';

  @override
  String get aboutPlaceBody =>
      'اسحب القطع من الشريط السفلي إلى اللوحة. لديك دائمًا ثلاثة أشكال، وستة أخرى في المعاينة.';

  @override
  String get aboutClearTitle => 'امسح الخطوط';

  @override
  String get aboutClearBody =>
      'املأ صفًا أو عمودًا بالكامل لمسحه والحصول على نقاط.';

  @override
  String get aboutComboTitle => 'كوّن combos';

  @override
  String get aboutComboBody => 'امسح عدة خطوط دفعة واحدة لزيادة مضاعف الكومبو.';

  @override
  String get aboutScoreTitle => 'حطّم رقمك';

  @override
  String get aboutScoreBody =>
      'كل وضع وكل خط يُمسح يضيف نقاطًا. يُحفظ أفضل نتيجة تلقائيًا.';

  @override
  String get aboutEndTitle => 'نهاية اللعبة';

  @override
  String get aboutEndBody =>
      'تنتهي اللعبة عندما لا يمكن وضع أي شكل. يمكنك المغادرة في أي وقت وحفظ تقدمك.';
}
