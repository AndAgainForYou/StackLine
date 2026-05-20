// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline => '블록을 배치하고, 줄을 지우고, 기록을 갱신하세요.';

  @override
  String get highScore => '최고 점수';

  @override
  String get play => '플레이';

  @override
  String get gameOver => '게임 오버';

  @override
  String get scoreLabel => '점수';

  @override
  String gameOverScore(int score) {
    return '점수: $score';
  }

  @override
  String get playAgain => '다시 하기';

  @override
  String get retry => '재시도';

  @override
  String get best => '최고';

  @override
  String get combo => '콤보';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => '다음';

  @override
  String get themesTooltip => '테마';

  @override
  String get chooseTheme => '테마 선택';

  @override
  String get languageTooltip => '언어';

  @override
  String get chooseLanguage => '언어 선택';

  @override
  String get themeWhite => '화이트';

  @override
  String get themeBlack => '블랙';

  @override
  String get themeOcean => '오션';

  @override
  String get themeSunset => '선셋';

  @override
  String get themeForest => '포레스트';

  @override
  String get themeRose => '로즈';

  @override
  String get themeAmethyst => '자수정';

  @override
  String get themeSky => '스카이';

  @override
  String get cancel => '취소';

  @override
  String get exitGameTitle => '게임을 나가시겠습니까?';

  @override
  String exitGameMessage(int score) {
    return '현재 점수는 $score입니다. 진행 상황을 저장하시겠습니까, 아니면 버리시겠습니까?';
  }

  @override
  String get exitGameSave => '저장';

  @override
  String get exitGameDiscard => '버리기';

  @override
  String get continueGame => '이어하기';

  @override
  String get newGame => '새 게임';

  @override
  String get howToPlay => '게임 방법';

  @override
  String get aboutTitle => '게임 소개';

  @override
  String get aboutIntro =>
      'Stackline은 테트리스 스타일의 블록 퍼즐이지만, 블록이 위에서 떨어지지 않습니다. 10×10 보드에 직접 배치하세요.';

  @override
  String get aboutPlaceTitle => '블록 배치';

  @override
  String get aboutPlaceBody =>
      '하단 트레이에서 보드로 블록을 드래그하세요. 항상 3개를 사용할 수 있고, 6개가 미리보기에 있습니다.';

  @override
  String get aboutClearTitle => '줄 제거';

  @override
  String get aboutClearBody => '가로줄이나 세로줄을 가득 채우면 제거되고 점수를 얻습니다.';

  @override
  String get aboutComboTitle => '콤보 만들기';

  @override
  String get aboutComboBody => '여러 줄을 동시에 제거하면 콤보 배율이 올라 더 많은 점수를 얻습니다.';

  @override
  String get aboutScoreTitle => '기록 갱신';

  @override
  String get aboutScoreBody => '배치와 줄 제거마다 점수가 올라갑니다. 최고 점수는 자동 저장됩니다.';

  @override
  String get aboutEndTitle => '게임 오버';

  @override
  String get aboutEndBody =>
      '놓을 수 있는 블록이 없으면 게임이 끝납니다. 언제든 나가서 진행 상황을 저장할 수 있습니다.';
}
