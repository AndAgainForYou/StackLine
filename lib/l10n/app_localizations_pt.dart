// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline => 'Coloque blocos. Limpe linhas. Supere seu recorde.';

  @override
  String get highScore => 'Recorde';

  @override
  String get play => 'Jogar';

  @override
  String get gameOver => 'Fim de jogo';

  @override
  String get scoreLabel => 'Pontuação';

  @override
  String gameOverScore(int score) {
    return 'Pontuação: $score';
  }

  @override
  String get playAgain => 'Jogar novamente';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get best => 'Melhor';

  @override
  String get combo => 'Combo';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => 'Próximo';

  @override
  String get themesTooltip => 'Temas';

  @override
  String get chooseTheme => 'Escolher tema';

  @override
  String get languageTooltip => 'Idioma';

  @override
  String get chooseLanguage => 'Escolher idioma';

  @override
  String get themeWhite => 'Branco';

  @override
  String get themeBlack => 'Preto';

  @override
  String get themeOcean => 'Oceano';

  @override
  String get themeSunset => 'Pôr do sol';

  @override
  String get themeForest => 'Floresta';

  @override
  String get themeRose => 'Rosa';

  @override
  String get themeAmethyst => 'Ametista';

  @override
  String get themeSky => 'Céu';

  @override
  String get cancel => 'Cancelar';

  @override
  String get exitGameTitle => 'Sair do jogo?';

  @override
  String exitGameMessage(int score) {
    return 'Sua pontuação atual é $score. Salvar o progresso ou descartá-lo?';
  }

  @override
  String get exitGameSave => 'Salvar';

  @override
  String get exitGameDiscard => 'Descartar';

  @override
  String get continueGame => 'Continuar';

  @override
  String get newGame => 'Novo jogo';

  @override
  String get howToPlay => 'Como jogar';

  @override
  String get aboutTitle => 'Sobre o jogo';

  @override
  String get aboutIntro =>
      'Stackline é um quebra-cabeça de blocos inspirado no Tetris — mas as peças não caem de cima. Você escolhe onde colocar cada forma no tabuleiro 10×10.';

  @override
  String get aboutPlaceTitle => 'Coloque formas';

  @override
  String get aboutPlaceBody =>
      'Arraste peças da bandeja inferior para o tabuleiro. Você sempre tem três formas disponíveis e mais seis na pré-visualização.';

  @override
  String get aboutClearTitle => 'Limpe linhas';

  @override
  String get aboutClearBody =>
      'Preencha uma linha ou coluna inteira para removê-la e ganhar pontos.';

  @override
  String get aboutComboTitle => 'Faça combos';

  @override
  String get aboutComboBody =>
      'Limpe várias linhas de uma vez para aumentar seu multiplicador de combo.';

  @override
  String get aboutScoreTitle => 'Supere seu recorde';

  @override
  String get aboutScoreBody =>
      'Cada colocação e cada linha limpa soma pontos. Seu melhor resultado é salvo automaticamente.';

  @override
  String get aboutEndTitle => 'Fim de jogo';

  @override
  String get aboutEndBody =>
      'O jogo termina quando nenhuma forma disponível cabe no tabuleiro. Você pode sair a qualquer momento e salvar seu progresso.';
}
