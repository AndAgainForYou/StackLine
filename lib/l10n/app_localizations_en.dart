// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline => 'Place blocks. Clear lines. Beat your record.';

  @override
  String get highScore => 'High Score';

  @override
  String get play => 'Play';

  @override
  String get gameOver => 'Game Over';

  @override
  String get scoreLabel => 'Score';

  @override
  String gameOverScore(int score) {
    return 'Score: $score';
  }

  @override
  String get playAgain => 'Play Again';

  @override
  String get retry => 'Retry';

  @override
  String get best => 'Best';

  @override
  String get combo => 'Combo';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => 'Next';

  @override
  String get themesTooltip => 'Themes';

  @override
  String get chooseTheme => 'Choose theme';

  @override
  String get languageTooltip => 'Language';

  @override
  String get chooseLanguage => 'Choose language';

  @override
  String get themeWhite => 'White';

  @override
  String get themeBlack => 'Black';

  @override
  String get themeOcean => 'Ocean';

  @override
  String get themeSunset => 'Sunset';

  @override
  String get themeForest => 'Forest';

  @override
  String get themeRose => 'Rose';

  @override
  String get themeAmethyst => 'Amethyst';

  @override
  String get themeSky => 'Sky';

  @override
  String get cancel => 'Cancel';

  @override
  String get exitGameTitle => 'Leave game?';

  @override
  String exitGameMessage(int score) {
    return 'Your current score is $score. Save your progress or discard it?';
  }

  @override
  String get exitGameSave => 'Save progress';

  @override
  String get exitGameDiscard => 'Discard';

  @override
  String get continueGame => 'Continue';

  @override
  String get newGame => 'New game';

  @override
  String get howToPlay => 'How to play';

  @override
  String get aboutTitle => 'About the game';

  @override
  String get aboutIntro =>
      'Stackline is a block puzzle inspired by Tetris — but pieces don\'t fall from the top. You choose where each shape goes and build your own strategy on a 10×10 board.';

  @override
  String get aboutPlaceTitle => 'Place shapes';

  @override
  String get aboutPlaceBody =>
      'Drag pieces from the bottom tray onto the board. You always have three shapes to choose from, with six more waiting in the preview row.';

  @override
  String get aboutClearTitle => 'Clear lines';

  @override
  String get aboutClearBody =>
      'Fill an entire row or column to clear it from the board and earn points.';

  @override
  String get aboutComboTitle => 'Build combos';

  @override
  String get aboutComboBody =>
      'Clear multiple lines at once to increase your combo multiplier and score bigger rewards.';

  @override
  String get aboutScoreTitle => 'Beat your record';

  @override
  String get aboutScoreBody =>
      'Every placement and every cleared line adds to your score. Your best result is saved automatically.';

  @override
  String get aboutEndTitle => 'Game over';

  @override
  String get aboutEndBody =>
      'The game ends when none of the available shapes can fit on the board. Leave anytime to save your progress and continue later.';
}
