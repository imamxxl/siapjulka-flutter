import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:siapjulka/controllers/helper/helper_controller.dart';
import 'package:siapjulka/routes/name_route.dart';

class LoginService {
  // final url = "http://192.168.100.162:8000/api/login";

  // // login ke data base
  // Future<Response> loginData(String username, String password) async {
  //   final body = json.encode({"username": username, "password": password});
  //   return post(url, body);
  // }

  Future<void> checkLogin(String username, String password) async {
    var response = await http.post(
        // here ip for teathering smartphones
        //  Uri.parse("http://192.168.43.6:8000/api/login"),

        // here ip for wifi
        Uri.parse("http://192.168.100.162:8000/api/login"),
        body: ({"username": username, "password": password}));

    try {
      if (response.statusCode == 200) {
        // setState(() {
        //   if (_state == 0) {
        //     animateButton();
        //   }
        // });
        final body = jsonDecode(response.body);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setInt("login", body["id"]);
        Get.offAllNamed(NameRoute.home);
      } else {
        final body = jsonDecode(response.body);
        HelperController().snackbarError("${body['message']}");
      }
    } catch (e) {
      HelperController().snackbarError("Tidak dapat menghubungkan");
    }
  }
}
