import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamsync_lite/core/globals/globals.dart';
import 'package:streamsync_lite/features/authentication/model/userModel.dart';
class Localdatabase {
  final SharedPreferences _prefs;
  Localdatabase(this._prefs);

  Future<void> saveTokens(String? apiToken, String? refreshToken) async {
    final sharedPreferences = await _prefs;
    if (apiToken != null) {
      global_apitoken =apiToken;
      await sharedPreferences.setString("apitoken", apiToken);
    }
    if (refreshToken != null) {
      global_refreshapitocken=refreshToken;
      await sharedPreferences.setString("refreshtoken", refreshToken);
    }
    print("DEBUG: Tokens saved → apiToken: $apiToken, refreshToken: $refreshToken");
  }

  Future<void> storeUser(UserModel user) async {
    final sharedPreferences = await _prefs;
    String userData = json.encode(user.toJson());
    await sharedPreferences.setString("user", userData);
    print("DEBUG: User stored in SharedPreferences");
  }

  Future<UserModel?> fetchUserData() async {
    final sharedPreferences = await _prefs;
    String? userData = sharedPreferences.getString("user");
    if (userData != null) {
      Map<String, dynamic> userMap = json.decode(userData);
      final UserModel _user = UserModel.fromJson(userMap);
      currentuser = _user;
      print("DEBUG: Current user loaded");
      return _user;
    }
    return null;
  }

  Future<void> newAccessToken(String newAccessToken) async {
    final sharedPreferences = await _prefs;
    await sharedPreferences.setString("apitoken", newAccessToken);
    global_apitoken=newAccessToken;
    print("DEBUG: API token updated → $newAccessToken");
  }

  Future<void> cleanTokens() async {
    final sharedPreferences = await _prefs;
    await sharedPreferences.remove("apitoken");
    await sharedPreferences.remove("refreshtoken");
    print("DEBUG: Tokens cleared");
  }

  Future<String?> getAPItoken() async {
    final sharedPreferences = await _prefs;
    final token = sharedPreferences.getString("apitoken");
    print("DEBUG: API token fetched → $token");
    return token;
  }

  Future<String?> getRefreshToken() async {
    final sharedPreferences = await _prefs;
    final token = sharedPreferences.getString("refreshtoken");
    print("DEBUG: Refresh token fetched → $token");
    return token;
  }
}
