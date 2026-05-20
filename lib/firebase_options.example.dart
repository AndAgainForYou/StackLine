import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Example only — do not commit real keys.
/// Run `flutterfire configure` or copy values from Firebase Console.
class DefaultFirebaseOptions {
  static bool get isSupported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  static FirebaseOptions? get currentPlatform => null;
}
