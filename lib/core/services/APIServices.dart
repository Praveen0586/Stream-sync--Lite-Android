import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamsync_lite/core/di/dependencyinjection.dart';
import 'package:streamsync_lite/core/globals/globals.dart';
import 'package:streamsync_lite/features/authentication/services/localdatabase.dart';

class ApiConfigs {
  static const liveurl = "";

  static const testurl = "http://10.151.63.246:3000";

  static String baseURL = isLiveAPI ? liveurl : testurl;

  //API links
  static String Register = baseURL + "/auth/register";
  static String Login = baseURL + "/auth/login";
  static String refreshtocken = baseURL + "/auth/refresh";

  static String videosByChannelid = baseURL + "/videos/latest";
  static String getVideoByID = baseURL + "/videos/";
  static String sendProgress = baseURL + "/videos/progress";
  static String getProgress = baseURL + "/videos/progress/get";

  static String getNotifications = "$baseURL/notifications";
  static String GetNotificationCount = "$baseURL/notifications/count";
  static String deleteANotification = "$baseURL/notifications/";
  static String markAsRead = "$baseURL/notifications/mark-read";
  static String adminPush = "$baseURL/notifications";
  static String selftest = "$baseURL/notifications/send-test";

  static String sendFCMtoken = "$baseURL/users/";

  static String addfavorites = "$baseURL/favorites/add";
  static String removeFavorites = "$baseURL/favorites/remove";
  static String getallfaoritesIDs = "$baseURL/favorites/";
  static String getvideosbybatch = "$baseURL/favorites/batch";

static Map<String, String> protectedHeader() {
  return {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apitoken',
  };
}

}

Future<String?> refreshToken() async {
  final storage = getIt<Localdatabase>();
  final refreshToken = storage.getRefreshToken();
  print(refreshToken);
  if (refreshToken == null) return null;

  final response = await http.post(
    Uri.parse(ApiConfigs.refreshtocken),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"refreshToken": refreshToken}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final newAccessToken = data['token'];
    apitoken = newAccessToken;

    storage.newAccesToken(newAccessToken);
    return newAccessToken;
  } else {
    print("Refresh token failed: ${response.body}");
    return null;
  }
}
