# Sankar Task — Flutter Task Manager App

A Flutter task manager application built for the **Sankar Group Flutter Development Internship Assignment**. The app delivers a clean, responsive UI for managing personal tasks, secured per-user with Firebase Authentication, persisted in Cloud Firestore, and enriched with a motivational quote fetched from a public REST API.

---

## Downloads & Demo

> Add your links here after uploading the APK and the screen recording.

- **APK Download:** https://drive.google.com/file/d/1jwhAmP3HdxVLKoKO8dgK5G6N6bncdZBe/view?usp=drivesdk <!-- paste APK link here -->
<!-- paste demo video link here -->

---

## Table of Contents

1. [Overview](#overview)
2. [Features](#features)
3. [Tech Stack](#tech-stack)
4. [Project Structure](#project-structure)
5. [Architecture & Design Decisions](#architecture--design-decisions)
6. [Screens](#screens)
7. [Firestore Data Model](#firestore-data-model)
8. [REST API Integration](#rest-api-integration)
9. [Prerequisites](#prerequisites)
10. [Setup & Installation](#setup--installation)
11. [Configuring Firebase](#configuring-firebase)
12. [Running the App](#running-the-app)
13. [Building the APK](#building-the-apk)
14. [How the App Maps to the Evaluation Criteria](#how-the-app-maps-to-the-evaluation-criteria)
15. [Troubleshooting](#troubleshooting)
16. [Future Improvements](#future-improvements)
17. [Author](#author)

---

## Overview

**Sankar Task** is a mobile-first task manager that lets a user sign up, log in, and manage a private list of tasks (title, description, date, and completion status). Each user's tasks are scoped to their own Firestore subcollection, ensuring data isolation. The home screen also surfaces a motivational quote pulled live from a public REST API to add a small productivity nudge.

The app is built using **Flutter 3 / Dart 3** and uses **GetX** for state management, dependency injection, and navigation. It is structured around a clean separation of concerns: models, controllers, screens, and reusable widgets each live in dedicated folders. Strings, colors, and constants are centralized into theme/constants files to make refactoring and theming trivial.

---

## Features

### 1. User Authentication (Firebase Authentication)
- **Sign Up** with full name, email, password, and password confirmation.
- **Login** with email + password.
- **Logout** from the home screen app bar.
- An `AuthGateway` widget listens to `FirebaseAuth.instance.authStateChanges()` and routes the user automatically between the auth screen and the home screen — so the auth state is the single source of truth, with no manual navigation hacks.

### 2. Task Management (Cloud Firestore CRUD)
Per the assignment, each task contains:
- **Title**
- **Description**
- **Date** (`lastDateText`, auto-populated at creation)
- **Status** (`completed`, boolean)

Operations supported:
- **Create** — add a new task via a reusable dialog.
- **Read** — live `StreamBuilder` listing tasks ordered by date.
- **Update** — edit existing task details via the same reusable dialog.
- **Delete** — remove a task with a single tap.
- **Toggle completed** — flip the status directly from the list tile checkbox (with a line-through visual cue when done).

All Firestore reads/writes are scoped to `users/{uid}/tasks/{taskId}` so users only ever see their own data.

### 3. REST API Integration
- Fetches a random motivational quote from `https://api.quotable.io/random` using the `http` package.
- Displays the quote content and author in a dedicated card on the home screen.
- A refresh button lets the user fetch a new quote on demand.
- Shows a `CircularProgressIndicator` while loading and a snackbar on failure.

### 4. UI Requirements (per the rubric)
- **Clean and responsive UI** — built with Material 3, custom theme palette, and scale factors that adapt to device width.
- **Proper navigation** — handled by GetX with route guarding through `AuthGateway`.
- **Form validation** — email format regex, non-empty checks, password-confirmation match.
- **Loading indicators** — present on auth buttons, the task list (`StreamBuilder.waiting`), and the quote card.
- **Error handling** — every Firestore / API call is wrapped in `try/catch` and surfaced as a snackbar (success or error) so failures are never silent.

---

## Tech Stack

| Layer | Choice | Why |
|---|---|---|
| Framework | Flutter 3 (`sdk: ^3.11.4`) | Cross-platform mobile, fast iteration |
| Language | Dart 3 | Modern null-safe Dart |
| State / DI / Navigation | `get: ^4.7.3` | Lightweight, no `BuildContext` plumbing, integrated routing |
| Auth | `firebase_auth: ^6.5.0` | Industry standard, secure, free tier |
| Database | `cloud_firestore: ^6.4.0` | Real-time sync, per-user subcollections |
| Networking | `http: ^1.6.0` | Minimal REST client for the quotes API |
| Identifiers | `uuid: ^4.5.3` | Stable IDs for task documents |
| Linting | `flutter_lints: ^6.0.0` | Enforces Flutter style guide |

---

## Project Structure

```
lib/
├── constants/
│   └── app_constants.dart         # All user-facing strings, Firestore keys, URLs, regex
├── controller/                    # GetX controllers (auth, task, quote)
│   ├── auth_controller.dart
│   ├── task_controller.dart
│   └── qoute_controller.dart
├── models/                        # Plain Dart models with fromJson/toJson
│   ├── task_model.dart
│   ├── user_model.dart
│   └── quote_model.dart
├── screens/
│   ├── auth_gateway/              # Auth state router (login vs. home)
│   ├── auth_screen/               # Login + Signup tabs
│   │   └── widgets/               # SignInForm, SignUpForm, PasswordField
│   ├── homeScreen/                # Main task screen
│   │   └── widgets/               # TaskTile, TaskDialog, QuoteCard
│   └── splash_screen/             # Branded splash with CTA
├── theme/
│   └── app_Colors.dart            # All Color constants (centralized)
├── firebase_options.dart          # (optional) Generated by `flutterfire configure`
└── main.dart                      # App entry point
```

> Note: the assignment PDF suggests a `services/` folder. This project uses GetX **controllers** in `controller/`, which serve the same role (encapsulating Firestore / Firebase / HTTP calls behind a reactive API). Functionally identical, with cleaner integration with GetX's reactive primitives.

---

## Architecture & Design Decisions

- **GetX for everything stateful.** A single `AuthController`, `TaskController`, and `QuoteController` own all side-effects (Firebase, Firestore, HTTP). UI widgets stay declarative and re-render through `Obx` / `StreamBuilder`. This keeps the widget tree dumb and the business logic testable.
- **Auth gating via `AuthGateway`.** Instead of pushing routes from controllers, `AuthGateway` is a `StreamBuilder<User?>` over `authStateChanges()`. Login, signup, and logout all just mutate Firebase state — navigation falls out for free. This eliminates an entire class of "stuck on the wrong screen" bugs.
- **Per-user Firestore subcollections.** Tasks live at `users/{uid}/tasks/{taskId}`, not in a global `tasks` collection with a `userId` filter. This makes Firestore security rules trivial (`request.auth.uid == userId`) and keeps queries cheap.
- **One reusable task dialog for add + edit.** `openTaskDialog({taskId, isEdit})` is a single function used for both flows. The controller's `editTask(id)` pre-fills the text controllers before the dialog opens, so the dialog UI doesn't need to know whether it's adding or editing.
- **Centralized strings, colors, and keys.** `AppConstants` holds every user-facing string, Firestore field key, regex, and URL. `AppColors` holds every color literal. This means renaming a button label or shifting the brand color is a single-line change — and it eliminates magic strings inside the widget tree.
- **Stream-based task list.** `getTasks()` returns a Firestore snapshots stream, and `HomeScreen` consumes it with `StreamBuilder`. Adds/edits/deletes show up in the UI within milliseconds with no manual refresh.

---

## Screens

| # | Screen | Purpose |
|---|---|---|
| 1 | **Splash Screen** | Branded landing screen with a "Get Started" CTA leading into the auth gateway. |
| 2 | **Auth Screen** | Tabbed Login / Sign Up forms with validation, loading state, and snackbar feedback. |
| 3 | **Home Screen** | Task list (live), Add button, Edit/Delete actions per row, completion checkbox, and the motivational quote card. |
| 4 | **Task Dialog** | Reusable modal for adding and editing tasks (title, description, completion). |

---

## Firestore Data Model

```
users (collection)
└── {uid} (doc)
    ├── id: string
    ├── name: string
    ├── email: string
    └── tasks (subcollection)
        └── {taskId} (doc)
            ├── id: string
            ├── title: string
            ├── description: string
            ├── lastDateText: string  (YYYY-MM-DD)
            └── completed: bool
```

**Recommended Firestore security rules:**

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      match /tasks/{taskId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

---

## REST API Integration

- **Endpoint:** `https://api.quotable.io/random`
- **Method:** `GET`
- **Response (used fields):** `content`, `author`
- **Where it's wired:** `lib/controller/qoute_controller.dart` — `fetchQuote()` runs on `onInit()` and on user tap of the refresh icon.
- **States covered:** loading (`isLoading.value == true` → progress indicator), success (renders quote + author), error (snackbar "Unable to fetch quote").

---

## Prerequisites

Make sure the following are installed and on your `PATH`:

| Tool | Minimum Version |
|---|---|
| Flutter SDK | 3.11.4 |
| Dart SDK | 3.0 (bundled with Flutter) |
| Android Studio or VS Code | Any recent |
| Android SDK / Platform Tools | API 21+ |
| Firebase CLI | latest |
| FlutterFire CLI | latest |
| A device or emulator | Android API 21+ |

Verify with:

```bash
flutter --version
flutter doctor
```

`flutter doctor` should show green checks for **Flutter**, **Android toolchain**, and at least one **connected device**.

---

## Setup & Installation

### 1. Clone the repository

```bash
git clone <your-repo-url>
cd sankar_task
```

### 2. Install dependencies

```bash
flutter pub get
```

This fetches `firebase_auth`, `cloud_firestore`, `firebase_core`, `get`, `http`, `uuid`, and the rest.

---

## Configuring Firebase

The app **will not run without a Firebase project** — Authentication and Firestore are required. Follow these steps:

### 1. Create a Firebase project

1. Go to [https://console.firebase.google.com](https://console.firebase.google.com)
2. Click **Add project**, give it a name (e.g. `sankar-task-demo`), and finish the wizard.
3. In the project, open **Build → Authentication → Sign-in method** and **enable Email/Password**.
4. Open **Build → Firestore Database → Create database**. Start in **production mode** (or test mode if you just want to try it), pick a region, and finish.

### 2. Apply the recommended security rules

In **Firestore → Rules**, paste:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      match /tasks/{taskId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

Click **Publish**.

### 3. Install the Firebase CLI and FlutterFire CLI

```bash
npm install -g firebase-tools
firebase login

dart pub global activate flutterfire_cli
```

Make sure the Dart pub global bin directory is on your `PATH`. On Windows that's typically:
```
%USERPROFILE%\AppData\Local\Pub\Cache\bin
```

### 4. Wire your Firebase project into the Flutter app

From the project root:

```bash
flutterfire configure
```

When prompted:
- pick the Firebase project you created
- select platforms **Android** (and **iOS** if needed)
- accept the default app IDs

This will:
- Generate `lib/firebase_options.dart`
- Drop `android/app/google-services.json`
- Drop `ios/Runner/GoogleService-Info.plist` (if iOS is selected)

### 5. (Recommended) Use the generated `DefaultFirebaseOptions` in `main.dart`

Open `lib/main.dart` and replace:

```dart
await Firebase.initializeApp();
```

with:

```dart
import 'package:sankar_task/firebase_options.dart';
// ...
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

This makes the initialization explicit and portable across iOS/Android/web.

---

## Running the App

### On a connected Android device or emulator

```bash
flutter run
```

For release-mode performance:

```bash
flutter run --release
```

### Hot reload / hot restart

While `flutter run` is active:
- press `r` for hot reload
- press `R` for hot restart
- press `q` to quit

---

## Building the APK

### Debug APK (fast, large)

```bash
flutter build apk --debug
```
Output: `build/app/outputs/flutter-apk/app-debug.apk`

### Release APK (recommended for submission)

```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### Split APKs per ABI (smaller downloads)

```bash
flutter build apk --release --split-per-abi
```
Outputs:
- `app-armeabi-v7a-release.apk`
- `app-arm64-v8a-release.apk`
- `app-x86_64-release.apk`

Upload the **release** APK to your preferred host (Google Drive / GitHub Releases / Dropbox) and paste the link in the [Downloads & Demo](#downloads--demo) section above.

---

## How the App Maps to the Evaluation Criteria

| Criterion | Marks | Where it's demonstrated |
|---|---|---|
| **Flutter UI & Navigation** | 20 | Material 3 theme, responsive scale factor, splash → auth gateway → home flow, tabbed auth screen, reusable add/edit dialog, list with completion line-through. |
| **Firebase Authentication** | 20 | `AuthController` handles sign-up, login, logout via `FirebaseAuth`. `AuthGateway` routes on auth state. |
| **Firestore CRUD Operations** | 25 | `TaskController.addTask`, `editTask`, `updateTask`, `deleteTask`, `getTasks` (stream). Per-user subcollection at `users/{uid}/tasks`. |
| **REST API Integration** | 10 | `QuoteController.fetchQuote` hits `https://api.quotable.io/random`, renders content + author, supports refresh. |
| **Code Structure & Clean Code** | 15 | Layered folders (`controller/`, `models/`, `screens/`, `theme/`, `constants/`). Strings + colors centralized. Reusable widgets (`TaskTile`, `TaskDialog`, `PasswordField`). |
| **App Performance & Error Handling** | 10 | All async ops wrapped in `try/catch` with snackbar feedback. Loading indicators on every async surface. Stream-based list avoids manual refresh. |

---

## Troubleshooting

**`Firebase.initializeApp()` throws on startup**
Run `flutterfire configure` again and verify `android/app/google-services.json` exists. Ensure `android/build.gradle` and `android/app/build.gradle` include the Google Services plugin (FlutterFire CLI handles this for you).

**"PERMISSION_DENIED" when reading/writing tasks**
Your Firestore security rules are blocking the request. Apply the rules from the [Configuring Firebase](#configuring-firebase) section and click **Publish**.

**Quote card stays in loading state forever**
The device has no internet, or `api.quotable.io` is temporarily down. Tap the refresh icon to retry. Check `flutter logs` for the exact error.

**`flutterfire` command not found**
The Dart pub global bin directory is not on your `PATH`. On Windows, add `%USERPROFILE%\AppData\Local\Pub\Cache\bin`. On macOS/Linux, add `$HOME/.pub-cache/bin`.

**Build fails with min SDK version error**
Open `android/app/build.gradle` and ensure `minSdkVersion` is `21` or higher (Firebase Auth requires it).

---

## Future Improvements

- Switch the date field from `String` to a real `Timestamp` and add a date-picker.
- Add task **priority** and **categories**.
- Add **task search / filter** (by status, by date range).
- Add **pull-to-refresh** on the task list.
- Add **offline support** via Firestore offline persistence (already partially free — just enable it).
- Add **unit tests** for the controllers and **widget tests** for the screens.
- Migrate to **Riverpod** or **Bloc** if the project grows beyond GetX's sweet spot.
- Add **localization (i18n)** — `AppConstants` already centralizes every string, so this would be a mechanical change.

---

## Author

Built by **Nikhilesh Singh Bhardwaj** for the Sankar Group Flutter Development Internship Assignment.

For any clarifications, please reach out via the contact details on the submission email.
