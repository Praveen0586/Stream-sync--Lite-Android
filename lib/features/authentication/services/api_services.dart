import 'dart:convert';

import 'package:streamsync_lite/core/constants/constants.dart';
import 'package:streamsync_lite/core/services/APIServices.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<void> regiterUser(String name, String email, String password) async {
    Uri url = Uri.parse(ApiConfigs.Register);
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"name": name, "email": email, "password": password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      print(data);
      return;
    } else {
      print("Status Code error ");
      throw Exception('Failed to register user');
    }
  }

  Future LoginUser(String email, String password) async {
    final _url = Uri.parse(ApiConfigs.Login);
    print("hey ");
    var response = await http.post(
      _url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"email": email, "password": password}),
    );
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("status code 1 ");
      Map<String, dynamic> data = json.decode(response.body);
      print(data);
      refreshapitocken = data['refreshToken'];
      apitoken = data['token'];

      print("data returened ");
      return data;
    } else {
      print("Status Code error ");
      throw Exception('Failed to login user');
    }
  }
}
