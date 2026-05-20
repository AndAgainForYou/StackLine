// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline =>
      'Platziere Blöcke. Räume Linien. Schlage deinen Rekord.';

  @override
  String get highScore => 'Highscore';

  @override
  String get play => 'Spielen';

  @override
  String get gameOver => 'Spiel vorbei';

  @override
  String get scoreLabel => 'Punkte';

  @override
  String gameOverScore(int score) {
    return 'Punkte: $score';
  }

  @override
  String get playAgain => 'Nochmal spielen';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get best => 'Beste';

  @override
  String get combo => 'Combo';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => 'Nächste';

  @override
  String get themesTooltip => 'Themes';

  @override
  String get chooseTheme => 'Theme wählen';

  @override
  String get languageTooltip => 'Sprache';

  @override
  String get chooseLanguage => 'Sprache wählen';

  @override
  String get themeWhite => 'Weiß';

  @override
  String get themeBlack => 'Schwarz';

  @override
  String get themeOcean => 'Ozean';

  @override
  String get themeSunset => 'Sonnenuntergang';

  @override
  String get themeForest => 'Wald';

  @override
  String get themeRose => 'Rose';

  @override
  String get themeAmethyst => 'Amethyst';

  @override
  String get themeSky => 'Himmel';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get exitGameTitle => 'Spiel verlassen?';

  @override
  String exitGameMessage(int score) {
    return 'Dein aktueller Punktestand ist $score. Fortschritt speichern oder verwerfen?';
  }

  @override
  String get exitGameSave => 'Speichern';

  @override
  String get exitGameDiscard => 'Verwerfen';

  @override
  String get continueGame => 'Fortsetzen';

  @override
  String get newGame => 'Neues Spiel';

  @override
  String get howToPlay => 'Spielanleitung';

  @override
  String get aboutTitle => 'Über das Spiel';

  @override
  String get aboutIntro =>
      'Stackline ist ein Blockpuzzle inspiriert von Tetris — aber die Steine fallen nicht von oben. Du entscheidest, wohin jede Form auf dem 10×10-Feld kommt.';

  @override
  String get aboutPlaceTitle => 'Formen platzieren';

  @override
  String get aboutPlaceBody =>
      'Ziehe Steine aus dem unteren Bereich auf das Feld. Du hast immer drei Formen zur Auswahl, sechs weitere warten in der Vorschau.';

  @override
  String get aboutClearTitle => 'Linien räumen';

  @override
  String get aboutClearBody =>
      'Fülle eine ganze Reihe oder Spalte, um sie zu entfernen und Punkte zu erhalten.';

  @override
  String get aboutComboTitle => 'Combos bauen';

  @override
  String get aboutComboBody =>
      'Räume mehrere Linien gleichzeitig, um deinen Combo-Multiplikator zu erhöhen.';

  @override
  String get aboutScoreTitle => 'Rekord schlagen';

  @override
  String get aboutScoreBody =>
      'Jede Platzierung und jede Linie bringt Punkte. Dein bestes Ergebnis wird automatisch gespeichert.';

  @override
  String get aboutEndTitle => 'Spielende';

  @override
  String get aboutEndBody =>
      'Das Spiel endet, wenn keine verfügbare Form mehr passt. Du kannst jederzeit gehen und deinen Fortschritt speichern.';
}
