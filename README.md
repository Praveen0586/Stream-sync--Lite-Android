# 📱 StreamSync Lite — Flutter Android App

This is the Flutter front-end for the StreamSync Lite application. This guide explains how to clone, set up, and run the app.

---

## 🔗 Clone the Repository

```bash
git clone https://github.com/Praveen0586/Stream-sync--Lite-Android.git
cd streamsync_lite

## 🔗 Update API Base URL

Before running the Flutter application, make sure to update the **base API URL** in your project to point to your backend server.

- Default API URLs may point to local servers (`http://localhost:3000`) or demo endpoints.
- Update it to your deployed backend endpoint, for example:

```dart
class ApiConfig {
  static const String baseUrl = "https://your-backend-domain.com/api"; // <-- Update this
}
```

**Note:** Make sure the backend server is running. You can visit the backend repository here: [Backend Repo Link](https://github.com/Praveen0586/Stream-sync-Lite---Server/tree/main)

---

## ⚙️ Requirements

* Flutter **3.32.5**
* Dart **3.8.1**
* Android Studio / Android SDK
* Firebase `google-services.json` or `firebase_options.dart` (Do NOT commit sensitive Firebase keys to GitHub)

> **Note:** `firebase_options.dart` can be safely included if it contains only configuration and no sensitive keys. If it contains private API keys or service account info, keep it out of Git.

---

## 📦 Install Dependencies

```bash
flutter pub get
```

---

## 🏃 Run the App (Development)

Make sure an Android device or emulator is running:

```bash
flutter run
```

---

## 📁 Project Structure

```
streamsync_lite/
|   firebase_options.dart
|   main.dart
|   
+---core
|   +---connectivity
|   |       connectivityService.dart
|   |       offlinebanner.dart
|   |
|   +---di
|   |       dependencyinjection.config.dart
|   |       dependencyinjection.dart
|   |       injections.dart
|   |
|   +---exceptions
|   +---fcm
|   |       firebasemessaging.dart
|   |       notificationservice.dart
|   |
|   +---globals
|   |       globals.dart
|   |
|   +---services
|   |       APIServices.dart
|   |       cacheimages.dart
|   |       localdatabase.dart
|   |
|   \---utils
\---features
    +---authentication
    |   +---model
    |   |       userModel.dart
    |   |
    |   +---repositories
    |   |       authrepositry.dart
    |   |
    |   +---services
    |   |       api_services.dart
    |   |       localdatabase.dart
    |   |
    |   +---view
    |   |       signInscreen.dart
    |   |       signupScreen.dart
    |   |
    |   \---viewmodel
    |       |   validators.dart
    |       |
    |       \---bloc
    |               authentiction_bloc.dart
    |               authentiction_event.dart
    |               authentiction_state.dart
    |
    +---favorites
    |   +---model
    |   |       favModel.dart
    |   |
    |   +---repository
    |   |       favrepo.dart
    |   |
    |   +---services
    |   |       apicalls_favorites.dart
    |   |       loca;storage.dart
    |   |
    |   +---view
    |   |       favorites.dart
    |   |
    |   \---viewModel
    |       \---bloc
    |               favorites_bloc.dart
    |               favorites_event.dart
    |               favorites_state.dart
    |
    +---home
    |   +---models
    |   |       models.dart
    |   |
    |   +---repositories
    |   |       Homerepo.dart
    |   |
    |   +---services
    |   |       localStorage.dart
    |   |       video_api_services.dart
    |   |
    |   +---view
    |   |   |   homescreen.dart
    |   |   |   
    |   |   \---widgets
    |   |           widgets.dart
    |   |
    |   \---viewmodel
    |       \---bloc
    |               home_bloc.dart
    |               home_event.dart
    |               home_state.dart
    |
    +---notifications
    |   +---models
    |   |       models.dart
    |   |
    |   +---repository
    |   |       ntificationsrepo.dart
    |   |
    |   +---services
    |   |       localNotifications.dart
    |   |       notificationremote.dart
    |   |
    |   +---viewModel
    |   |   \---bloc
    |   |           notifications_bloc.dart
    |   |           notifications_event.dart
    |   |           notifications_state.dart
    |   |
    |   \---views
    |           noificationscreen.dart
    |
    +---profile
    |   +---repository
    |   |       profilerepo.dart
    |   |
    |   +---services
    |   |       apiProfileServices.dart
    |   |
    |   \---view
    |           profilescreen.dart
    |
    +---splash
    |   +---model
    |   +---repositories
    |   |       splashrepo.dart
    |   |
    |   +---view
    |   |       splashScreen.dart
    |   |
    |   \---viewModels
    |           splash_cubit.dart
    |           splash_state.dart
    |
    \---videoPlayBack
        +---models
        +---repository
        |       videoplayRepo.dart
        |
        +---services
        |       videpPreviewAPi.dart
        |       vidoelocalStorage.dart
        |
        +---viewMdel
        |   \---bloc
        |           video_play_back_bloc.dart
        |           video_play_back_event.dart
        |           video_play_back_state.dart
        |
        \---views
                videoPlayScreen.dart
                widgets.dart

```

---

## ⚠️ Notes

* Currently, this project supports **Android only**.
* Ensure the backend server is running and accessible.
* Keep `.env` and Firebase keys secure; do not commit sensitive files.
