import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../helper/app_assets.dart';
import '../helper/colors.dart';
import '../helper/dimens.dart';
import '../widgets/app_button.dart';
import '../widgets/background.dart';

class CrashlyticsScreen extends StatefulWidget {
  const CrashlyticsScreen({super.key});

  @override
  State<CrashlyticsScreen> createState() => _CrashlyticsScreenState();
}

class _CrashlyticsScreenState extends State<CrashlyticsScreen> {

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
                  StringConstants.crashlytics, // Replace StringConstants.login if not defined
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: Dimens.fontSize_25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Dimens.height_20),
                AppButton(
                  label: StringConstants.crash, // Replace StringConstants.login if not defined
                  onPressed: (){
                    FirebaseCrashlytics.instance.crash();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
