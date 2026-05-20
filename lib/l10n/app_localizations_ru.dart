// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline => 'Размещай блоки. Очищай линии. Побей свой рекорд.';

  @override
  String get highScore => 'Рекорд';

  @override
  String get play => 'Играть';

  @override
  String get gameOver => 'Игра окончена';

  @override
  String get scoreLabel => 'Счёт';

  @override
  String gameOverScore(int score) {
    return 'Счёт: $score';
  }

  @override
  String get playAgain => 'Играть снова';

  @override
  String get retry => 'Повторить';

  @override
  String get best => 'Лучший';

  @override
  String get combo => 'Комбо';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => 'Далее';

  @override
  String get themesTooltip => 'Темы';

  @override
  String get chooseTheme => 'Выберите тему';

  @override
  String get languageTooltip => 'Язык';

  @override
  String get chooseLanguage => 'Выберите язык';

  @override
  String get themeWhite => 'Белая';

  @override
  String get themeBlack => 'Чёрная';

  @override
  String get themeOcean => 'Океан';

  @override
  String get themeSunset => 'Закат';

  @override
  String get themeForest => 'Лес';

  @override
  String get themeRose => 'Роза';

  @override
  String get themeAmethyst => 'Аметист';

  @override
  String get themeSky => 'Небо';

  @override
  String get cancel => 'Отмена';

  @override
  String get exitGameTitle => 'Выйти из игры?';

  @override
  String exitGameMessage(int score) {
    return 'Ваш текущий счёт: $score. Сохранить прогресс или сбросить его?';
  }

  @override
  String get exitGameSave => 'Сохранить';

  @override
  String get exitGameDiscard => 'Сбросить';

  @override
  String get continueGame => 'Продолжить';

  @override
  String get newGame => 'Новая игра';

  @override
  String get howToPlay => 'Как играть';

  @override
  String get aboutTitle => 'Об игре';

  @override
  String get aboutIntro =>
      'Stackline — блочная головоломка в духе Tetris, но фигуры не падают сверху. Вы сами выбираете, куда поставить каждую фигуру на поле 10×10.';

  @override
  String get aboutPlaceTitle => 'Размещай фигуры';

  @override
  String get aboutPlaceBody =>
      'Перетаскивай фигуры с нижней панели на поле. Всегда доступны три фигуры, ещё шесть ждут в ряду предпросмотра.';

  @override
  String get aboutClearTitle => 'Очищай линии';

  @override
  String get aboutClearBody =>
      'Заполни целый ряд или столбец, чтобы очистить его с поля и получить очки.';

  @override
  String get aboutComboTitle => 'Собирай комбо';

  @override
  String get aboutComboBody =>
      'Очищай несколько линий за раз, чтобы увеличить множитель комбо и получить больше очков.';

  @override
  String get aboutScoreTitle => 'Побей рекорд';

  @override
  String get aboutScoreBody =>
      'Каждое размещение и каждая очищенная линия добавляют очки. Лучший результат сохраняется автоматически.';

  @override
  String get aboutEndTitle => 'Конец игры';

  @override
  String get aboutEndBody =>
      'Игра заканчивается, когда ни одна из доступных фигур не помещается на поле. Можно выйти в любой момент и сохранить прогресс для продолжения позже.';
}
