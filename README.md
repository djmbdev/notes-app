# 📝 Flutter Firebase CRUD Notes App

A straightforward Flutter application demonstrating CRUD (Create, Read, Update, Delete) operations for notes, powered by Google's Cloud Firestore for real-time data storage.

---

## ✨ Features

- **Create**: Add new notes with a title and content.
- **Read**: View all your notes in a clean, real-time list.
- **Update**: Tap on a note to edit its content.
- **Delete**: Easily remove notes you no longer need.

---

## 🛠️ Tech Stack

- **Framework**: Flutter  
- **Backend**: Firebase (Cloud Firestore)

---

## 🚀 Getting Started

### 1. Clone & Install

- Clone the repository and install dependencies:


- git clone https://github.com/your-username/your-repo-name.git
- cd your-repo-name
- flutter pub get

### 2. Firebase Setup
- You must connect this app to your own Firebase project.

- Go to the Firebase Console and create a new project.

- Add your Android and/or iOS app to the Firebase project.

- Download the configuration files:
    - google-services.json for Android
    - GoogleService-Info.plist for iOS

- Place the files in the following directories:
    - android/app/        # for Android
    - ios/Runner/         # for iOS (use Xcode to add the file)
- Enable Cloud Firestore:

    - Go to Firestore Database in the Firebase Console
    - Click Create database
    - Choose Start in test mode (for development only)
    - Select a region and click Enable

``` -Update your Firebase initialization code using your own values:
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "yourApiKey",
    appId: "yourAppId",
    messagingSenderId: "yourMessagingSenderId",
    projectId: "yourProjectId",
  ),
);
```
⚠️ Do not commit your real Firebase API keys to public repositories.

🔒 Test mode allows public access — secure your app with proper Firestore Security Rules for production.


### 3. Run the App
- Make sure you have a device or emulator running, then:
```flutter run```

### 📌 Notes
- This app uses the firebase_core and cloud_firestore packages.
- Ensure Firebase is properly set up and connected before launching.