import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  GoRouter? appRouter;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;

  static BuildContext? get context => navigatorKey.currentContext;

  static goBack() => Navigator.pop(navigatorKey.currentContext!);

  static bool checkCurrentPath(String? path) =>
      GoRouter.of(context!).routerDelegate.state!.fullPath != path;
}
