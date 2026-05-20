class GameConstants {
  static const int boardSize = 10;
  static const int previewCount = 6;
  static const int trayPieceCount = 3;
  static const int initialQueueSize = trayPieceCount + previewCount;

  static const double trayHeight = 104;
  static const double trayHorizontalPadding = 12;
  static const double trayVerticalPadding = 12;
  static const double trayMaxCellSize = 34;
  static const double trayMinCellSize = 14;

  /// Fraction of the piece size where the finger anchors the drag (0 = top-left, 1 = bottom-right).
  static const double dragAnchorFraction = 0.85;

  static const int baseLineScore = 100;
  static const double comboMultiplierStep = 0.5;

  static const Duration lineClearDuration = Duration(milliseconds: 400);
  static const Duration minAnimationDuration = Duration(milliseconds: 150);

  static const String highScoreKey = 'stackline_high_score';
  static const String themeKey = 'stackline_theme_mode';
  static const String themeVariantKey = 'stackline_theme_variant';
  static const String localeKey = 'stackline_locale';
  static const String savedGameKey = 'stackline_saved_game';
}
