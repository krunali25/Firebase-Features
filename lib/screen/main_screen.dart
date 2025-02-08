import 'package:firebase_features/helper/app_assets.dart';
import 'package:firebase_features/helper/colors.dart';
import 'package:firebase_features/screen/cake_screen.dart';
import 'package:firebase_features/screen/firestore.dart';
import 'package:firebase_features/screen/holiday_screen.dart';
import 'package:firebase_features/screen/image.dart';
import 'package:firebase_features/screen/job_screen.dart';
import 'package:firebase_features/screen/remote_config.dart';
import 'package:firebase_features/screen/restaurant.dart';
import 'package:firebase_features/screen/signin_screen.dart';
import 'package:firebase_features/screen/video_screen.dart';
import 'package:firebase_features/widgets/background.dart';
import 'package:flutter/material.dart';

import '../widgets/app_button.dart';
import 'crashlytics.dart';

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
      body: SingleChildScrollView(
        child: Padding(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              AppButton(
                  label: StringConstants.fireStore,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FirestoreScreen()),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              AppButton(
                  label: StringConstants.crashlytics,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CrashlyticsScreen()),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              AppButton(
                  label: StringConstants.image,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ImageUploads()),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              AppButton(
                  label: StringConstants.abTesting,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RemoteConfigScreen()),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              AppButton(
                  label: StringConstants.cake,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CakeScreen()),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              AppButton(
                  label: StringConstants.restaurant,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RestaurantScreen()),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              AppButton(
                  label: StringConstants.holiday,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HolidayScreen()),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              AppButton(
                  label: StringConstants.job,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JobScreen()),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              AppButton(
                  label: StringConstants.video,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoScreen()),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
