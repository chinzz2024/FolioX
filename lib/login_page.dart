import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // For handling error messages
  String? _errorMessage;

  // For handling password visibility
  bool _isPasswordVisible = false;

  // Function to handle login
  Future<void> _signIn() async {
    setState(() {
      _errorMessage =
          null; // Clear error message when starting the sign-in attempt
    });

    try {
      // Attempt to sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // If sign-in is successful, navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      // If an error occurs, display the error message
      setState(() {
        _errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back navigation
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Log In",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Log in with your credentials."),
            const SizedBox(height: 16),
            const SizedBox(height: 32),

            // Email TextField
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: const OutlineInputBorder(),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                errorText: _errorMessage, // Show error message if any
              ),
            ),
            const SizedBox(height: 20),

            // Password TextField with visibility toggle
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible, // Toggling password visibility
              decoration: InputDecoration(
                labelText: "Password",
                border: const OutlineInputBorder(),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Sign-in Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _signIn, // Call the sign-in function
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Log In",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Navigate to SignUp Page
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      // Navigate to Sign Up page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
