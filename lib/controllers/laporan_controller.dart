import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/controllers/base_controller.dart';
import 'package:siapjulka/helper/app_exceptions.dart';
import 'package:siapjulka/helper/dialog_helper.dart';
import 'package:siapjulka/helper/snakcbar_helper.dart';
import 'package:siapjulka/models/laporan/laporan_success.dart';
import 'package:siapjulka/network/domain.dart';
import 'package:siapjulka/pages/laporan/laporan_detail.dart';

class LaporanController extends GetxController with BaseController {
  RxInt idSeksi = 0.obs;
  Map<String, dynamic>? body;
  var laporanSuccess = LaporanSuccess().obs;

  void toDetailPage() async {
    get(idSeksi.value);
  }

  void get(int idSeksi) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id = preferences.getInt("login");

    Domain response = Domain(url: '/detail_laporan/$id', body: {
      'id_seksi': idSeksi.toString(),
    });

    await response.post().then((value) {
      body = jsonDecode(value.body);

      try {
        if (value.statusCode == 200) {
          if (body!['status'] == 'Success') {
            laporanSuccess.value = LaporanSuccess.fromJson(body!);
            Get.to(
              () => LaporanDetailPage(),
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
    });
  }
}
