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

  void snackbarWarning(String message) {
    Get.snackbar(
      "Maaf",
      message,
      barBlur: 2.0,
      backgroundColor: Pallete.lightWarningColor[50],
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      icon: const Icon(
        Icons.info_outline_rounded,
        color: Colors.white,
      ),
    );
  }

  void snackbarAbsensiWarning(String message) {
    Get.snackbar("Maaf", message,
        barBlur: 2.0,
        backgroundColor: Pallete.lightWarningColor[50],
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        icon: const Icon(
          Icons.info_outline_rounded,
          color: Colors.white,
        ),
        duration: const Duration(seconds: 10));
  }

  void snackbarAbsensiSuccess(String message) {
    Get.snackbar("Sukses", message,
        barBlur: 2.0,
        backgroundColor: Pallete.lightSuccessColor[100],
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        icon: const Icon(
          Icons.verified_outlined,
          color: Colors.white,
        ),
        duration: const Duration(seconds: 10));
  }
}
