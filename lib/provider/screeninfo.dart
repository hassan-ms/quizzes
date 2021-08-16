import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Information with ChangeNotifier {
  String logo = "";
  String phone = "";
  List get info {
    return [logo, phone];
  }

  static const url = "https://hostforexaa.glitch.me";
  static const appId = 1;
  Future<void> fetchInfo() async {
    try {
      final res = await http.get(
        Uri.parse('$url/appInfo/$appId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      );

      final resBody = json.decode(res.body);
      logo = resBody[0]['logo'];
      phone = resBody[0]['phone'];
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}
