import 'package:firebase_features/helper/app_assets.dart';
import 'package:firebase_features/helper/colors.dart';
import 'package:firebase_features/screen/signin_screen.dart';
import 'package:firebase_features/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../helper/navigation.dart';
import '../helper/routes.dart';
import '../widgets/app_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
              height: 20,
            ),

            AppButton(
                label: StringConstants.auth,
                onPressed: () {
                  GoRouter.of(NavigationService.context!).go(RoutesUri.signIn);
                }),
            SizedBox(
              height: 20,
            ),
            AppButton(
                label: StringConstants.fireStore,
                onPressed: () {
                  GoRouter.of(NavigationService.context!).go(RoutesUri.fireStore);
                }),
            SizedBox(
              height: 20,
            ),
            AppButton(
                label: StringConstants.crashlytics,
                onPressed: () {
                  GoRouter.of(NavigationService.context!).go(RoutesUri.crush);
                }),
            SizedBox(
              height: 20,
            ),
            AppButton(
                label: StringConstants.image,
                onPressed: () {
                  GoRouter.of(NavigationService.context!).go(RoutesUri.image);
                }),
          ],
        ),
      ),
    );
  }
}
