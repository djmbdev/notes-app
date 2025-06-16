import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/edit_and_add_notes.dart';
import 'package:note_app/screens/note_list.dart';
import 'package:note_app/screens/preloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "yourApiKey",
      appId: "yourAppId",
      messagingSenderId: "yourMessagingSenderId",
      projectId: "yourProjectId",
    ),
  );
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
