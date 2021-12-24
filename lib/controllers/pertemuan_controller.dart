import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/controllers/base_controller.dart';
import 'package:siapjulka/helper/app_exceptions.dart';
import 'package:siapjulka/helper/dialog_helper.dart';
import 'package:siapjulka/helper/snakcbar_helper.dart';
import 'package:siapjulka/models/pertemuan.dart';
import 'package:siapjulka/network/domain.dart';
import 'package:siapjulka/pages/pertemuan/pertemuan_null_page.dart';
import 'package:siapjulka/pages/pertemuan/pertemuan_page.dart';
import 'package:http/http.dart' as http;

class PertemuanController extends GetxController with BaseController {
  RxInt idSeksi = 0.obs;
  RxString namaMK = ''.obs;
  dynamic body;
  var listPertemuan = <Pertemuan>[].obs;

  TextEditingController idAbsensiController = TextEditingController();
  TextEditingController deviceController = TextEditingController();

  File? file;

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
        Get.to(
          () => const PertemuanNullPage(),
        );
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

  void pickfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      file = File(result.files.single.path!);
    } else {}
  }

// reset file yang telah dipilih
  void resetPickFile() async {
    file == null;
  }

  void uploadPDF() async {
    showLoading();
    if (file != null) {
      var url = Uri.parse(Domain().baseUrl + '/izin');

      var request = http.MultipartRequest("POST", url);
      request.fields['id_absensi'] = idAbsensiController.text;
      request.fields['device_id'] = deviceController.text;
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        file!.path,
        contentType: MediaType('application', 'x-tar'),
      ));

      request.send().then((result) async {
        http.Response.fromStream(result).then((response) {
          body = jsonDecode(response.body);
          if (response.statusCode == 200) {
            if (body!['status'] == 'Success') {
              hideLoading();
              resetPickFile();
              Get.back();
              SnackbarHelper().snackbarSuccess('${body!['message']}');
            } else {
              hideLoading();
              SnackbarHelper().snackbarWarning('${body!['message']}');
            }
          }
        });
      }).catchError((error) {
        hideLoading();
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          SnackbarHelper().snackbarError(apiError["message"]);
        } else {
          handleError(error);
        }
      });
    } else {
      hideLoading();
      SnackbarHelper()
          .snackbarWarning('Anda harus memilih file PDF untuk diupload');
    }
  }
}
