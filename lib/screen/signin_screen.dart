import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_features/helper/app_assets.dart';
import 'package:firebase_features/helper/dimens.dart';
import 'package:firebase_features/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../helper/colors.dart';
import '../helper/navigation.dart';
import '../helper/routes.dart';
import '../widgets/app_button.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Sign-in logic
  Future<void> signInUser() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showAlertDialog("Error", "Please fill in all fields.");
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Show success message and navigate
      _showAlertDialog("Success", "Login successful!");
      GoRouter.of(NavigationService.context!).go(RoutesUri.home);
    } on FirebaseAuthException catch (e) {
      _showAlertDialog("Error", e.message ?? "An error occurred.");
    } catch (e) {
      _showAlertDialog("Error", "An unexpected error occurred: $e");
    }
  }

  // Show alert dialog method
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
                  StringConstants.login, // Replace StringConstants.login if not defined
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: Dimens.fontSize_25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _emailController,
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: Dimens.fontSize_12,
                  ),
                  decoration: InputDecoration(
                    labelText: StringConstants.email, // Replace StringConstants.email if not defined
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
                    labelText: StringConstants.password, // Replace StringConstants.password if not defined
                    labelStyle: TextStyle(color: whiteColor),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: Dimens.height_20),
                AppButton(
                  label: StringConstants.login, // Replace StringConstants.login if not defined
                  onPressed: signInUser,
                ),
                SizedBox(height: Dimens.height_20),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(NavigationService.context!).push(RoutesUri.signup);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: StringConstants.dontHaveAccount, // Replace StringConstants.dontHaveAccount if not defined
                          style: TextStyle(
                            color: whiteColor,
                          ),
                        ),
                        TextSpan(
                          text: RoutesUri.signup, // Replace StringConstants.signup if not defined
                          style: TextStyle(
                            color: buttonBackground,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
