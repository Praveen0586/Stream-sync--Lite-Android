import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:streamsync_lite/core/globals/globals.dart';
import 'package:streamsync_lite/core/services/APIServices.dart';

// 🔥 Background handler MUST be at TOP LEVEL
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("🔥 Background message received: ${message.messageId}");
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  // ---- INITIALIZATION ----
  static Future<void> initialize() async {
    // ❌ REMOVE THIS (duplicate isolate)
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Ask permission
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    // Local notification init
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _local.initialize(initSettings);

    // Notification Channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'default_channel',
      'General Notifications',
      description: 'Default channel for app notifications',
      importance: Importance.high,
      playSound: true,
    );

    await _local
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Foreground message handler
    FirebaseMessaging.onMessage.listen((message) {
      _showLocalNotification(message);
    });

    // Token refresh handler
    _messaging.onTokenRefresh.listen((newToken) {
      print("🔄 New FCM Token: $newToken");
      sendTokenToBackend(currentuser!.id, newToken);
    });

    print("🔔 Notification Service Initialized");
  }

  // ---- SHOW LOCAL NOTIFICATION ----
  static void _showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
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
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  static Future<String?> getToken() async {
    return await _messaging.getToken();
  }
}

// ---- SEND TOKEN TO BACKEND ----


Future<void> sendTokenToBackend(int userId, String? token) async {
  if (token == null) return;

  final url = Uri.parse("${ApiConfigs.sendFCMtoken}$userId/fcmToken");

  try {
    final response = await http.post(
      url,
      headers: ApiConfigs.protectedHeader(),
      body: jsonEncode({"token": token, "platform": "android"}),
    );

    if (response.statusCode == 401 || response.statusCode == 400) {
      final newAccessToken = await refreshToken();
      if (newAccessToken != null && newAccessToken.isNotEmpty) {
        await sendTokenToBackend(userId, token);
      }
      return;
    }

    if (response.statusCode == 200) {
      print("✔ Token saved to backend");
    } else {
      print("❌ Failed to send token: ${response.body}");
    }
  } catch (e) {
    print("⚠ Error sending token: $e");
  }
}
