import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:streamsync_lite/core/services/APIServices.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  // ---- INITIALIZATION ----
  static Future<void> initialize() async {
    // 🔹 Ask permission
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    // 🔹 Local notification setup
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
    );

    await _local.initialize(initSettings);

    // 🔹 Notification Channel (important)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'default_channel',
      'General Notifications',
      description: 'Default channel for app notifications',
      importance: Importance.high,
      playSound: true,
    );

    await _local
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // 🔹 Foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });

    print("🔔 Notification Service Initialized");
  }

  // ---- SHOW LOCAL NOTIFICATION ----
  static void _showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification == null) return;

    _local.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'default_channel',
          'General Notifications',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
      ),
    );
  }

  static Future<String?> getToken() async {
    return await _messaging.getToken();
  }
}

Future<void> sendTokenToBackend(int userId, String? token) async {
  if (token == null) return;

  final url = Uri.parse("${ApiConfigs.sendFCMtoken}$userId/fcmToken");

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"token": token, "platform": "android"}),
    );

    if (response.statusCode == 200) {
      print("Token successfully sent to backend");
      return;
    } else {
      print("Failed to send token: ${response.body}");
    }
  } catch (e) {
    print("Error sending token: $e");
  }
}
