import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/controllers/base_controller.dart';
import 'package:siapjulka/helper/app_exceptions.dart';
import 'package:siapjulka/helper/dialog_helper.dart';
import 'package:siapjulka/helper/snakcbar_helper.dart';
import 'package:siapjulka/network/domain.dart';
import 'package:siapjulka/routes/name_route.dart';

class LoginController extends GetxController with BaseController {
  Map<String, dynamic>? body;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void checkLogin() async {
    // Here we check if user already login or id already available or not
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? val = preferences.getInt("login");
    if (val != null) {
      Get.offNamed(NameRoute.home);
    }
  }

  void login() async {
    if (passwordController.text.isNotEmpty &&
        usernameController.text.isNotEmpty) {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      Domain request = Domain(url: '/login', body: {
        'username': usernameController.text,
        'password': passwordController.text,
      });

      showLoading('Login...');

      await request.post().then((value) {
        body = jsonDecode(value.body);

        try {
          if (value.statusCode == 200) {
            hideLoading();
            preferences.setInt('login', body!['id']);
            Get.offAllNamed(NameRoute.home);
          } else {
            hideLoading();
            SnackbarHelper().snackbarError(body!["message"]);
          }
        } catch (error) {
          hideLoading();
          if (error is BadRequestException) {
            var apiError = json.decode(error.message!);
            DialogHelper.showErrorDialog(description: apiError["message"]);
          } else {
            handleError(error);
          }
        }
      });
    } else {
      SnackbarHelper().snackbarError("Username dan Password harus diisi");
    }
  }
}
