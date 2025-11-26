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
}
