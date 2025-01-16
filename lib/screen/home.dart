import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_features/helper/app_assets.dart';
import 'package:firebase_features/helper/dimens.dart';
import 'package:firebase_features/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../helper/colors.dart';
import '../helper/navigation.dart';
import '../helper/routes.dart';
import '../widgets/background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to log out the user
  Future<void> logout() async {
    try {
      await _auth.signOut(); // Firebase sign out
      print("User logged out");

      // Navigate to Sign-In screen after logout
      GoRouter.of(NavigationService.context!).go(RoutesUri.signIn);
    } catch (e) {
      print("Error logging out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            // Top wave-like container
            Background(),
            SizedBox(
              height: Dimens.height_20,
            ),
            Center(
              child: Text(
                StringConstants.appName,
                style: TextStyle(
                    color: whiteColor,
                    fontFamily: Fonts.pBold,
                    fontSize: Dimens.fontSize_25
                ),
              ),
            ),
            SizedBox(
              height: Dimens.height_20,
            ),
            AppButton(label: StringConstants.logout, onPressed: logout)
          ],
        ),
      ),
    );
  }
}
