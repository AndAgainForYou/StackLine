import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Initializes Firebase from native platform config files:
/// - Android: android/app/google-services.json
/// - iOS: ios/Runner/GoogleService-Info.plist
///
/// No API keys are stored in Dart source — see .example files in the repo.
Future<void> initializeFirebaseIfSupported() async {
  if (kIsWeb) return;

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
    case TargetPlatform.iOS:
      await Firebase.initializeApp();
    default:
      break;
  }
}
