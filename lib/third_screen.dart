// third_screen.dart
import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: const Text('Third Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Go back to HomeScreen
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
          child: const Text('Back to Home Screen'),
        ),
      ),
    );
  }
}
