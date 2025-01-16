import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Enable Push notication logic

  Future<void> init() async {
    // Initialize Firebase
    await Firebase.initializeApp();

    // Request permission (iOS only)
    final firebaseMessaging = FirebaseMessaging.instance;
    final settings = await firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Success: User authorized notifications');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('Success: User authorized notifications provisionnal');
    } else {
      print('Fail: User declined notifications');
      // When it fails, open the settings page.
    }
    // Get the FCM token
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');  // This will be useful for sending notifications to the device

    // Set up foreground notification handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.title}');
      showNotification(message);
    });

    // Set up background notification handling
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
      // Handle navigation when notification is clicked
    });

    // Initialize Firebase Cloud Messaging for background state when the app is terminated
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> showNotification(RemoteMessage message) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );

    var android = AndroidNotificationDetails(
      'your_channel_id', // channelId
      'your_channel_name', // channelName
      // 'your_channel_description', // channelDescription
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('notification'),
      // Additional properties for handling notification sounds, vibration, etc.
    );

    NotificationDetails platformDetails = NotificationDetails(android: android);


    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID (can be used to update specific notifications)
      message.data['title'] ?? 'Default Title', // Notification title
      message.data['body'] ?? 'Default Body', // Notification body
      platformDetails,
      payload: 'item x', // Optional payload
    );
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    showNotification(message);
  }
}
