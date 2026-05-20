// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline => 'Coloca bloques. Limpia líneas. Supera tu récord.';

  @override
  String get highScore => 'Récord';

  @override
  String get play => 'Jugar';

  @override
  String get gameOver => 'Fin del juego';

  @override
  String get scoreLabel => 'Puntuación';

  @override
  String gameOverScore(int score) {
    return 'Puntuación: $score';
  }

  @override
  String get playAgain => 'Jugar de nuevo';

  @override
  String get retry => 'Reintentar';

  @override
  String get best => 'Mejor';

  @override
  String get combo => 'Combo';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => 'Siguiente';

  @override
  String get themesTooltip => 'Temas';

  @override
  String get chooseTheme => 'Elegir tema';

  @override
  String get languageTooltip => 'Idioma';

  @override
  String get chooseLanguage => 'Elegir idioma';

  @override
  String get themeWhite => 'Blanco';

  @override
  String get themeBlack => 'Negro';

  @override
  String get themeOcean => 'Océano';

  @override
  String get themeSunset => 'Atardecer';

  @override
  String get themeForest => 'Bosque';

  @override
  String get themeRose => 'Rosa';

  @override
  String get themeAmethyst => 'Amatista';

  @override
  String get themeSky => 'Cielo';

  @override
  String get cancel => 'Cancelar';

  @override
  String get exitGameTitle => '¿Salir del juego?';

  @override
  String exitGameMessage(int score) {
    return 'Tu puntuación actual es $score. ¿Guardar el progreso o descartarlo?';
  }

  @override
  String get exitGameSave => 'Guardar';

  @override
  String get exitGameDiscard => 'Descartar';

  @override
  String get continueGame => 'Continuar';

  @override
  String get newGame => 'Nueva partida';

  @override
  String get howToPlay => 'Cómo jugar';

  @override
  String get aboutTitle => 'Sobre el juego';

  @override
  String get aboutIntro =>
      'Stackline es un puzzle de bloques inspirado en Tetris, pero las piezas no caen desde arriba. Tú eliges dónde colocar cada forma en el tablero 10×10.';

  @override
  String get aboutPlaceTitle => 'Coloca formas';

  @override
  String get aboutPlaceBody =>
      'Arrastra piezas desde la bandeja inferior al tablero. Siempre tienes tres formas disponibles y seis más en la vista previa.';

  @override
  String get aboutClearTitle => 'Limpia líneas';

  @override
  String get aboutClearBody =>
      'Completa una fila o columna entera para eliminarla y ganar puntos.';

  @override
  String get aboutComboTitle => 'Haz combos';

  @override
  String get aboutComboBody =>
      'Limpia varias líneas a la vez para aumentar tu multiplicador de combo.';

  @override
  String get aboutScoreTitle => 'Supera tu récord';

  @override
  String get aboutScoreBody =>
      'Cada colocación y cada línea limpia suma puntos. Tu mejor puntuación se guarda automáticamente.';

  @override
  String get aboutEndTitle => 'Fin del juego';

  @override
  String get aboutEndBody =>
      'El juego termina cuando ninguna forma disponible cabe en el tablero. Puedes salir en cualquier momento y guardar tu progreso.';
}
