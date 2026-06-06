import 'package:flutter/foundation.dart';

class AdConstants {
  AdConstants._();

  /// Replace with your AdMob app ID before release (AndroidManifest / Info.plist).
  static const String androidAppId = 'ca-app-pub-3940256099942544~3347511713';
  static const String iosAppId = 'ca-app-pub-3940256099942544~1458002511';

  // ── Banner (game over) ───────────────────────────────────────────────────

  static String get gameOverBannerAdUnitId {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return kDebugMode
          ? 'ca-app-pub-3940256099942544/2934735716'
          : _iosGameOverBannerAdUnitId;
    }
    return kDebugMode
        ? 'ca-app-pub-3940256099942544/6300978111'
        : _androidGameOverBannerAdUnitId;
  }

  static const String _androidGameOverBannerAdUnitId =
      'YOUR_ANDROID_GAME_OVER_BANNER_AD_UNIT_ID';
  static const String _iosGameOverBannerAdUnitId =
      'YOUR_IOS_GAME_OVER_BANNER_AD_UNIT_ID';

  // ── Interstitial (continue after game over) ──────────────────────────────

  static String get continueInterstitialAdUnitId {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return kDebugMode
          ? 'ca-app-pub-3940256099942544/4411468910'
          : _iosContinueInterstitialAdUnitId;
    }
    return kDebugMode
        ? 'ca-app-pub-3940256099942544/1033173712'
        : _androidContinueInterstitialAdUnitId;
  }

  static const String _androidContinueInterstitialAdUnitId =
      'YOUR_ANDROID_CONTINUE_INTERSTITIAL_AD_UNIT_ID';
  static const String _iosContinueInterstitialAdUnitId =
      'YOUR_IOS_CONTINUE_INTERSTITIAL_AD_UNIT_ID';
}
