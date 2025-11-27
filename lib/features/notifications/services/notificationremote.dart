import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:streamsync_lite/core/globals/globals.dart';
import 'package:streamsync_lite/core/services/APIServices.dart';
import 'package:streamsync_lite/features/notifications/models/models.dart';

class NotificationRemoteService {
  NotificationRemoteService();
  Future<List<NotificationModel>> fetchNotifications() async {

    print("hey i am getting noti");
    if (currentuser == null) {
      throw Exception("User not logged in");
    }

    try {
      final uri = Uri.parse(ApiConfigs.getNotifications).replace(
        queryParameters: {
          "userId": currentuser!.id.toString(),
          "limit": "50",
          "since": "0",
        },
      );

      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(res.body);
        final List<dynamic> data = responseBody["notifications"] ?? [];
        return data.map((e) => NotificationModel.fromJson(e)).toList();
      } else {
        throw Exception(
          "Failed to load notifications: ${res.statusCode} ${res.body}",
        );
      }
    } catch (e) {
      throw Exception("Error fetching notifications: $e");
    }
  }




// Future<void> markNotificationRead(String id) async {
//   final uri = Uri.parse("${ApiConfigs.markNotificationRead}/$id");
//   await http.post(uri, body: {"userId": currentuser!.id.toString()});
// }


}
