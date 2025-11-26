import 'dart:convert';

import 'package:http/http.dart' as http;
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return data;
      }
    } catch (e) {
      throw ("Fetching Videos Delay !");
    }
  }
}
