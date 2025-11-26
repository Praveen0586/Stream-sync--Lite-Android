import 'package:streamsync_lite/features/home/models/models.dart';
import 'package:streamsync_lite/features/home/services/localStorage.dart';
import 'package:streamsync_lite/features/home/services/video_api_services.dart';

class Homerepo {
  final VideoApiServices api;
  final VideoLocalStorage local;

  Homerepo(this.api, this.local);

  Future<List<Video>> FetchVideoByChannelId(String channel_id) async {
    try {
      final cachedVideos = await local.loadVideos();
      if (cachedVideos.isNotEmpty) {
        print("🟡 Loaded videos from LOCAL CACHE");
        return cachedVideos;
      }

      final data = await api.getVidesByChannelID(channel_id);
      final List listOfVideos = data["videos"];
      final videosList = listOfVideos.map((e) {
        return Video.fromJson(e);
      }).toList(); // 3️⃣ Save to SharedPreferences
      await local.saveVideos(videosList);

      return videosList;
    } catch (e) {
      throw ("FetchStopped in Repo level");
    }
  }

  Future<List<Video>> refresh(String channelId) async {
    final data = await api.getVidesByChannelID(channelId);
    final List listOfVideos = data["videos"];

    final videosList = listOfVideos
        .map<Video>((json) => Video.fromJson(json))
        .toList();

    await local.saveVideos(videosList);

    return videosList;
  }
}
