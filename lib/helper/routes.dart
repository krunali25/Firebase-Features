
import 'package:firebase_features/screen/crashlytics.dart';
import 'package:firebase_features/screen/image.dart';
import 'package:firebase_features/screen/main_screen.dart';
import 'package:firebase_features/screen/firestore.dart';
import 'package:firebase_features/screen/remote_config.dart';
import 'package:firebase_features/screen/signin_screen.dart';
import 'package:firebase_features/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'navigation.dart';

class RoutesUri {
  static const String signup = '/signup';
  static const String signIn = '/signIn';
  static const String main = '/main';
  static const String home = '/home';
  static const String fireStore = '/firestore';
  static const String crush = '/crashlytics';
  static const String image = '/image';
  static const String remoteConfig = '/remote_config';
  static const String userList= '/usre_list';

  
}

//const List<String> unrestrictedRoutes = [RoutesUri.main];

const List<String> publicRoutes = [];


GoRouter appRouter() {
  return GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    initialLocation: RoutesUri.main,
    errorPageBuilder: (context, state) => CustomTransitionPage(
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      key: state.pageKey,
      child: const MainScreen(),
    ),
    routes: [
      GoRoute(
        path: RoutesUri.signup,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          key: state.pageKey,
          child: SignupScreen(),
        ),
      ),
      GoRoute(
        path: RoutesUri.signIn,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          key: state.pageKey,
          child: LoginScreen(),
        ),
      ),
      // GoRoute(
      //   path: RoutesUri.home,
      //   pageBuilder: (context, state) => CustomTransitionPage(
      //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //       return FadeTransition(opacity: animation, child: child);
      //     },
      //     key: state.pageKey,
      //     child: const HomeScreen(),
      //   ),
      // ),
      GoRoute(
        path: RoutesUri.fireStore,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          key: state.pageKey,
          child: const FirestoreScreen(),
        ),
      ),
      GoRoute(
        path: RoutesUri.crush,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          key: state.pageKey,
          child: const CrashlyticsScreen(),
        ),
      ),
      GoRoute(
        path: RoutesUri.image,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          key: state.pageKey,
          child: ImageUploads(),
        ),
      ),
      GoRoute(
        path: RoutesUri.remoteConfig,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          key: state.pageKey,
          child: RemoteConfigScreen(),
        ),
      ),
      // GoRoute(
      //   path: RoutesUri.userList,
      //   pageBuilder: (context, state) => CustomTransitionPage(
      //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //       return FadeTransition(opacity: animation, child: child);
      //     },
      //     key: state.pageKey,
      //     child: UserListScreen(),
      //   ),
      // ),
    ],
    redirect: (context, state) async {
      // String isLoggedIn = await AppStorage.getValue(AppStorageConstants.isLoggedIn);
      // if (unrestrictedRoutes.contains(state.matchedLocation)) {
      //   return null;
      // } else if (publicRoutes.contains(state.matchedLocation)) {
      //   // Is public route.
      //   if (isLoggedIn.isNotEmpty) {
      //     // User is logged in, redirect to home page.
      //     return RoutesUri.dashboard;
      //   }
      // } else {
      //   // Not public route.
      //   if (isLoggedIn.isEmpty) {
      //     // User is not logged in, redirect to login page.
      //     return RoutesUri.login;
      //   }
      // }

      return null;
    },
  );
}
