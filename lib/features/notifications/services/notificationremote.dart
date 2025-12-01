import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:streamsync_lite/core/globals/globals.dart';
import 'package:streamsync_lite/core/services/APIServices.dart';
import 'package:streamsync_lite/features/notifications/models/models.dart';

class NotificationRemoteService {
  NotificationRemoteService();
  Future<List<NotificationModel>> fetchNotifications() async {
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

      final res = await http.get(uri, headers: ApiConfigs.protectedHeader());
      if (res.statusCode == 401 || res.statusCode == 400) {
        final newToken = await refreshToken();
        if (newToken != null) {
          return await fetchNotifications();
        } else {
          throw Exception('Failed to fetch favorite videos');
        }
      }
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final List<dynamic> list = body['notifications'] ?? [];
        return list.map((e) => NotificationModel.fromJson(e)).toList();
      } else {
        throw Exception("Failed to fetch notifications");
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<void> markAsRead(String id) async {
    final uri = Uri.parse(ApiConfigs.markAsRead);
    final res = await http.post(
      uri,
      headers: ApiConfigs.protectedHeader(),
      body: jsonEncode({
        "notificationIds": [id],
        "userId": currentuser!.id,
      }),
    );
    if (res.statusCode == 401 || res.statusCode == 400) {
      final newToken = await refreshToken();
      if (newToken != null) {
        return await markAsRead(id);
      } else {
        throw Exception('Failed to fetch favorite videos');
      }
    }
    if (res.statusCode != 200) {
      throw Exception("Failed to mark notification as read");
    }
  }

  Future<bool> deleteNotification(int id, int userId) async {
    final url = Uri.parse(
      "${ApiConfigs.deleteANotification}$id?userId=$userId",
    );

    final res = await http.delete(url, headers: ApiConfigs.protectedHeader());

    if (res.statusCode == 401 || res.statusCode == 400) {
      final newToken = await refreshToken();
      if (newToken != null) {
        return await deleteNotification(id, userId);
      } else {
        throw Exception('Failed to fetch favorite videos');
      }
    } else if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['success'] == true;
    } else {
      return false;
    }
  }

  Future<void> markAllAsRead(List<String> ids) async {
    final uri = Uri.parse(ApiConfigs.markAsRead);

    final res = await http.post(
      uri,
      headers: ApiConfigs.protectedHeader(),
      body: jsonEncode({
        "userId": currentuser!.id,
        "notificationIds": ids, // 🔥 Send entire list
      }),
    );

    if (res.statusCode == 401 || res.statusCode == 400) {
      final newToken = await refreshToken();
      if (newToken != null) {
        return await markAllAsRead(ids);
      } else {
        throw Exception('Failed to fetch favorite videos');
      }
    }

    print("MARK MANY RESPONSE: ${res.body}");
    if (res.statusCode != 400 || res.statusCode != 401) {
      return await markAllAsRead(ids);
    } else if (res.statusCode != 200) {
      throw Exception("Failed to mark many as read");
    }
  }

  // Future<void> markAllAsRead() async {
  //   final uri = Uri.parse(ApiConfigs.markAsRead);
  //   final res = await http.post(
  //     uri,
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode({"userId": currentuser!.id, "all": true}),
  //   );

  //   if (res.statusCode != 200) {
  //     throw Exception("Failed to mark all notifications as read");
  //   }
  // }
}
