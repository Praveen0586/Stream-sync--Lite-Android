import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamsync_lite/features/authentication/model/userModel.dart';

class Localdatabase {
  final SharedPreferences _prefs;
  Localdatabase(this._prefs);
  Future<void> saveTokens(String? apitoken, String? refreshToken) async {
    final sharedPreferences = await _prefs;
    sharedPreferences.setString("apitoken", apitoken.toString());
    sharedPreferences.setString("refreshtoken", refreshToken.toString());
  }

  Future<void> storeUser(UserModel user) async {
    final sharedPreferences = await _prefs;
    String userData = json.encode(user.toJson());
    sharedPreferences.setString("user", userData);
  }

  Future<UserModel?> fetchUserData() async {
    final sharedPreferences = await _prefs;
    String? userData = sharedPreferences.getString("user");
    if (userData != null) {
      Map<String, dynamic> userMap = json.decode(userData);
      return UserModel.fromJson(userMap);
    } else {
      return null;
    }
  }

  Future<void> cleanTokens() async {
    final sharedPreferences = await _prefs;
    sharedPreferences.remove("apitoken");
    sharedPreferences.remove("refreshtoken");
  }

  Future<String> getAPItoken() async {
    final sharedPreferences = await _prefs;
    return sharedPreferences.getString("apitoken") ?? "";
  }

  Future<String> getRefreshToken() async {
    final sharedPreferences = await _prefs;
    return sharedPreferences.getString("refreshtoken") ?? "";
  }
}
