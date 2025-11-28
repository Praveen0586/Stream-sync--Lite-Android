import 'package:streamsync_lite/features/favorites/model/favModel.dart';
import 'package:streamsync_lite/features/favorites/services/apicalls_favorites.dart';
import 'package:streamsync_lite/features/favorites/services/loca;storage.dart';
import 'package:streamsync_lite/features/home/models/models.dart';

class FavoritesRepository {
  final FavoritesLocalService local;
  final FavoritesRemoteService remote;

  FavoritesRepository({required this.local, required this.remote});

  Future<List<String>> getFavoriteIds(int userId) {
    return local.getFavoriteIds(userId);
  }

  Future<List<FavVideoModel>> getVideoDetails() async {
    print("getting Fav started ");
    final ids = await remote.fetchFavoriteIds();
    print("Ids fetched ");
    final videList = await remote.getFavoriteVideos(ids);
    print("lits also Fetched ");
    return videList;
  }

  Future<void> addFavorite(int userId, String videoId) async {
    print("adding -fav");
    await remote.addFavorite(userId, videoId);

    final current = await local.getFavoriteIds(userId);
    if (!current.contains(videoId)) {
      current.add(videoId);
      await local.saveFavoriteIds(userId, current);
    }
  }

  Future<void> removeFavorite(int userId, String videoId) async {
    await remote.removeFavorite(userId, videoId);

    final current = await local.getFavoriteIds(userId);
    current.remove(videoId);
    await local.saveFavoriteIds(userId, current);
  }
}
