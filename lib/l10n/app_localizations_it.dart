// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline =>
      'Posiziona i blocchi. Cancella le linee. Batti il tuo record.';

  @override
  String get highScore => 'Record';

  @override
  String get play => 'Gioca';

  @override
  String get gameOver => 'Game over';

  @override
  String get scoreLabel => 'Punteggio';

  @override
  String gameOverScore(int score) {
    return 'Punteggio: $score';
  }

  @override
  String get playAgain => 'Gioca ancora';

  @override
  String get retry => 'Riprova';

  @override
  String get best => 'Migliore';

  @override
  String get combo => 'Combo';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => 'Prossimo';

  @override
  String get themesTooltip => 'Temi';

  @override
  String get chooseTheme => 'Scegli tema';

  @override
  String get languageTooltip => 'Lingua';

  @override
  String get chooseLanguage => 'Scegli lingua';

  @override
  String get themeWhite => 'Bianco';

  @override
  String get themeBlack => 'Nero';

  @override
  String get themeOcean => 'Oceano';

  @override
  String get themeSunset => 'Tramonto';

  @override
  String get themeForest => 'Foresta';

  @override
  String get themeRose => 'Rosa';

  @override
  String get themeAmethyst => 'Ametista';

  @override
  String get themeSky => 'Cielo';

  @override
  String get cancel => 'Annulla';

  @override
  String get exitGameTitle => 'Uscire dal gioco?';

  @override
  String exitGameMessage(int score) {
    return 'Il tuo punteggio attuale è $score. Salvare i progressi o annullarli?';
  }

  @override
  String get exitGameSave => 'Salva';

  @override
  String get exitGameDiscard => 'Scarta';

  @override
  String get continueGame => 'Continua';

  @override
  String get newGame => 'Nuova partita';

  @override
  String get howToPlay => 'Come giocare';

  @override
  String get aboutTitle => 'Informazioni sul gioco';

  @override
  String get aboutIntro =>
      'Stackline è un puzzle a blocchi ispirato a Tetris — ma i pezzi non cadono dall\'alto. Scegli tu dove posizionare ogni forma sulla griglia 10×10.';

  @override
  String get aboutPlaceTitle => 'Posiziona le forme';

  @override
  String get aboutPlaceBody =>
      'Trascina i pezzi dal vassoio in basso sulla griglia. Hai sempre tre forme disponibili e altre sei in anteprima.';

  @override
  String get aboutClearTitle => 'Cancella le linee';

  @override
  String get aboutClearBody =>
      'Completa un\'intera riga o colonna per rimuoverla e guadagnare punti.';

  @override
  String get aboutComboTitle => 'Fai combo';

  @override
  String get aboutComboBody =>
      'Cancella più linee insieme per aumentare il moltiplicatore combo.';

  @override
  String get aboutScoreTitle => 'Batti il record';

  @override
  String get aboutScoreBody =>
      'Ogni posizionamento e ogni linea cancellata aggiunge punti. Il tuo miglior punteggio viene salvato automaticamente.';

  @override
  String get aboutEndTitle => 'Game over';

  @override
  String get aboutEndBody =>
      'Il gioco finisce quando nessuna forma disponibile può essere posizionata. Puoi uscire in qualsiasi momento e salvare i progressi.';
}
