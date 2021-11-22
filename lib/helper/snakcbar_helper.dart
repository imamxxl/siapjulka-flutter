import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siapjulka/constant/pallete_color.dart';

class SnackbarHelper {
  // Snackbar
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

  void snackbarSuccess(String message) {
    Get.snackbar(
      "Sukses",
      message,
      barBlur: 2.0,
      backgroundColor: Pallete.lightSuccessColor[100],
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      icon: const Icon(
        Icons.verified_outlined,
        color: Colors.white,
      ),
    );
  }
}
