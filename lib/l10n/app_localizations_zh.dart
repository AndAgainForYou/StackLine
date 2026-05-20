// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline => '放置方块，消除行列，打破纪录。';

  @override
  String get highScore => '最高分';

  @override
  String get play => '开始游戏';

  @override
  String get gameOver => '游戏结束';

  @override
  String get scoreLabel => '分数';

  @override
  String gameOverScore(int score) {
    return '分数：$score';
  }

  @override
  String get playAgain => '再玩一次';

  @override
  String get retry => '重试';

  @override
  String get best => '最佳';

  @override
  String get combo => '连击';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => '下一个';

  @override
  String get themesTooltip => '主题';

  @override
  String get chooseTheme => '选择主题';

  @override
  String get languageTooltip => '语言';

  @override
  String get chooseLanguage => '选择语言';

  @override
  String get themeWhite => '白色';

  @override
  String get themeBlack => '黑色';

  @override
  String get themeOcean => '海洋';

  @override
  String get themeSunset => '日落';

  @override
  String get themeForest => '森林';

  @override
  String get themeRose => '玫瑰';

  @override
  String get themeAmethyst => '紫水晶';

  @override
  String get themeSky => '天空';

  @override
  String get cancel => '取消';

  @override
  String get exitGameTitle => '离开游戏？';

  @override
  String exitGameMessage(int score) {
    return '当前分数为 $score。要保存进度还是放弃？';
  }

  @override
  String get exitGameSave => '保存进度';

  @override
  String get exitGameDiscard => '放弃';

  @override
  String get continueGame => '继续游戏';

  @override
  String get newGame => '新游戏';

  @override
  String get howToPlay => '玩法说明';

  @override
  String get aboutTitle => '关于游戏';

  @override
  String get aboutIntro =>
      'Stackline 是一款受俄罗斯方块启发的方块拼图，但方块不会从顶部落下。你需要在 10×10 棋盘上自行放置。';

  @override
  String get aboutPlaceTitle => '放置方块';

  @override
  String get aboutPlaceBody => '从底部拖放方块到棋盘。始终有三个可选方块，预览区还有六个。';

  @override
  String get aboutClearTitle => '消除行列';

  @override
  String get aboutClearBody => '填满整行或整列即可消除并获得分数。';

  @override
  String get aboutComboTitle => '连击加分';

  @override
  String get aboutComboBody => '同时消除多行可提高连击倍率，获得更高分数。';

  @override
  String get aboutScoreTitle => '挑战最高分';

  @override
  String get aboutScoreBody => '每次放置和消除都会加分，最高分会自动保存。';

  @override
  String get aboutEndTitle => '游戏结束';

  @override
  String get aboutEndBody => '当没有方块可以放置时游戏结束。可随时退出并保存进度。';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline => '放置方塊，消除行列，打破紀錄。';

  @override
  String get highScore => '最高分';

  @override
  String get play => '開始遊戲';

  @override
  String get gameOver => '遊戲結束';

  @override
  String get scoreLabel => '分數';

  @override
  String gameOverScore(int score) {
    return '分數：$score';
  }

  @override
  String get playAgain => '再玩一次';

  @override
  String get retry => '重試';

  @override
  String get best => '最佳';

  @override
  String get combo => '連擊';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => '下一個';

  @override
  String get themesTooltip => '主題';

  @override
  String get chooseTheme => '選擇主題';

  @override
  String get languageTooltip => '語言';

  @override
  String get chooseLanguage => '選擇語言';

  @override
  String get themeWhite => '白色';

  @override
  String get themeBlack => '黑色';

  @override
  String get themeOcean => '海洋';

  @override
  String get themeSunset => '日落';

  @override
  String get themeForest => '森林';

  @override
  String get themeRose => '玫瑰';

  @override
  String get themeAmethyst => '紫水晶';

  @override
  String get themeSky => '天空';

  @override
  String get cancel => '取消';

  @override
  String get exitGameTitle => '離開遊戲？';

  @override
  String exitGameMessage(int score) {
    return '目前分數為 $score。要儲存進度還是放棄？';
  }

  @override
  String get exitGameSave => '儲存進度';

  @override
  String get exitGameDiscard => '放棄';

  @override
  String get continueGame => '繼續遊戲';

  @override
  String get newGame => '新遊戲';

  @override
  String get howToPlay => '玩法說明';

  @override
  String get aboutTitle => '關於遊戲';

  @override
  String get aboutIntro =>
      'Stackline 是一款受俄羅斯方塊啟發的方塊拼圖，但方塊不會從頂部落下。你需要在 10×10 棋盤上自行放置。';

  @override
  String get aboutPlaceTitle => '放置方塊';

  @override
  String get aboutPlaceBody => '從底部拖放方塊到棋盤。始終有三個可選方塊，預覽區還有六個。';

  @override
  String get aboutClearTitle => '消除行列';

  @override
  String get aboutClearBody => '填滿整行或整列即可消除並獲得分數。';

  @override
  String get aboutComboTitle => '連擊加分';

  @override
  String get aboutComboBody => '同時消除多行可提高連擊倍率，獲得更高分數。';

  @override
  String get aboutScoreTitle => '挑戰最高分';

  @override
  String get aboutScoreBody => '每次放置和消除都會加分，最高分會自動儲存。';

  @override
  String get aboutEndTitle => '遊戲結束';

  @override
  String get aboutEndBody => '當沒有方塊可以放置時遊戲結束。可隨時退出並儲存進度。';
}
