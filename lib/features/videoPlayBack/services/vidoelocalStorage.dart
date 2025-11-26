import 'package:shared_preferences/shared_preferences.dart';

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
}
