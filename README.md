Flutter Firebase CRUD Notes App
A straightforward Flutter application demonstrating CRUD (Create, Read, Update, Delete) operations for notes, powered by Google's Cloud Firestore for real-time data storage.

✨ Features
Create: Add new notes with a title and content.
Read: View all your notes in a clean, real-time list.
Update: Tap on a note to edit its content.
Delete: Easily remove notes you no longer need.
🛠️ Tech Stack
Framework: Flutter
Database: Firebase - Cloud Firestore
🚀 Get Started

# Install dependencies

flutter pub get
Use code with caution.
Bash 2. Firebase Setup
You must connect this app to your own Firebase project to handle the data.
Create a Firebase Project
Go to the Firebase Console and create a new project.
Add your App & Get Config File
In your project dashboard, add an Android or iOS app.
Follow the setup instructions and download the config file:
Android: google-services.json
iOS: GoogleService-Info.plist
Place the downloaded file in the correct directory:
android/app/ for Android.
ios/Runner/ for iOS (use Xcode to add the file to the project).
Enable Cloud Firestore
In the Firebase Console, go to Firestore Database.
Click Create database and choose to start in test mode for easy setup.
Select a server location and click Enable.
Warning: Test mode allows anyone to read/write to your database. Secure it with Firestore Security Rules before production. 3. Run the App
Make sure you have an emulator running or a device connected, then execute:
flutter run
