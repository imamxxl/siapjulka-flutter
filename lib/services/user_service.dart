import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/models/user.dart';
import 'package:siapjulka/network/domain.dart';

class UserService {
  final String url = Domain().baseUrl;

  // get user berdasarkan preference id
  Future<User> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id = preferences.getInt("login");

    final response = await http.get(Uri.parse("$url/user/$id"));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal mendapatkan user');
    }
  }
}
