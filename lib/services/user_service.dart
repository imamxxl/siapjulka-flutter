import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/models/user.dart';

class UserService {
  final String url = "http://192.168.100.162:8000/api";

  Future<User> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id = preferences.getInt("login");

    final response = await http.get(Uri.parse("$url/user/$id"));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  // Future<dynamic> getAPICall(String url, BuildContext context) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   int? id = preferences.getInt("login");

  //   try {
  //     final response = await http
  //         .get(Uri.parse(url + "/user" + "$id"))
  //         .timeout(const Duration(seconds: 10), onTimeout: () {
  //       throw TimeoutException(
  //           'The connection has timed out, Please try again!');
  //     });

  //     print("Success");
  //     return response;
  //   } on SocketException {
  //     print("You are not connected to internet");
  //   }
  // }
}
