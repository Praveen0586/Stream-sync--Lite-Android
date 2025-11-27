import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamsync_lite/features/notifications/models/models.dart';

class NotificationLocalService {
  static const String key = "notifications_cache";

  Future<void> saveToCache(List<NotificationModel> list) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      key,
      jsonEncode(list.map((e) => e.toJson()).toList()),
    );
  }

  Future<List<NotificationModel>> loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);

    if (jsonString == null) return [];
    List data = jsonDecode(jsonString);
    return data.map((e) => NotificationModel.fromJson(e)).toList();
  }
}
