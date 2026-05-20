// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline =>
      'Plaats blokken. Maak lijnen schoon. Verbreek je record.';

  @override
  String get highScore => 'Hoogste score';

  @override
  String get play => 'Spelen';

  @override
  String get gameOver => 'Game over';

  @override
  String get scoreLabel => 'Score';

  @override
  String gameOverScore(int score) {
    return 'Score: $score';
  }

  @override
  String get playAgain => 'Opnieuw spelen';

  @override
  String get retry => 'Opnieuw proberen';

  @override
  String get best => 'Beste';

  @override
  String get combo => 'Combo';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => 'Volgende';

  @override
  String get themesTooltip => 'Thema\'s';

  @override
  String get chooseTheme => 'Kies thema';

  @override
  String get languageTooltip => 'Taal';

  @override
  String get chooseLanguage => 'Kies taal';

  @override
  String get themeWhite => 'Wit';

  @override
  String get themeBlack => 'Zwart';

  @override
  String get themeOcean => 'Oceaan';

  @override
  String get themeSunset => 'Zonsondergang';

  @override
  String get themeForest => 'Bos';

  @override
  String get themeRose => 'Roos';

  @override
  String get themeAmethyst => 'Amethist';

  @override
  String get themeSky => 'Lucht';

  @override
  String get cancel => 'Annuleren';

  @override
  String get exitGameTitle => 'Spel verlaten?';

  @override
  String exitGameMessage(int score) {
    return 'Je huidige score is $score. Voortgang opslaan of verwerpen?';
  }

  @override
  String get exitGameSave => 'Opslaan';

  @override
  String get exitGameDiscard => 'Verwerpen';

  @override
  String get continueGame => 'Doorgaan';

  @override
  String get newGame => 'Nieuw spel';

  @override
  String get howToPlay => 'Hoe te spelen';

  @override
  String get aboutTitle => 'Over het spel';

  @override
  String get aboutIntro =>
      'Stackline is een blokpuzzel geïnspireerd op Tetris — maar stukken vallen niet van boven. Jij kiest waar elke vorm op het 10×10-bord komt.';

  @override
  String get aboutPlaceTitle => 'Plaats vormen';

  @override
  String get aboutPlaceBody =>
      'Sleep stukken van het onderste vak naar het bord. Je hebt altijd drie vormen, zes andere staan in de preview.';

  @override
  String get aboutClearTitle => 'Maak lijnen schoon';

  @override
  String get aboutClearBody =>
      'Vul een hele rij of kolom om deze te wissen en punten te verdienen.';

  @override
  String get aboutComboTitle => 'Bouw combos';

  @override
  String get aboutComboBody =>
      'Wis meerdere lijnen tegelijk om je combo-vermenigvuldiger te verhogen.';

  @override
  String get aboutScoreTitle => 'Verbreek je record';

  @override
  String get aboutScoreBody =>
      'Elke plaatsing en elke gewiste lijn levert punten op. Je beste score wordt automatisch opgeslagen.';

  @override
  String get aboutEndTitle => 'Game over';

  @override
  String get aboutEndBody =>
      'Het spel eindigt wanneer geen enkele vorm meer past. Je kunt altijd stoppen en je voortgang opslaan.';
}
