import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/controllers/base_controller.dart';
import 'package:siapjulka/helper/app_exceptions.dart';
import 'package:siapjulka/helper/dialog_helper.dart';
import 'package:siapjulka/helper/snakcbar_helper.dart';
import 'package:siapjulka/models/user.dart';
import 'package:siapjulka/network/domain.dart';

class UserController extends GetxController with BaseController {
  Map<String, dynamic>? body;
  var dataUser = User().obs;

  @override
  void onInit() {
    super.onInit();
    get();
  }

  void get() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id = preferences.getInt("login");
    Domain response = Domain(url: '/user/$id');
    await response.get().then((value) {
      body = jsonDecode(value.body);
      if (value.statusCode == 200) {
        dataUser.value = User.fromJson(body!);
      } else {
        SnackbarHelper().snackbarError('Maaf, terjadi kesalahan');
      }
    }).catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["message"]);
      } else {
        handleError(error);
      }
    });
  }
}
