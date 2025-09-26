# 📝 Flutter Firebase CRUD Notes App

A straightforward Flutter application that demonstrates CRUD (Create, Read, Update, Delete) operations for notes, powered by Google's Cloud Firestore for real-time data storage.

**Academic Project**: This project was created for **AP-4 - iOS Mobile Application Development Cross-Platform** coursework.

---

## ✨ Features

- **Create**: Add new notes with a title and content
- **Read**: View all your notes in a clean, real-time list
- **Update**: Tap on a note to edit its content
- **Delete**: Easily remove notes you no longer need

---

## 🛠️ Tech Stack

- **Framework**: Flutter
- **Backend**: Firebase (Cloud Firestore)

---

## 🚀 Getting Started

### 1. Clone & Install

Clone the repository and install dependencies:

```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
flutter pub get
```

### 2. Firebase Setup

You must connect this app to your own Firebase project.

1. Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project
2. Add your Android and/or iOS app to the Firebase project
3. Download the configuration files:
   - `google-services.json` for Android
   - `GoogleService-Info.plist` for iOS
4. Place the files in the following directories:
   - `android/app/` # for Android
   - `ios/Runner/` # for iOS (use Xcode to add the file)
5. Enable Cloud Firestore:
   - Go to Firestore Database in the Firebase Console
   - Click "Create database"
   - Choose "Start in test mode" (for development only)
   - Select a region and click "Enable"

Update your Firebase initialization code using your own values:

```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "yourApiKey",
    appId: "yourAppId",
    messagingSenderId: "yourMessagingSenderId",
    projectId: "yourProjectId",
  ),
);
```

⚠️ **Security Warning**: Do not commit your real Firebase API keys to public repositories.

🔒 **Production Note**: Test mode allows public access — secure your app with proper Firestore Security Rules for production.

### 3. Run the App

Make sure you have a device or emulator running, then:

```bash
flutter run
```

---

## 📌 Project History

This project was originally created in **2024** as part of academic coursework. It was later pushed to GitHub in **2025** after being rediscovered in project archives.

<img src="https://github.com/user-attachments/assets/50e4291a-7c70-4f24-98fa-1731bfc7c359" alt="Flutter Notes App Demo" width="800">

---

## 🤝 Contributing

This is an academic project, but feel free to fork and experiment with the code for your own learning purposes.

---

## 📄 License

This project is for educational purposes as part of academic coursework.
