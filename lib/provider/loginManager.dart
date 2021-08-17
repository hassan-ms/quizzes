import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginManager with ChangeNotifier {
  static const url = "";
  int _userId = -1;
  Future login(username, password) async {
    try {
      final res = await http.post(Uri.parse("$url/getUserId"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode({"userName": username, "password": password}));
      if (res.body == "Incorrect username and/or password") {
        return -1;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString('password', password);
      _userId = json.decode(res.body)['id'];
    } catch (e) {
      return -5;
    }
    notifyListeners();

    return _userId;
  }

  int get userId {
    return _userId;
  }

  Future<int> smothLogin() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username')!;
      final password = prefs.getString('password')!;
      final logcode = await login(username, password);
      return logcode;
    } catch (_) {
      return -5;
      //go to login screen direct
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', '');
    prefs.setString('password', '');
  }
}
