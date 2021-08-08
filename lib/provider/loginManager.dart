import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginManager with ChangeNotifier {
  int _userId = -1;
  Future login(username, password) async {
    try {
      final res =
          await http.post(Uri.parse("https://hostforexaa.glitch.me/getUserId"),
              headers: <String, String>{
                'Content-Type': 'application/json',
              },
              body: json.encode({"userName": username, "password": password}));
      if (res.body == "Incorrect username and/or password") {
        return -1;
      }
      _userId = json.decode(res.body)['id'];
    } catch (e) {
      print('error3' + e.toString());
      return -5;
    }
    notifyListeners();
    return _userId;
  }

  int get userId {
    return _userId;
  }
}
