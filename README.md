# innochess

A modern Flutter chess app with AI, multiplayer, and a beautiful UI.

## 🧩 App Functionality

- **Single Player:** Play against the computer (AI) with three difficulty levels: Beginner, Intermediate, Difficult. Choose to play as White or Black.
- **Multiplayer (Same Device):** Two players can play on the same device.
- **Multiplayer (Online):** Challenge friends online (Firebase backend, coming soon).
- **Chess Clock:** Select 3, 5, or 10 minute game modes.
- **Move List & Captured Pieces:** See all moves and captured pieces in real time.
- **Check/Checkmate Notification:** Get notified when a player is in check or checkmate.
- **Google Sign-In:** Easy authentication (for online features).
- **Google Ads:** Banner ads for monetization.
- **Modern UI:** Clean, blue-and-white themed, mobile-friendly design.

## 🛠️ Tech Stack

- **Flutter** (cross-platform mobile framework)
- **Dart** (main programming language)
- **[chess](https://pub.dev/packages/chess)** & **[flutter_chess_board](https://pub.dev/packages/flutter_chess_board)** (chess logic and board UI)
- **Firebase** (for online multiplayer, authentication)
- **Google Mobile Ads** (for monetization)

## 🚀 Installation & Running

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Android Studio or VS Code
- Android/iOS device or emulator

### Setup Steps
1. **Clone the repository:**
   ```sh
   git clone https://github.com/sumeetonline90/innochess.git
   cd innochess
   ```
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```
3. **(Optional) Configure Firebase:**
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) for online multiplayer.
4. **(Optional) Configure AdMob:**
   - Add your AdMob App ID to `android/app/src/main/AndroidManifest.xml`.

### Running the App
- **On emulator/device:**
  ```sh
  flutter run
  ```
- **Build APK:**
  ```sh
  flutter build apk
  ```

## 📁 Project Structure
- `lib/` — Main Dart code
- `android/`, `ios/` — Platform-specific code
- `web/`, `linux/`, `macos/`, `windows/` — Desktop/web support

## 🙏 Credits
- Built with [Flutter](https://flutter.dev/)
- Chess logic: [chess](https://pub.dev/packages/chess) & [flutter_chess_board](https://pub.dev/packages/flutter_chess_board)
- Firebase, Google Sign-In, Google Mobile Ads plugins

## 📄 License
MIT License

---

*Made with ❤️ by Sumeet and contributors.*
