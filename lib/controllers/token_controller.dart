import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:siapjulka/controllers/base_controller.dart';
import 'package:siapjulka/helper/app_exceptions.dart';
import 'package:siapjulka/helper/dialog_helper.dart';
import 'package:siapjulka/helper/snakcbar_helper.dart';
import 'package:siapjulka/models/token/token_success.dart';
import 'package:siapjulka/network/domain.dart';
import 'package:siapjulka/pages/search_token/hasil_search_page.dart';

class TokenController extends GetxController with BaseController {
  Map<String, dynamic>? body;
  var tokenSuccess = TokenSuccess().obs;

  TextEditingController tokenController = TextEditingController();

  TextEditingController seksiController = TextEditingController();
  TextEditingController userContnroller = TextEditingController();
  TextEditingController deviceController = TextEditingController();

  void toHasilSearchPage() async {
    get();
  }

  void get() async {
    Domain response = Domain(url: '/cari_kelas', body: {
      'token': tokenController.text,
    });

    await response.post().then(
      (value) {
        body = jsonDecode(value.body);
        try {
          if (value.statusCode == 200) {
            if (body!['status'] == 'Success') {
              tokenSuccess.value = TokenSuccess.fromJson(body!);
              Get.to(
                () => const HasilSearchPage(),
              );
            } else {
              SnackbarHelper().snackbarWarning(body!["message"]);
            }
          } else {
            SnackbarHelper().snackbarError(body!["message"]);
          }
        } catch (error) {
          if (error is BadRequestException) {
            var apiError = json.decode(error.message!);
            DialogHelper.showErrorDialog(description: apiError["message"]);
          } else {
            handleError(error);
          }
        }
      },
    );
  }

  void post() async {
    Domain response = Domain(url: '/join_kelas', body: {
      'id_seksi': seksiController.text,
      'user_id': userContnroller.text,
      'device_id': deviceController.text,
    });

    showLoading('Mengirim data...');
    await response.post().then(
      (value) {
        body = jsonDecode(value.body);
        try {
          if (value.statusCode == 200) {
            if (body!['status'] == 'Success') {
              hideLoading();
              Get.back();
              SnackbarHelper().snackbarSuccess(body!["message"]);
              tokenSuccess.value = TokenSuccess.fromJson(body!);
            } else {
              hideLoading();
              Get.back();
              SnackbarHelper().snackbarWarning(body!["message"]);
            }
          } else {
            hideLoading();
            Get.back();
            SnackbarHelper().snackbarError(body!["message"]);
          }
        } catch (error) {
          if (error is BadRequestException) {
            hideLoading();
            Get.back();
            var apiError = json.decode(error.message!);
            DialogHelper.showErrorDialog(description: apiError["message"]);
          } else {
            handleError(error);
          }
        }
      },
    );
  }
}
