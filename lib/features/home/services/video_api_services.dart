import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:streamsync_lite/core/globals/globals.dart';
import 'package:streamsync_lite/core/services/APIServices.dart';

class VideoApiServices {
  Future getVidesByChannelID(String channelID) async {
    try {
      final _url = Uri.parse(
        "${ApiConfigs.videosByChannelid}?channelId=$channelID",
      );
      final response = await http.get(
        _url,
        headers: {"Content-Type": "application/json"},
      );
// final result = await Connectivity().checkConnectivity();
// if (result == ConnectivityResult.none) {
//   return {"success": false, "message": "No internet"};
// }
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return data;
      }
    } catch (e) {
      throw ("Fetching Videos Delay !");
    }
  }

  Future<int> getNotificationCount() async {
    try {
      final uri = Uri.parse(
        ApiConfigs.GetNotificationCount,
      ).replace(queryParameters: {'userId': currentuser?.id.toString()});

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['count'] ?? 0;
        } else {
          print('Error response from server: ${data}');
          return 0;
        }
      } else {
        print('HTTP error: ${response.statusCode}');
        return 0;
      }
    } catch (e) {
      print('NotificationService Error: $e');
      return 0;
    }
  }
}
