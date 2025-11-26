import 'package:streamsync_lite/features/authentication/services/localdatabase.dart';

class Splashrepo {
  final Localdatabase _localDatabase;
  Splashrepo(this._localDatabase);

  Future<bool> isUserLoggedIn() async {
    try {
      final user = await _localDatabase.fetchUserData();
      return user != null; // true if user exists in shared preferences
    } catch (e) {
      return false;
    }
  }
}
