// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline => 'Układaj bloki. Czyść linie. Pobij swój rekord.';

  @override
  String get highScore => 'Rekord';

  @override
  String get play => 'Graj';

  @override
  String get gameOver => 'Koniec gry';

  @override
  String get scoreLabel => 'Wynik';

  @override
  String gameOverScore(int score) {
    return 'Wynik: $score';
  }

  @override
  String get playAgain => 'Zagraj ponownie';

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get best => 'Najlepszy';

  @override
  String get combo => 'Combo';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => 'Następne';

  @override
  String get themesTooltip => 'Motywy';

  @override
  String get chooseTheme => 'Wybierz motyw';

  @override
  String get languageTooltip => 'Język';

  @override
  String get chooseLanguage => 'Wybierz język';

  @override
  String get themeWhite => 'Biały';

  @override
  String get themeBlack => 'Czarny';

  @override
  String get themeOcean => 'Ocean';

  @override
  String get themeSunset => 'Zachód';

  @override
  String get themeForest => 'Las';

  @override
  String get themeRose => 'Róża';

  @override
  String get themeAmethyst => 'Ametyst';

  @override
  String get themeSky => 'Niebo';

  @override
  String get cancel => 'Anuluj';

  @override
  String get exitGameTitle => 'Opuścić grę?';

  @override
  String exitGameMessage(int score) {
    return 'Twój aktualny wynik to $score. Zapisać postęp czy go odrzucić?';
  }

  @override
  String get exitGameSave => 'Zapisz';

  @override
  String get exitGameDiscard => 'Odrzuć';

  @override
  String get continueGame => 'Kontynuuj';

  @override
  String get newGame => 'Nowa gra';

  @override
  String get howToPlay => 'Jak grać';

  @override
  String get aboutTitle => 'O grze';

  @override
  String get aboutIntro =>
      'Stackline to układanka blokowa inspirowana Tetrisem — ale klocki nie spadają z góry. Sam wybierasz, gdzie umieścić każdy kształt na planszy 10×10.';

  @override
  String get aboutPlaceTitle => 'Układaj kształty';

  @override
  String get aboutPlaceBody =>
      'Przeciągaj klocki z dolnego panelu na planszę. Zawsze masz trzy kształty do wyboru, a sześć kolejnych czeka w podglądzie.';

  @override
  String get aboutClearTitle => 'Czyść linie';

  @override
  String get aboutClearBody =>
      'Wypełnij cały wiersz lub kolumnę, aby go usunąć i zdobyć punkty.';

  @override
  String get aboutComboTitle => 'Buduj combo';

  @override
  String get aboutComboBody =>
      'Usuwaj wiele linii naraz, aby zwiększyć mnożnik combo i zdobyć więcej punktów.';

  @override
  String get aboutScoreTitle => 'Pobij rekord';

  @override
  String get aboutScoreBody =>
      'Każde ułożenie i każda wyczyszczona linia dodaje punkty. Twój najlepszy wynik jest zapisywany automatycznie.';

  @override
  String get aboutEndTitle => 'Koniec gry';

  @override
  String get aboutEndBody =>
      'Gra kończy się, gdy żaden dostępny kształt nie mieści się na planszy. Możesz wyjść w dowolnym momencie i zapisać postęp.';
}
