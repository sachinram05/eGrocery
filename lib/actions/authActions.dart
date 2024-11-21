import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthActions {
  static const String _baseUrl = 'https://shareittofriends.com/demo/flutter';


  Future<Map<String, Object>> loginUser(data) async {
    const String endPoint = "/Login.php";
    try {
      Uri loginUri = Uri.parse('$_baseUrl$endPoint');
      http.Response response = await http.post(loginUri, body: data);
      final body = json.decode(response.body);
      if (response.statusCode == 200) {
        final saveUser = await SharedPreferences.getInstance();
        await saveUser.setString('token', body['data']['user_token']);
        await saveUser.setString('name', body['data']['name']);
        await saveUser.setString('mobile', body['data']['mobile']);
        await saveUser.setString('email', body['data']['email']);
        return {"status": true, "message": body['message']};
      } else {
        return {"status": false, "message": body['message']};
      }
    } catch (err) {
      return {"status": false, "message": err.toString()};
    }
  }

  Future<Map<String, Object>> registerUser(data) async {
    const String endPoint = "/Register.php";
    try {
      Uri loginUri = Uri.parse('$_baseUrl$endPoint');
      http.Response response = await http.post(loginUri, body: data);
      final body = json.decode(response.body);
      if (response.statusCode == 200) {
        final saveUser = await SharedPreferences.getInstance();
        await saveUser.setString('token', body['data']['user_token']);
        await saveUser.setString('name', body['data']['name']);
        await saveUser.setString('mobile', body['data']['mobile']);
        await saveUser.setString('email', body['data']['email']);
        return {"status": true, "message": body['message']};
      } else {
        return {"status": false, "message": body['message']};
      }
    } catch (err) {
      return {"status": false, "message": err.toString()};
    }
  }
}
