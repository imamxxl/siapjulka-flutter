import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/controllers/base_controller.dart';
import 'package:siapjulka/helper/dialog_helper.dart';
import 'package:siapjulka/helper/snakcbar_helper.dart';
import 'package:siapjulka/helper/app_exceptions.dart';
import 'package:siapjulka/network/domain.dart';
import 'package:siapjulka/services/dio_services.dart';

class TestController extends GetxController with BaseController {
  // get Data
  void getData() async {
    showLoading('Mengambil data...');
    var response = await DioService()
        .get(Domain().baseUrl, '/users')
        .catchError(handleError);
    if (response == null) return;
    hideLoading();
  }

  // post Data
  void postData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id = preferences.getInt("login");
    var request = {"imei": "sdwdasdwadawd"};
    showLoading('Mengirim data...');
    var response = await DioService()
        .post(Domain().baseUrl, '/send_deviceid/$id', request)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["message"]);
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    hideLoading();
    SnackbarHelper().snackbarSuccess('Perangkat berhasil didaftarkan');
  }
}
