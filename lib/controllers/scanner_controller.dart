import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/controllers/base_controller.dart';
import 'package:siapjulka/helper/snakcbar_helper.dart';
import 'package:siapjulka/models/absensi.dart';
import 'package:siapjulka/network/domain.dart';

class ScannerController extends GetxController with BaseController {
  Map<String, dynamic>? body;
  var dataAbsensi = Absensi().obs;

  TextEditingController idController = TextEditingController();
  TextEditingController qrcodeController = TextEditingController();
  TextEditingController deviceController = TextEditingController();

  void post() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id = preferences.getInt("login");

    Domain request = Domain(url: '/absensi/', body: {
      'id_user': id.toString(),
      'qrcode': qrcodeController.text,
      'device_id': deviceController.text,
    });

    showLoading('Mengirim data...');

    request.post().then((value) {
      body = jsonDecode(value.body);
      if (value.statusCode == 200) {
        if (body!['status'] == 'Success') {
          hideLoading();
          Get.back();
          SnackbarHelper()
              .snackbarSuccess('Anda telah berhasil melakukan absensi.');
        } else {
          hideLoading();
          SnackbarHelper().snackbarWarning('${body!['message']}');
        }
      } else {
        hideLoading();
        SnackbarHelper()
            .snackbarWarning('QR Code tidak terbaca / tidak ditemukan');
      }
    }).catchError((onError) {
      hideLoading();
      printError();
    });
  }
}
