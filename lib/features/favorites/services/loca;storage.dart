import 'package:shared_preferences/shared_preferences.dart';

class FavoritesLocalService {
  static const String keyPrefix = "fav_";

  Future<List<String>> getFavoriteIds(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("$keyPrefix$userId") ?? [];
  }

  Future<void> saveFavoriteIds(int userId, List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("$keyPrefix$userId", ids);
  }
}
