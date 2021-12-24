import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/controllers/base_controller.dart';
import 'package:siapjulka/helper/app_exceptions.dart';
import 'package:siapjulka/helper/dialog_helper.dart';
import 'package:siapjulka/helper/snakcbar_helper.dart';
import 'package:siapjulka/models/search/search_model.dart';
import 'package:siapjulka/network/domain.dart';
import 'package:siapjulka/pages/search_seksi/search_null_page.dart';
import 'package:siapjulka/pages/search_seksi/search_page.dart';

class SearchController extends GetxController with BaseController {
  RxList<Search> listSearch = <Search>[].obs;
  Map<String, dynamic>? body;

  TextEditingController clueController = TextEditingController();

  void search() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id = preferences.getInt('login');

    Domain response = Domain(url: '/clue/$id', body: {
      'clue': clueController.text,
    });

    if (clueController.text != '') {
      await response.post().then(
        (value) {
          body = jsonDecode(value.body);
          try {
            if (body!['status'] == 'Success') {
              var list = body!['data'] as List;
              listSearch.value = list.map((i) => Search.fromJson(i)).toList();
              Get.to(
                () => const SearchPage(),
              );
            } else {
              Get.to(
                () => const SearchNullPage(),
              );
              // SnackbarHelper()
              //     .snackbarWarning(body!["message"] + ' ' + kodeHari.toLowerCase());
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
    } else {
      SnackbarHelper().snackbarWarning('Silahkan isi kolom "Cari Kelas"');
    }
  }
}
