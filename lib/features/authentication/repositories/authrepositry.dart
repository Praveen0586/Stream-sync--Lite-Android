import 'package:streamsync_lite/core/fcm/notificationservice.dart';
import 'package:streamsync_lite/core/globals/globals.dart';
import 'package:streamsync_lite/features/authentication/model/userModel.dart';
import 'package:streamsync_lite/features/authentication/services/api_services.dart';
import 'package:streamsync_lite/features/authentication/services/localdatabase.dart';

class Authrepositry {
  final ApiServices apiservices;
  final Localdatabase localdatabase;

  Authrepositry(this.apiservices, this.localdatabase);

  Future<void> registerUser(String name, String email, String password) async {
    await apiservices.regiterUser(name, email, password);
    localdatabase.storeUser(
      UserModel(id: 0, email: email, token: "", name: name),
    );
  }

  Future<void> LoginUser(String email, String password) async {
    print("Login repo called ");
    final data = await apiservices.LoginUser(email, password);
    final UserModel user = UserModel(
      email: data["user"]['email'],
      name: data["user"]['name'],
      token: data['token'],
      id: data["user"]['id'],
    );
    currentuser = user;
    final fcm_token = await NotificationService.getToken();

    await sendTokenToBackend(currentuser!.id, fcm_token);
    await localdatabase.storeUser(user);
    print("✅Api tocken  ${data['token']}");
    print("✅RefreshTocken tocken  ${data['RefreshToken']}");

    await localdatabase.saveTokens(data['token'], data['RefreshToken']);
    print("Both Tockens were save in securestorage ");
  }
}
