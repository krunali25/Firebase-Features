import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_features/helper/app_assets.dart';
import 'package:firebase_features/widgets/app_button.dart';
import 'package:firebase_features/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../helper/colors.dart';
import '../helper/dimens.dart';
import '../helper/navigation.dart';
import '../helper/routes.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> registerUser() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _cpasswordController.text.trim();
    final String name = _nameController.text.trim();

    // Validation checks
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showAlertDialog("Error", "Please fill in all fields.");
      return;
    }

    if (password != confirmPassword) {
      _showAlertDialog("Error", "Passwords do not match.");
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Optionally set the display name
      await userCredential.user?.updateDisplayName(name);

      // Navigate to the home page on success
      _showAlertDialog("Success", "Registration successful!");
      GoRouter.of(NavigationService.context!).go(RoutesUri.home);
    } on FirebaseAuthException catch (e) {
      _showAlertDialog("Error", e.message ?? "An error occurred.");
    } catch (e) {
      _showAlertDialog("Error", "An unexpected error occurred: $e");
    }
  }

  // Helper method to show an alert dialog
  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const Background(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  StringConstants.register, // Replace with `StringConstants.register` if defined
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: Dimens.fontSize_25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _nameController,
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: Dimens.fontSize_12,
                  ),
                  decoration: InputDecoration(
                    labelText: "Name", // Replace with `StringConstants.name` if defined
                    labelStyle: TextStyle(color: whiteColor),
                  ),
                ),
                TextField(
                  controller: _emailController,
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: Dimens.fontSize_12,
                  ),
                  decoration: InputDecoration(
                    labelText: "Email", // Replace with `StringConstants.email` if defined
                    labelStyle: TextStyle(color: whiteColor),
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: Dimens.fontSize_12,
                  ),
                  decoration: InputDecoration(
                    labelText: "Password", // Replace with `StringConstants.password` if defined
                    labelStyle: TextStyle(color: whiteColor),
                  ),
                  obscureText: true,
                ),
                TextField(
                  controller: _cpasswordController,
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: Dimens.fontSize_12,
                  ),
                  decoration: InputDecoration(
                    labelText: "Confirm Password", // Replace with `StringConstants.cPassword` if defined
                    labelStyle: TextStyle(color: whiteColor),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                AppButton(
                  label: "Sign Up", // Replace with `StringConstants.signup` if defined
                  onPressed: registerUser,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
