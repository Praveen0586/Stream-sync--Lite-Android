import 'package:http/http.dart' as http;
import 'package:streamsync_lite/core/globals/globals.dart';
import 'package:streamsync_lite/core/services/APIServices.dart';
import 'package:streamsync_lite/features/favorites/model/favModel.dart';
import 'dart:convert';

class FavoritesRemoteService {
  FavoritesRemoteService();

  Future<void> addFavorite(int userId, String videoId) async {
    print("addingfav");
    final res = await http.post(
      Uri.parse(ApiConfigs.addfavorites),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": userId, "video_id": videoId}),
    );
print("statuscode ${res.statusCode}");
    if (res.statusCode != 200) {
      throw Exception("Failed to add favorite");
    }
  }

  Future<void> removeFavorite(int userId, String videoId) async {
    final res = await http.delete(
      Uri.parse(ApiConfigs.removeFavorites),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": userId, "video_id": videoId}),
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to remove favorite");
    }
  }

  Future<List<FavVideoModel>> getFavoriteVideos(List<String> videoIds) async {
    final url = Uri.parse(ApiConfigs.getvideosbybatch);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'video_ids': videoIds}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => FavVideoModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch favorite videos');
    }
  }

  Future<List<String>> fetchFavoriteIds() async {
    final userId = currentuser?.id;
    final url = Uri.parse('${ApiConfigs.getallfaoritesIDs}$userId');

    final resp = await http.get(url);

    if (resp.statusCode != 200) {
      throw Exception("Failed to fetch favorites: ${resp.statusCode}");
    }

    final List data = jsonDecode(resp.body);

    /// Extract only the video_id from each item in the array
    final ids = data.map<String>((item) => item['video_id'] as String).toList();

    return ids;
  }

  // Future<Video> getvideoids() async {
  //   final res = await http.get(
  //     Uri.parse("${ApiConfigs.getallfaorites}${currentuser?.id}"),
  //   );

  //   if (res.statusCode != 200) {
  //     throw Exception("Video not found");
  //   }

  //   return Video.fromJson(jsonDecode(res.body));
  // }
}
