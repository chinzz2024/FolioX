import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart'; // Ensure this file exists and the LoginPage widget is correctly implemented.
import 'firebase_options.dart'; // Ensure this file is generated using the FlutterFire CLI.




void main() async {
  // Ensures Flutter binding is initialized before calling Firebase.initializeApp().
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the generated options for the current platform.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Start the app.
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // Sets the primary theme color.
      ),

      home: const LoginPage(), // Ensure LoginPage is implemented correctly.
      debugShowCheckedModeBanner: false, // Hides the debug banner.
    );
  }
}
