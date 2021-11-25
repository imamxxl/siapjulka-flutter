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

  @override
  void onInit() {
    super.onInit();
    selectSeksi(idSeksi.value);
  }

  void toPertemuanPage() async {
    selectSeksi(idSeksi.value);
    // Get.to(() => const PertemuanPage());
  }

  void selectSeksi(int idSeksi) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id = preferences.getInt("login");

    print('ini adalah id seksi ' + idSeksi.toString());
    print('ini adalah id user ' + id.toString());

    Domain response = Domain(url: '/seksi/user/$id', body: {
      'id_seksi': idSeksi.toString(),
    });

    await response.post().then((value) {
      body = jsonDecode(value.body);

      try {
        if (value.statusCode == 200) {
          List jsonResponse = jsonDecode(value.body);
          listPertemuan.value =
              jsonResponse.map((e) => Pertemuan.fromJson(e)).toList();
          print(jsonResponse);
          Get.to(() => const PertemuanPage());
        }
      } catch (error) {
        print(value.body);
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

  //   await response.post().then((value) {
  //     body = jsonDecode(value.body);
  //     if (value.statusCode == 200) {
  //       List jsonResponse = jsonDecode(value.body);
  //       listPertemuan.value =
  //           jsonResponse.map((e) => Pertemuan.fromJson(e)).toList();
  //       print(jsonResponse);
  //       Get.to(() => const PertemuanPage());
  //     } else {
  //       SnackbarHelper().snackbarError('Maaf, terjadi kesalahan');
  //       print('Backend Error');
  //     }
  //   }).catchError((error) {
  //     if (error is BadRequestException) {
  //       var apiError = json.decode(error.message!);
  //       DialogHelper.showErrorDialog(description: apiError["message"]);
  //     } else {
  //       handleError(error);
  //     }
  //   });
  // }
}
