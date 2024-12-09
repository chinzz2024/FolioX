import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'login_page.dart';
=======
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home_screen.dart';
import 'second_screen.dart';
import 'third_screen.dart';
>>>>>>> 57cd0f84412943186fce6568757c74cebe049414

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

