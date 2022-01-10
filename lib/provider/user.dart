import 'dart:convert';

import '/constants/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  Future<bool> register(String fullName, String email, String password) async {
    var response;
    try {
      var body = jsonEncode({
        "fullName": fullName,
        "email": email,
        "password": password,
      });

      response = await http.post(Uri.parse(API_URL + "register"),
          body: body, headers: {"Content-Type": "application/json"});
      var data = json.decode(response.body) as Map;
      if (response.statusCode == 200) {
        await saveToken(data['token'].toString());
        _isAuthenticated = true;
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    var response;
    try {
      var body = jsonEncode({
        "email": email,
        "password": password,
      });
      response = await http.post(Uri.parse(API_URL + "login"),
          body: body, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map;
        await saveToken(data['token'].toString());
        _isAuthenticated = true;
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<Map<dynamic, dynamic>> getUser() async {
    Map result = new Map<dynamic, dynamic>();
    final String? token = await UserProvider().getToken();
    final parts = token!.split('.');
    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    var decoded = utf8.decode(base64Url.decode(normalized));
    var data = json.decode(decoded) as Map;
    var id = data['id'];
    var response;
    try {
      response = await http.get(Uri.parse(API_URL + 'user/$id'));
      if (response.statusCode == 200) {
        result = json.decode(response.body.data) as Map;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  logout() async {
    _isAuthenticated = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<Map<dynamic, dynamic>> userInfo() async {
    Map result = new Map<dynamic, dynamic>();
    try {
      final String? token = await getToken();
      final parts = token!.split('.');
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      var decoded = utf8.decode(base64Url.decode(normalized));
      var data = json.decode(decoded) as Map;
      var id = data['id'];
      var response;
      response = await http.get(Uri.parse(API_URL + 'user/$id'));
      if (response.statusCode == 200) {
        result = json.decode(response.body.data) as Map;
        notifyListeners();
      }
    } catch (err) {

    }
    return result;
  }
}
