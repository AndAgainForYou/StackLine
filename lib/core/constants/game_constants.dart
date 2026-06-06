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

  /// Horizontal anchor: 0.5 = piece centred on finger.
  static const double dragAnchorFractionX = 1.2;

  /// Vertical anchor: 1.0 = piece sits entirely above the finger.
  static const double dragAnchorFractionY = 1.2;

  static const int baseLineScore = 100;
  static const double comboMultiplierStep = 0.5;

  static const Duration lineClearDuration = Duration(milliseconds: 400);
  static const Duration minAnimationDuration = Duration(milliseconds: 150);

  static const String highScoreKey = 'stackline_high_score';
  static const String themeKey = 'stackline_theme_mode';
  static const String themeVariantKey = 'stackline_theme_variant';
  static const String localeKey = 'stackline_locale';
  static const String savedGameKey = 'stackline_saved_game';
  static const String soundEnabledKey = 'stackline_sound_enabled';
}
