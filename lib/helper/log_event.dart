import 'package:firebase_analytics/firebase_analytics.dart';

final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
void logCustomEvent() async {
  await analytics.logEvent(
    name: 'test_event',
    parameters: {'test_param': 'value'},
  );
}