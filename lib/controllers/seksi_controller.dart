import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/controllers/base_controller.dart';
import 'package:siapjulka/helper/app_exceptions.dart';
import 'package:siapjulka/helper/dialog_helper.dart';
import 'package:siapjulka/helper/snakcbar_helper.dart';
import 'package:siapjulka/models/seksi/seksi_list.dart';
import 'package:siapjulka/network/domain.dart';

class SeksiController extends GetxController with BaseController {
  var dataSeksi = <Seksi>[].obs;
  Map<String, dynamic>? body;

  @override
  void onInit() {
    super.onInit();
    get();
  }

  void get() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id = preferences.getInt('login');
    Domain response = Domain(url: '/participant/$id');

    await response.get().then((value) {
      if (value.statusCode == 200) {
        List jsonResponse = jsonDecode(value.body);
        dataSeksi.value = jsonResponse.map((e) => Seksi.fromJson(e)).toList();
      } else {
        SnackbarHelper().snackbarWarning('Maaf, anda belum memiliki kelas');
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
