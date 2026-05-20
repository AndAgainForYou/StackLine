import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/game_constants.dart';
import '../core/theme/app_theme_variant.dart';
import 'game_session_storage.dart';

class LocalStorageService {
  LocalStorageService(this._prefs);

  final SharedPreferences _prefs;

  static Future<LocalStorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorageService(prefs);
  }

  int getHighScore() => _prefs.getInt(GameConstants.highScoreKey) ?? 0;

  Future<void> saveHighScore(int score) async {
    await _prefs.setInt(GameConstants.highScoreKey, score);
  }

  bool getIsDarkMode() => _prefs.getBool(GameConstants.themeKey) ?? true;

  AppThemeVariant getThemeVariant() {
    final id = _prefs.getString(GameConstants.themeVariantKey);
    if (id != null) return AppThemeVariant.fromId(id);

    return getIsDarkMode() ? AppThemeVariant.dark : AppThemeVariant.light;
  }

  Future<void> saveThemeVariant(String id) async {
    await _prefs.setString(GameConstants.themeVariantKey, id);
    final variant = AppThemeVariant.fromId(id);
    await _prefs.setBool(GameConstants.themeKey, variant.isDark);
  }

  String? getLocaleId() => _prefs.getString(GameConstants.localeKey);

  Future<void> saveLocaleId(String id) async {
    await _prefs.setString(GameConstants.localeKey, id);
  }

  bool hasSavedGame() => _prefs.containsKey(GameConstants.savedGameKey);

  SavedGameSession? loadSavedGame() {
    return SavedGameSession.decode(_prefs.getString(GameConstants.savedGameKey));
  }

  Future<void> saveSavedGame(SavedGameSession session) async {
    await _prefs.setString(
      GameConstants.savedGameKey,
      SavedGameSession.encode(session),
    );
  }

  Future<void> clearSavedGame() async {
    await _prefs.remove(GameConstants.savedGameKey);
  }
}
