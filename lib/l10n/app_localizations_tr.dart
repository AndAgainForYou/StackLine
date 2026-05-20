// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline =>
      'Blokları yerleştir. Satırları temizle. Rekorunu kır.';

  @override
  String get highScore => 'En Yüksek Skor';

  @override
  String get play => 'Oyna';

  @override
  String get gameOver => 'Oyun Bitti';

  @override
  String get scoreLabel => 'Skor';

  @override
  String gameOverScore(int score) {
    return 'Skor: $score';
  }

  @override
  String get playAgain => 'Tekrar Oyna';

  @override
  String get retry => 'Yeniden Dene';

  @override
  String get best => 'En İyi';

  @override
  String get combo => 'Kombo';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => 'Sonraki';

  @override
  String get themesTooltip => 'Temalar';

  @override
  String get chooseTheme => 'Tema seç';

  @override
  String get languageTooltip => 'Dil';

  @override
  String get chooseLanguage => 'Dil seç';

  @override
  String get themeWhite => 'Beyaz';

  @override
  String get themeBlack => 'Siyah';

  @override
  String get themeOcean => 'Okyanus';

  @override
  String get themeSunset => 'Gün Batımı';

  @override
  String get themeForest => 'Orman';

  @override
  String get themeRose => 'Gül';

  @override
  String get themeAmethyst => 'Ametist';

  @override
  String get themeSky => 'Gökyüzü';

  @override
  String get cancel => 'İptal';

  @override
  String get exitGameTitle => 'Oyundan çık?';

  @override
  String exitGameMessage(int score) {
    return 'Mevcut skorunuz $score. İlerlemeyi kaydetmek mi yoksa silmek mi istiyorsunuz?';
  }

  @override
  String get exitGameSave => 'Kaydet';

  @override
  String get exitGameDiscard => 'Sil';

  @override
  String get continueGame => 'Devam et';

  @override
  String get newGame => 'Yeni oyun';

  @override
  String get howToPlay => 'Nasıl oynanır';

  @override
  String get aboutTitle => 'Oyun hakkında';

  @override
  String get aboutIntro =>
      'Stackline, Tetris\'ten ilham alan bir blok bulmacasıdır — ama parçalar yukarıdan düşmez. Her şekli 10×10 tahtaya kendiniz yerleştirirsiniz.';

  @override
  String get aboutPlaceTitle => 'Şekilleri yerleştir';

  @override
  String get aboutPlaceBody =>
      'Alt tepsiden tahtaya sürükleyin. Her zaman üç şekil vardır, altı tanesi daha önizlemede bekler.';

  @override
  String get aboutClearTitle => 'Satırları temizle';

  @override
  String get aboutClearBody =>
      'Tam bir satır veya sütunu doldurun, temizlensin ve puan kazanın.';

  @override
  String get aboutComboTitle => 'Kombo yap';

  @override
  String get aboutComboBody =>
      'Birden fazla satırı aynı anda temizleyerek kombo çarpanını artırın.';

  @override
  String get aboutScoreTitle => 'Rekoru kır';

  @override
  String get aboutScoreBody =>
      'Her yerleştirme ve her temiz satır puan ekler. En iyi skor otomatik kaydedilir.';

  @override
  String get aboutEndTitle => 'Oyun bitti';

  @override
  String get aboutEndBody =>
      'Hiçbir şekil sığmadığında oyun biter. İstediğiniz zaman çıkıp ilerlemenizi kaydedebilirsiniz.';
}
