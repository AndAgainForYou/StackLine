// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline =>
      'Placez les blocs. Effacez les lignes. Battez votre record.';

  @override
  String get highScore => 'Meilleur score';

  @override
  String get play => 'Jouer';

  @override
  String get gameOver => 'Partie terminée';

  @override
  String get scoreLabel => 'Score';

  @override
  String gameOverScore(int score) {
    return 'Score : $score';
  }

  @override
  String get playAgain => 'Rejouer';

  @override
  String get retry => 'Réessayer';

  @override
  String get best => 'Meilleur';

  @override
  String get combo => 'Combo';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => 'Suivant';

  @override
  String get themesTooltip => 'Thèmes';

  @override
  String get chooseTheme => 'Choisir un thème';

  @override
  String get languageTooltip => 'Langue';

  @override
  String get chooseLanguage => 'Choisir une langue';

  @override
  String get themeWhite => 'Blanc';

  @override
  String get themeBlack => 'Noir';

  @override
  String get themeOcean => 'Océan';

  @override
  String get themeSunset => 'Coucher de soleil';

  @override
  String get themeForest => 'Forêt';

  @override
  String get themeRose => 'Rose';

  @override
  String get themeAmethyst => 'Améthyste';

  @override
  String get themeSky => 'Ciel';

  @override
  String get cancel => 'Annuler';

  @override
  String get exitGameTitle => 'Quitter la partie ?';

  @override
  String exitGameMessage(int score) {
    return 'Votre score actuel est $score. Enregistrer la progression ou l\'annuler ?';
  }

  @override
  String get exitGameSave => 'Enregistrer';

  @override
  String get exitGameDiscard => 'Abandonner';

  @override
  String get continueGame => 'Continuer';

  @override
  String get newGame => 'Nouvelle partie';

  @override
  String get howToPlay => 'Comment jouer';

  @override
  String get aboutTitle => 'À propos du jeu';

  @override
  String get aboutIntro =>
      'Stackline est un puzzle de blocs inspiré de Tetris — mais les pièces ne tombent pas du haut. Vous choisissez où placer chaque forme sur la grille 10×10.';

  @override
  String get aboutPlaceTitle => 'Placer les formes';

  @override
  String get aboutPlaceBody =>
      'Faites glisser les pièces depuis le bas vers la grille. Trois formes sont disponibles, six autres attendent dans l\'aperçu.';

  @override
  String get aboutClearTitle => 'Effacer les lignes';

  @override
  String get aboutClearBody =>
      'Remplissez une ligne ou une colonne entière pour l\'effacer et gagner des points.';

  @override
  String get aboutComboTitle => 'Enchaîner les combos';

  @override
  String get aboutComboBody =>
      'Effacez plusieurs lignes à la fois pour augmenter votre multiplicateur de combo.';

  @override
  String get aboutScoreTitle => 'Battre votre record';

  @override
  String get aboutScoreBody =>
      'Chaque placement et chaque ligne effacée ajoute des points. Votre meilleur score est enregistré automatiquement.';

  @override
  String get aboutEndTitle => 'Fin de partie';

  @override
  String get aboutEndBody =>
      'La partie se termine quand aucune forme disponible ne peut être placée. Vous pouvez quitter à tout moment et sauvegarder votre progression.';
}
