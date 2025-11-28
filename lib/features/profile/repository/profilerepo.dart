import 'package:streamsync_lite/features/profile/services/apiProfileServices.dart';

class ProfileRepository {
  ProfileAPi api;
  ProfileRepository(this.api);
  Future<bool> sendAdminPush(
    int userId,
    String title,
    String body,
    String videoId,
  ) async {
    final res = await api.sendAdminPush(
      userId: userId,
      title: title,
      body: body,
      videoId: videoId,
    );

    return res["success"] == true;
  }
}
