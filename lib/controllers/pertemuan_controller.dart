import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/controllers/base_controller.dart';
import 'package:siapjulka/helper/app_exceptions.dart';
import 'package:siapjulka/helper/dialog_helper.dart';
import 'package:siapjulka/helper/snakcbar_helper.dart';
import 'package:siapjulka/models/pertemuan.dart';
import 'package:siapjulka/network/domain.dart';
import 'package:siapjulka/pages/pertemuan/pertemuan_page.dart';

class PertemuanController extends GetxController with BaseController {
  RxInt idSeksi = 0.obs;
  dynamic body;
  var listPertemuan = <Pertemuan>[].obs;

  void toPertemuanPage() async {
    selectSeksi(idSeksi.value);
  }

  void selectSeksi(int idSeksi) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id = preferences.getInt("login");

    Domain response = Domain(url: '/pertemuan/$id', body: {
      'id_seksi': idSeksi.toString(),
    });

    await response.post().then((value) {
      body = jsonDecode(value.body);

      try {
        if (value.statusCode == 200) {
          List jsonResponse = jsonDecode(value.body);
          listPertemuan.value =
              jsonResponse.map((e) => Pertemuan.fromJson(e)).toList();
          Get.to(
            () => const PertemuanPage(),
          );
        }
      } catch (error) {
        SnackbarHelper().snackbarWarning('${body['message']}');
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
