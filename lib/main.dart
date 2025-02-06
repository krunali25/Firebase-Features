import 'dart:ui';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_features/model/country_name_model.dart';
import 'package:firebase_features/model/restaurant_name_model.dart';
import 'package:firebase_features/provider/cake_provider.dart';
import 'package:firebase_features/provider/holiday_provider.dart';
import 'package:firebase_features/provider/job_provider.dart';
import 'package:firebase_features/provider/restaurant_provider.dart';
import 'package:firebase_features/screen/user_list.dart';
import 'package:firebase_features/screen/firebase_messaging_service.dart';
import 'package:firebase_features/screen/converastion_list.dart';
import 'package:firebase_features/screen/main_screen.dart';
import 'package:firebase_features/screen/signin_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Background message handler for Firebase Messaging
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessagingService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.deviceCheck,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError;
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<CakeProvider>(create: (_) => CakeProvider(),),
    ChangeNotifierProvider<RestaurantProvider>(create: (_) => RestaurantProvider(),),
    ChangeNotifierProvider<HolidayProvider>(create: (_) => HolidayProvider(),),
    ChangeNotifierProvider<JobProvider>(create: (_) => JobProvider(),),
  ],child:MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Features',
        theme: ThemeData(useMaterial3: false),
        initialRoute: '/mainScreen',  // 🔥 Always start from MainScreen
        routes: {
          '/mainScreen': (context) => MainScreen(),
          '/login': (context) => LoginScreen(),
          '/home': (context) {
            final currentUser = FirebaseAuth.instance.currentUser;
            return ConversationListScreen(
                currentUserId: currentUser?.uid ?? '');
          },
          '/conversations': (context) => UserListScreen(
            currentUserId: FirebaseAuth.instance.currentUser?.uid ?? '',
          ),
        },
      ),
    );
  }
}
