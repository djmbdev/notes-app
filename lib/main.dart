import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/edit_and_add_notes.dart';
import 'package:note_app/screens/note_list.dart';
import 'package:note_app/screens/preloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyD5AnQk_9cetMcSTg_AVWO0U9HmHDRKmMk",
          appId: "1:366077990414:android:643849f2f7b6ae166b0e5f",
          messagingSenderId: "366077990414",
          projectId: "note-app-c65fe"));
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "splash_screen",
      routes: {
        "splash_screen": (context) => const SplashScreen(),
        "/": (context) => const HomePage(),
        "edit_add_notes_page": (context) => const EditAddNotesPage(),
      },
    ),
  );
}
