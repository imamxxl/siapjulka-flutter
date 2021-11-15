import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siapjulka/constant/pallete_color.dart';

class UserController extends GetxController {
  void snackbarError(String message) {
    Get.snackbar(
      "Gagal",
      message,
      barBlur: 2.0,
      backgroundColor: Pallete.dangerColor,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      icon: const Icon(
        Icons.not_interested,
        color: Colors.white,
      ),
    );
  }
}
