import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app.dart';
import 'core/firebase/firebase_bootstrap.dart';
import 'data/local_storage_service.dart';
import 'presentation/widgets/game_over_banner_ad.dart';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  await initializeFirebaseIfSupported();

  if (GameOverBannerAd.isSupported) {
    await MobileAds.instance.initialize();
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final storage = await LocalStorageService.create();
  runApp(StacklineApp(storage: storage));
  FlutterNativeSplash.remove();
}
