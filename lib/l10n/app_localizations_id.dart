// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline => 'Letakkan blok. Hapus baris. Pecahkan rekor Anda.';

  @override
  String get highScore => 'Skor Tertinggi';

  @override
  String get play => 'Main';

  @override
  String get gameOver => 'Permainan Selesai';

  @override
  String get scoreLabel => 'Skor';

  @override
  String gameOverScore(int score) {
    return 'Skor: $score';
  }

  @override
  String get playAgain => 'Main Lagi';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get best => 'Terbaik';

  @override
  String get combo => 'Combo';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => 'Berikutnya';

  @override
  String get themesTooltip => 'Tema';

  @override
  String get chooseTheme => 'Pilih tema';

  @override
  String get languageTooltip => 'Bahasa';

  @override
  String get chooseLanguage => 'Pilih bahasa';

  @override
  String get themeWhite => 'Putih';

  @override
  String get themeBlack => 'Hitam';

  @override
  String get themeOcean => 'Laut';

  @override
  String get themeSunset => 'Matahari Terbenam';

  @override
  String get themeForest => 'Hutan';

  @override
  String get themeRose => 'Mawar';

  @override
  String get themeAmethyst => 'Amethyst';

  @override
  String get themeSky => 'Langit';

  @override
  String get cancel => 'Batal';

  @override
  String get exitGameTitle => 'Keluar dari permainan?';

  @override
  String exitGameMessage(int score) {
    return 'Skor Anda saat ini $score. Simpan progres atau buang?';
  }

  @override
  String get exitGameSave => 'Simpan';

  @override
  String get exitGameDiscard => 'Buang';

  @override
  String get continueGame => 'Lanjutkan';

  @override
  String get newGame => 'Permainan baru';

  @override
  String get howToPlay => 'Cara bermain';

  @override
  String get aboutTitle => 'Tentang permainan';

  @override
  String get aboutIntro =>
      'Stackline adalah puzzle blok inspirasi Tetris — tapi potongan tidak jatuh dari atas. Anda menempatkan setiap bentuk di papan 10×10.';

  @override
  String get aboutPlaceTitle => 'Tempatkan bentuk';

  @override
  String get aboutPlaceBody =>
      'Seret potongan dari baki bawah ke papan. Selalu ada tiga bentuk, enam lagi menunggu di pratinjau.';

  @override
  String get aboutClearTitle => 'Hapus baris';

  @override
  String get aboutClearBody =>
      'Isi satu baris atau kolom penuh untuk menghapusnya dan mendapat poin.';

  @override
  String get aboutComboTitle => 'Buat combo';

  @override
  String get aboutComboBody =>
      'Hapus beberapa baris sekaligus untuk meningkatkan pengali combo.';

  @override
  String get aboutScoreTitle => 'Pecahkan rekor';

  @override
  String get aboutScoreBody =>
      'Setiap penempatan dan baris yang dihapus menambah skor. Skor terbaik disimpan otomatis.';

  @override
  String get aboutEndTitle => 'Permainan selesai';

  @override
  String get aboutEndBody =>
      'Permainan berakhir saat tidak ada bentuk yang muat. Anda bisa keluar kapan saja dan menyimpan progres.';
}
