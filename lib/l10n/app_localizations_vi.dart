// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Stackline';

  @override
  String get homeTagline => 'Đặt khối. Xóa hàng. Phá kỷ lục của bạn.';

  @override
  String get highScore => 'Điểm cao nhất';

  @override
  String get play => 'Chơi';

  @override
  String get gameOver => 'Kết thúc';

  @override
  String get scoreLabel => 'Điểm';

  @override
  String gameOverScore(int score) {
    return 'Điểm: $score';
  }

  @override
  String get playAgain => 'Chơi lại';

  @override
  String get retry => 'Thử lại';

  @override
  String get best => 'Tốt nhất';

  @override
  String get combo => 'Combo';

  @override
  String scoreGain(int points) {
    return '+$points';
  }

  @override
  String get next => 'Tiếp theo';

  @override
  String get themesTooltip => 'Giao diện';

  @override
  String get chooseTheme => 'Chọn giao diện';

  @override
  String get languageTooltip => 'Ngôn ngữ';

  @override
  String get chooseLanguage => 'Chọn ngôn ngữ';

  @override
  String get themeWhite => 'Trắng';

  @override
  String get themeBlack => 'Đen';

  @override
  String get themeOcean => 'Đại dương';

  @override
  String get themeSunset => 'Hoàng hôn';

  @override
  String get themeForest => 'Rừng';

  @override
  String get themeRose => 'Hồng';

  @override
  String get themeAmethyst => 'Thạch anh tím';

  @override
  String get themeSky => 'Bầu trời';

  @override
  String get cancel => 'Hủy';

  @override
  String get exitGameTitle => 'Rời khỏi trò chơi?';

  @override
  String exitGameMessage(int score) {
    return 'Điểm hiện tại của bạn là $score. Lưu tiến trình hay hủy bỏ?';
  }

  @override
  String get exitGameSave => 'Lưu';

  @override
  String get exitGameDiscard => 'Hủy bỏ';

  @override
  String get continueGame => 'Tiếp tục';

  @override
  String get newGame => 'Trò chơi mới';

  @override
  String get howToPlay => 'Cách chơi';

  @override
  String get aboutTitle => 'Giới thiệu trò chơi';

  @override
  String get aboutIntro =>
      'Stackline là game xếp khối lấy cảm hứng từ Tetris — nhưng khối không rơi từ trên. Bạn tự đặt từng hình lên bảng 10×10.';

  @override
  String get aboutPlaceTitle => 'Đặt khối';

  @override
  String get aboutPlaceBody =>
      'Kéo khối từ khay dưới lên bảng. Luôn có ba khối để chọn, sáu khối nữa ở hàng xem trước.';

  @override
  String get aboutClearTitle => 'Xóa hàng';

  @override
  String get aboutClearBody => 'Lấp đầy một hàng hoặc cột để xóa và nhận điểm.';

  @override
  String get aboutComboTitle => 'Tạo combo';

  @override
  String get aboutComboBody => 'Xóa nhiều hàng cùng lúc để tăng hệ số combo.';

  @override
  String get aboutScoreTitle => 'Phá kỷ lục';

  @override
  String get aboutScoreBody =>
      'Mỗi lần đặt và mỗi hàng xóa đều cộng điểm. Điểm cao nhất được lưu tự động.';

  @override
  String get aboutEndTitle => 'Kết thúc';

  @override
  String get aboutEndBody =>
      'Game kết thúc khi không còn khối nào đặt được. Bạn có thể thoát bất cứ lúc nào và lưu tiến trình.';
}
