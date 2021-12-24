import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/controllers/base_controller.dart';
import 'package:get/get.dart';
import 'package:siapjulka/helper/app_exceptions.dart';
import 'package:siapjulka/helper/dialog_helper.dart';
import 'package:siapjulka/helper/snakcbar_helper.dart';
import 'package:siapjulka/models/hari/list_hari.dart';
import 'package:siapjulka/network/domain.dart';
import 'package:siapjulka/pages/hari/hari_list_page.dart';
import 'package:siapjulka/pages/hari/hari_null_page.dart';

class DashboardController extends GetxController with BaseController {
  RxString kodeHari = ''.obs;
  RxList<ListHari> listHari = <ListHari>[].obs;
  Map<String, dynamic>? body;

  void toHariPage() async {
    selectHari(kodeHari.value);
  }

  void selectHari(String kodeHari) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id = preferences.getInt('login');

    Domain response = Domain(url: '/hari/$id', body: {
      'hari': kodeHari,
    });

    await response.post().then((value) {
      body = jsonDecode(value.body);

      if (value.statusCode == 200) {
        if (body!['status'] == 'Success') {
          var list = body!['data'] as List;
          listHari.value = list.map((i) => ListHari.fromJson(i)).toList();

          Get.to(
            () => const HariListPage(),
          );
        } else {
          Get.to(
            () => const HariNullPage(),
          );
          // SnackbarHelper()
          //     .snackbarWarning(body!["message"] + ' ' + kodeHari.toLowerCase());
        }
      } else {
        SnackbarHelper()
            .snackbarError(body!["message"] + ' ' + kodeHari.toLowerCase);
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
