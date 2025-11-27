import 'package:streamsync_lite/features/home/models/models.dart';
import 'package:streamsync_lite/features/videoPlayBack/services/videpPreviewAPi.dart';
import 'package:streamsync_lite/features/videoPlayBack/services/vidoelocalStorage.dart';

class Videoplayrepo {
  final Videppreviewapi service;
  final VideoPlayLocalStorage local;
  Videoplayrepo(this.service, this.local);

  Future<void> updateVideoProgress(
    String videoId,
    String userId,
    int progress,
  ) async {
    await local.saveProgress(videoId, userId, progress);
    return service.updateProgress(
      videoId: videoId,
      userId: userId,
      progress: progress,
    );
  }

  // Future<int> loadProgress(String videoId, String userId) {
  //   return service.getProgress(videoId, userId);
  // }

  Future<int> getVideoProgress(String videoId, String userId) async {
    int localProgress = await local.getProgress(videoId, userId);

    if (localProgress > 0) return localProgress;

    // else load from serverF
    return await service.getProgress(videoId, userId);
  }

  Future<Video> fetchVideoByID(String videoId) async {
    // 1. Check local copy
    final localCopy = await local.getVideo(videoId);
    if (localCopy != null) {
      print("Loaded video from local storage");
      return localCopy;
    }

    final video = await service.getVideoByID(videoId);

    await local.saveVideo(video);

    return video;
  }

  // Future<VideoMetadata> getVideoMetadata(String videoId) async {
  //   return await service.(videoId);
  // }

  // /// NEW METHOD - Update likes
  // Future<void> updateLikes(String videoId, bool liked) async {
  //   return await service.updateLikes(videoId, liked);
  // }
}
