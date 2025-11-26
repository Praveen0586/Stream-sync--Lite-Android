import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:streamsync_lite/core/services/APIServices.dart';

class Videppreviewapi {
  Future<void> updateProgress({
    required String videoId,
    required String userId,
    required int progress,
  }) async {
    final url = Uri.parse(ApiConfigs.sendProgress);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "videoId": videoId,
        "userId": userId,
        "progress": progress,
      }),
    );

   if (response.statusCode != 200 && response.statusCode != 201) {
  throw Exception("Failed to update progress");
}
  }

  Future<int> getProgress(String videoId, String userId) async {
    try {
      final url = Uri.parse(ApiConfigs.getProgress);

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"videoID": videoId, "userID": userId}),
      );

      if (response.statusCode != 200)
        throw Exception("Failed to load progress");

      final data = jsonDecode(response.body);
      return data["progress"] ?? 0;
    } catch (e) {
      throw (e);
    }
  }

}
