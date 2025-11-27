import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamsync_lite/features/home/models/models.dart';

class VideoPlayLocalStorage {
  final SharedPreferences prefs;
  VideoPlayLocalStorage(this.prefs);
  static const String dirtyPrefix = "dirty_";

  Future<void> saveProgress(String videoId, String userId, int progress) async {
    await prefs.setInt("progress_${userId}_$videoId", progress);
  }

  Future<int> getProgress(String videoId, String userId) async {
    return prefs.getInt("progress_${userId}_$videoId") ?? 0;
  }

  Future<bool> isDirty(String videoId) async {
    return prefs.getBool("$dirtyPrefix$videoId") ?? false;
  }

  Future<void> markSynced(String videoId) async {
    await prefs.setBool("$dirtyPrefix$videoId", false);
  }

  Future<void> saveVideo(Video video) async {
    final jsonStr = jsonEncode(video.toJson());
    await prefs.setString("video_${video.videoId}", jsonStr);
  }

  Future<Video?> getVideo(String videoId) async {
    print("checking video metadatas");
    final jsonStr = prefs.getString("video_$videoId");
    if (jsonStr == null) return null;
    print("checking video metadatas through api");
    final jsonData = jsonDecode(jsonStr);
    return Video.fromJson(jsonData);
  }

  Future<void> clearVideo(String videoId) async {
    await prefs.remove("video_$videoId");
  }
}
