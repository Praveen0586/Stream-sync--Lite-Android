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
          "videoId": videoId,
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
    } else if (response.statusCode == 200||response.statusCode == 201)
      return jsonDecode(response.body);
      else throw ("Self push Failed");
  }
}
