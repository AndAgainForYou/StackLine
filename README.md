# Stackline

A modern mobile block puzzle game inspired by Tetris — without falling pieces. Drag shapes onto a **10×10** board, clear full rows and columns, build combos, and beat your high score.

## Features

- **Drag & drop gameplay** — pick a piece from the tray and place it anywhere on the board
- **Line clearing** — fill an entire row or column to clear it and score points
- **Combo multiplier** — clear multiple lines at once for bigger rewards
- **Save & continue** — leave mid-game and resume later from the home screen
- **19 languages** — English, Ukrainian, Russian, Chinese, German, French, Polish, and more
- **8 visual themes** — light, dark, and color palettes
- **Firebase** — Android & iOS integration ready
- **Sound & haptics** — audio feedback and vibration on line clears

## Tech stack

- [Flutter](https://flutter.dev) / Dart
- [flutter_bloc](https://bloclibrary.dev) — state management
- [Firebase Core](https://firebase.google.com) — backend services
- [SharedPreferences](https://pub.dev/packages/shared_preferences) — local storage

## Getting started

### Prerequisites

- Flutter SDK `^3.9.2`
- Xcode (iOS) / Android Studio (Android)

### Install & run

```bash
git clone https://github.com/AndAgainForYou/StackLine.git
cd StackLine
flutter pub get
flutter gen-l10n
flutter run
```

### Tests

```bash
flutter test
```

## Build for release

### Android

1. Copy `android/key.properties.example` → `android/key.properties` and fill in your keystore details
2. Build the app bundle:

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

### iOS

```bash
cd ios && pod install && cd ..
flutter build ipa --release
```

## Firebase setup

Firebase credentials are **not committed** to git. After cloning:

1. Open [Firebase Console](https://console.firebase.google.com) → project **stackline-ac4fa**
2. Download config files for app `com.zb.stackline`:
   - Android → `android/app/google-services.json`
   - iOS → `ios/Runner/GoogleService-Info.plist`

Or copy from the `.example` templates:

```bash
cp android/app/google-services.json.example android/app/google-services.json
cp ios/Runner/GoogleService-Info.plist.example ios/Runner/GoogleService-Info.plist
# then replace placeholder values with your Firebase config
```

**Package / Bundle ID:** `com.zb.stackline`

For production, add your release **SHA-1 / SHA-256** fingerprints in Firebase Console.

> If API keys were ever exposed in git history, rotate them in [Google Cloud Console](https://console.cloud.google.com/apis/credentials) → APIs & Services → Credentials.

## Project structure

```
lib/
├── core/           # Theme, locale, constants, utils
├── data/           # Local storage & session persistence
├── domain/         # Game logic, entities
├── features/       # GameCubit & state
├── l10n/           # Translations (ARB files)
└── presentation/   # Screens & widgets
```

## License

Private project — all rights reserved.
