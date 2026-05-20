// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline => 'ブロックを置いて、ラインを消し、記録を更新しよう。';

  @override
  String get highScore => 'ハイスコア';

  @override
  String get play => 'プレイ';

  @override
  String get gameOver => 'ゲームオーバー';

  @override
  String get scoreLabel => 'スコア';

  @override
  String gameOverScore(int score) {
    return 'スコア: $score';
  }

  @override
  String get playAgain => 'もう一度';

  @override
  String get retry => 'リトライ';

  @override
  String get best => 'ベスト';

  @override
  String get combo => 'コンボ';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => '次';

  @override
  String get themesTooltip => 'テーマ';

  @override
  String get chooseTheme => 'テーマを選択';

  @override
  String get languageTooltip => '言語';

  @override
  String get chooseLanguage => '言語を選択';

  @override
  String get themeWhite => 'ホワイト';

  @override
  String get themeBlack => 'ブラック';

  @override
  String get themeOcean => 'オーシャン';

  @override
  String get themeSunset => 'サンセット';

  @override
  String get themeForest => 'フォレスト';

  @override
  String get themeRose => 'ローズ';

  @override
  String get themeAmethyst => 'アメジスト';

  @override
  String get themeSky => 'スカイ';

  @override
  String get cancel => 'キャンセル';

  @override
  String get exitGameTitle => 'ゲームを終了しますか？';

  @override
  String exitGameMessage(int score) {
    return '現在のスコアは $score です。進行状況を保存しますか、それとも破棄しますか？';
  }

  @override
  String get exitGameSave => '保存';

  @override
  String get exitGameDiscard => '破棄';

  @override
  String get continueGame => '続ける';

  @override
  String get newGame => '新しいゲーム';

  @override
  String get howToPlay => '遊び方';

  @override
  String get aboutTitle => 'ゲームについて';

  @override
  String get aboutIntro =>
      'Stacklineはテトリス風のブロックパズルですが、ピースは上から落ちてきません。10×10の盤面に自分で配置します。';

  @override
  String get aboutPlaceTitle => 'ブロックを配置';

  @override
  String get aboutPlaceBody =>
      '下のトレイから盤面にドラッグします。常に3つのピースが使え、さらに6つがプレビューに表示されます。';

  @override
  String get aboutClearTitle => 'ラインを消す';

  @override
  String get aboutClearBody => '行または列を完全に埋めると消えてポイントが入ります。';

  @override
  String get aboutComboTitle => 'コンボを狙う';

  @override
  String get aboutComboBody => '複数のラインを同時に消すとコンボ倍率が上がり、高得点になります。';

  @override
  String get aboutScoreTitle => '記録を更新';

  @override
  String get aboutScoreBody => '配置とライン消去でスコアが増えます。最高スコアは自動保存されます。';

  @override
  String get aboutEndTitle => 'ゲームオーバー';

  @override
  String get aboutEndBody => '置けるピースがなくなると終了です。いつでも退出して進行状況を保存できます。';
}
