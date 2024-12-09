// second_screen.dart
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to ThirdScreen when the button is pressed
            Navigator.pushNamed(context, '/third');
          },
          child: const Text('Go to Third Screen'),
        ),
      ),
    );
  }
}
