// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline => 'Розміщуй блоки. Очищуй лінії. Побий свій рекорд.';

  @override
  String get highScore => 'Рекорд';

  @override
  String get play => 'Грати';

  @override
  String get gameOver => 'Гра завершена';

  @override
  String get scoreLabel => 'Рахунок';

  @override
  String gameOverScore(int score) {
    return 'Рахунок: $score';
  }

  @override
  String get playAgain => 'Грати знову';

  @override
  String get retry => 'Повторити';

  @override
  String get best => 'Найкращий';

  @override
  String get combo => 'Комбо';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => 'Далі';

  @override
  String get themesTooltip => 'Теми';

  @override
  String get chooseTheme => 'Оберіть тему';

  @override
  String get languageTooltip => 'Мова';

  @override
  String get chooseLanguage => 'Оберіть мову';

  @override
  String get themeWhite => 'Біла';

  @override
  String get themeBlack => 'Чорна';

  @override
  String get themeOcean => 'Океан';

  @override
  String get themeSunset => 'Захід';

  @override
  String get themeForest => 'Ліс';

  @override
  String get themeRose => 'Троянда';

  @override
  String get themeAmethyst => 'Аметист';

  @override
  String get themeSky => 'Небо';

  @override
  String get cancel => 'Скасувати';

  @override
  String get exitGameTitle => 'Вийти з гри?';

  @override
  String exitGameMessage(int score) {
    return 'Ваш поточний рахунок: $score. Зберегти прогрес чи скинути його?';
  }

  @override
  String get exitGameSave => 'Зберегти';

  @override
  String get exitGameDiscard => 'Скинути';

  @override
  String get continueGame => 'Продовжити';

  @override
  String get newGame => 'Нова гра';

  @override
  String get howToPlay => 'Як грати';

  @override
  String get aboutTitle => 'Про гру';

  @override
  String get aboutIntro =>
      'Stackline — це блок-пазл у стилі Tetris, але фігури не падають зверху. Ви самі обираєте, куди поставити кожну фігуру на полі 10×10.';

  @override
  String get aboutPlaceTitle => 'Розміщуй фігури';

  @override
  String get aboutPlaceBody =>
      'Перетягни фігури з нижньої панелі на поле. Завжди доступні три фігури, а ще шість чекають у ряду попереднього перегляду.';

  @override
  String get aboutClearTitle => 'Очищуй лінії';

  @override
  String get aboutClearBody =>
      'Заповни цілий ряд або стовпчик, щоб очистити його з поля та отримати очки.';

  @override
  String get aboutComboTitle => 'Збирай комбо';

  @override
  String get aboutComboBody =>
      'Очищай кілька ліній одночасно, щоб підвищити множник комбо та отримати більше очок.';

  @override
  String get aboutScoreTitle => 'Побий рекорд';

  @override
  String get aboutScoreBody =>
      'Кожне розміщення та кожна очищена лінія додають очки. Найкращий результат зберігається автоматично.';

  @override
  String get aboutEndTitle => 'Кінець гри';

  @override
  String get aboutEndBody =>
      'Гра закінчується, коли жодна з доступних фігур не може поміститися на полі. Можна вийти в будь-який момент і зберегти прогрес для продовження пізніше.';
}
