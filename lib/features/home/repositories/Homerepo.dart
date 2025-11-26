import 'package:streamsync_lite/features/home/models/models.dart';
import 'package:streamsync_lite/features/home/services/localStorage.dart';
import 'package:streamsync_lite/features/home/services/video_api_services.dart';

class Homerepo {
  final VideoApiServices api;
  final VideoLocalStorage local;

  Homerepo(this.api, this.local);

  Future<List<Video>> FetchVideoByChannelId(String channel_id) async {
    try {
      final data = await api.getVidesByChannelID(channel_id);
      final List listOfVideos = data["videos"];
      final videosList = listOfVideos.map((e) {
        return Video.fromJson(e);
      }).toList();
      return videosList;
    } catch (e) {
      throw ("FetchStopped in Repo level");
    }
  }
}
