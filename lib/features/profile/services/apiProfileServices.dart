import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:streamsync_lite/core/services/APIServices.dart';

class ProfileAPi {
  Future<Map<String, dynamic>> sendAdminPush({
    required int userId,
    required String title,
    required String body,
    required String videoId,
  }) async {
    final url = Uri.parse(ApiConfigs.adminPush);

    final response = await http.post(
      url,
      headers: ApiConfigs.protectedHeader(),
      body: jsonEncode({
        "userId": userId,
        "title": title,
        "body": body,
        "metadata": {
          "type": "video",
          "action": "open_video",
          "video_id": videoId,
        },
      }),
    );
    if (response.statusCode == 400 || response.statusCode == 401) {
      return sendAdminPush(
        userId: userId,
        body: body,
        title: title,
        videoId: videoId,
      );
    } else if (response.statusCode == 200 || response.statusCode == 201)
      return jsonDecode(response.body);
    else
      throw ("Admin Push Failed");
  }

  Future<Map<String, dynamic>> sendSelfTestFCM({
    required int userId,
    required String title,
    required String body,
  }) async {
    final url = Uri.parse(ApiConfigs.selftest); // you will set URL

    final response = await http.post(
      url,
      headers: ApiConfigs.protectedHeader(),
      body: jsonEncode({"userId": userId, "title": title, "body": body}),
    );
    if (response.statusCode == 400 || response.statusCode == 401) {
      return sendSelfTestFCM(body: body, title: title, userId: userId);
    } else if (response.statusCode == 200 || response.statusCode == 201)
      return jsonDecode(response.body);
    else
      throw ("Self push Failed");
  }
}

Future<void> deleteTokenFromBackend(int userId, String token) async {
  // Use your API config
  final url = Uri.parse("${ApiConfigs.sendFCMtoken}/users/$userId/fcmToken");

  print("🗑️ Deleting token from: $url");

  try {
    final response = await http.delete(
      url,
      headers: ApiConfigs.protectedHeader(),
      body: jsonEncode({"token": token}),
    );

    print("📡 Response status: ${response.statusCode}");
    print("📄 Response body: ${response.body}");

    if (response.statusCode == 200) {
      print("✅ Token deleted successfully from backend");
    } else if (response.statusCode == 401 || response.statusCode == 400) {
      // Try to refresh token and retry
      final newAccessToken = await refreshToken();
      if (newAccessToken != null && newAccessToken.isNotEmpty) {
        await deleteTokenFromBackend(userId, token);
      }
      return;
    } else {
      print("⚠️ Failed to delete token: ${response.body}");
    }
  } catch (e) {
    print("⚠️ Error deleting token: $e");
  }
}
