import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamsync_lite/features/home/models/models.dart';

class VideoLocalStorage {
  final SharedPreferences sharedPreferences;
  VideoLocalStorage(this.sharedPreferences);

  static const String _keyVideos = "local_saved_videos";

  Future<void> saveVideos(List<Video> videos) async {
    final prefs = await SharedPreferences.getInstance();

    final encodedList = videos.map((v) => jsonEncode(v.toJson())).toList();

    await prefs.setStringList(_keyVideos, encodedList);
  }

  Future<List<Video>> loadVideos() async {
    final prefs = await SharedPreferences.getInstance();

    final stored = prefs.getStringList(_keyVideos);
    if (stored == null) return [];

    return stored.map((jsonStr) {
      return Video.fromJson(jsonDecode(jsonStr));
    }).toList();
  }

  Future<void> clearVideos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyVideos);
  }

  Future<void> saveProgress(String videoId, String userId, int progress) async {}
}
