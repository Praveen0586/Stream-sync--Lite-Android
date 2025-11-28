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
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": userId,
        "title": title,
        "body": body,
        "metadata": {
          "type": "video",
          "action": "open_video",
          "videoId": videoId,
        },
      }),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> sendSelfTestFCM({
    required int userId,
    required String title,
    required String body,
  }) async {
    final url = Uri.parse(ApiConfigs.selftest); // you will set URL

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"userId": userId, "title": title, "body": body}),
    );

    return jsonDecode(response.body);
  }
}
