import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/models/user.dart';
import 'package:siapjulka/services/service.dart';

class DeviceService extends GetxController {
  String identifier = '';
  RxBool loading = false.obs;
  RxList<User> dataUser = <User>[].obs;
  RxString titleGame = ''.obs;
  final List<IconData> iconData = <IconData>[Icons.call, Icons.school];
  final Random r = Random();
  Icon randomIcon2() => Icon(iconData[r.nextInt(iconData.length)]);
  Map<String, dynamic>? body;

  RxInt id = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // storeImei();
  }

//   void storeImei() async {
//     Request request = Request(url: 'edit_data_game.php', body: {
//       'imei': identifier,
//     });
//     request.post().then((value) {
//       body = jsonDecode(value.body);
//       if (value.statusCode == 200) {
//         if (body!['message'] == 'Success') {
//           print('success');
//           readGame();

//           Get.back();
//         }
//       } else {
//         print('Backend error');
//       }
//     }).catchError((onError) {
//       printError();
//     });
//   }

//   // post data perangkat ke dalam sistem
//   void postDeviceID() async {
//     try {
//       const String url = "http://192.168.100.162:8000/api";
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       int? id = preferences.getInt("login");
//       final response = await http.post(
//         Uri.parse('$url/send_deviceid/$id'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           'imei': identifier,
//         }),
//       );
//       final body = jsonDecode(response.body);
//       HelperController().snackbarSuccess("${body['message']}");
//     } catch (e) {
//       HelperController().snackbarError("Maaf Terjadi kesalahan");
//     }
//   }
}
