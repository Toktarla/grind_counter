# Grinder: Work Out Counter Application

Grinder is a Flutter-based workout tracking app that helps users set, track, and achieve their exercise goals. It features customizable exercise types, goal management, motivational notifications, and a gamified ranking system.

---

## Features

- **Custom Exercise Types:** Add, rename, or delete your own exercise types.
- **Goal Management:** Set daily, weekly, monthly, and yearly goals for each exercise.
- **Progress Tracking:** Log workouts and view progress over time.
- **Motivational Notifications:** Receive daily motivational messages to keep you on track.
- **Ranking System:** Level up as you complete workouts and reach new milestones.
- **Statistics & Logs:** Visualize your workout stats and review your workout history.
- **Theming:** Switch between light and dark themes.
- **Feedback:** Send feedback directly from the app.
- **Audio Feedback:** Optional sound when recording exercises.
- **Home Widget (Android):** Quick view of your progress from your home screen.

---

## Screenshots

*(Add screenshots here if available)*

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (>=3.6.0)
- Android Studio or VS Code (recommended for development)
- Android device or emulator

### Clone the Repository

```sh
git clone https://github.com/Toktarla/work_out_app.git
cd work_out_app
```

### Install Dependencies

```sh
flutter pub get
```

### Firebase Setup

- The app uses Firebase for analytics and crash reporting.
- The required configuration files (`google-services.json` for Android) are already included.
- If you want to use your own Firebase project, replace the files in `android/app/` and update `lib/config/firebase/firebase_options.dart`.

### Environment Variables

- The app uses a `.env` file for some configuration (see `lib/config/variables.dart`).
- Example `.env` file:
  ```
  PATH_TO_FIREBASE_ADMIN_SDK=assets/data/grinder-1b317-firebase-adminsdk-fbsvc-b8e6354864.json
  SENDER_ID=your_sender_id
  ```
- The `.env` file is included in the assets and should be present for the app to run.

### Assets

- **Fonts:** Nunito (Regular, Bold, Italic, BoldItalic)
- **Icons:** `assets/icon/playstore.png`
- **Sounds:** `assets/sounds/click.wav`
- **Firebase Admin SDK:** `assets/data/grinder-1b317-firebase-adminsdk-fbsvc-b8e6354864.json`

---

## Running the App

```sh
flutter run
```

- The app is currently configured for Android.
- For iOS or other platforms, additional setup may be required.

---

## Project Structure

- `lib/`
  - `main.dart` - App entry point
  - `views/` - UI screens (Home, Goals, Stats, Logs, etc.)
  - `components/` - Shared widgets (Drawer, etc.)
  - `providers/` - State management (Exercise types, goals, theme)
  - `repositories/` - Data access logic
  - `services/` - Notifications, ranking, etc.
  - `data/local/` - Local database (Drift/SQLite)
  - `config/` - App configuration, colors, DI, routes
  - `utils/` - Helpers, dialogs, animations, error handling
  - `widgets/` - Custom UI widgets

---

## Key Packages

- `provider` - State management
- `drift` - Local database (SQLite)
- `firebase_core`, `firebase_analytics`, `firebase_crashlytics` - Firebase integration
- `flutter_local_notifications` - Local notifications
- `home_widget` - Android home screen widget
- `audioplayers` - Audio feedback
- `share_plus` - Sharing stats and feedback
- `flutter_dotenv` - Environment variables

---

## Customization

- **Add/Remove Exercise Types:** Go to "Manage Exercise Types" from the home screen or drawer.
- **Set Goals:** Go to "Set Goals" from the drawer.
- **Change Theme:** Toggle theme from the drawer.
- **Notification Time:** Set notification time in the Settings page.
- **Feedback:** Send feedback via the Feedback page.

---

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

---

## License

*(Add your license here if applicable)*

---

## Contact

- [GitHub](https://github.com/Toktarla)
- Feedback email: forstudyonlyacc123@gmail.com
