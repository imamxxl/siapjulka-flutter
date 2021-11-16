import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/helper/helper_controller.dart';
import 'package:siapjulka/models/user.dart';
import 'package:siapjulka/routes/name_route.dart';
import 'package:siapjulka/services/user_service.dart';
import 'package:get/get.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<User> futureUser;
  String identifier = '';
  bool visibility = false;

  @override
  void initState() {
    super.initState();
    getDeviceID();
    futureUser = UserService().getUser();
  }

  Widget welcomeUsers() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Hai,',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      snapshot.data!.namaMahasiswa.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Pallete.primaryColor,
                      ),
                    )
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }

  Widget deviceID(bool visibility) {
    return Visibility(
      visible: visibility,
      child: Card(
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Oops...',
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Pallete.warningColor,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Kayaknya perangkat kamu belum terdaftar deh. Yuk daftarin dulu, supaya bisa isi kehadiran.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Pallete.warningColor,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Pallete.warningColor[200],
                          onTap: () {
                            Get.defaultDialog(
                              barrierDismissible: true,
                              titlePadding: const EdgeInsets.all(5),
                              radius: 10,
                              buttonColor: Pallete.warningColor,
                              title: 'Daftarkan Perangkat',
                              titleStyle:
                                  TextStyle(color: Pallete.warningColor),
                              middleText:
                                  'Satu perangkat untuk satu akun. Setelah perangkat ini didaftarkan, pengisian kehadiran tidak dapat dilakukan di perangkat lain.',
                              textConfirm: 'Daftar',
                              textCancel: 'Batal',
                              cancelTextColor: Pallete.warningColor,
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                postDeviceID();
                                Get.offAllNamed(NameRoute.home);
                              },
                            );
                          },
                          child: const Center(
                            child: Text(
                              "Iya, Daftar",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/stickers/man_look.png",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkDeviceID(bool visibility) {
    return FutureBuilder<User>(
      future: futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          snapshot.data!.deviceId == null
              ? deviceID(visibility = true)
              : deviceID(visibility = false);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return deviceID(visibility);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      checkDeviceID(visibility),
      welcomeUsers(),
    ]);
  }

  Future<void> getDeviceID() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          identifier = build.androidId;
        });
        // UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        setState(() {
          identifier = data.identifierForVendor;
        }); // UUID for iOS
      }
    } on PlatformException {
      HelperController().snackbarError("ID Perangkat tidak ditemukan");
    }
  }

  // post data perangkat ke dalam sistem
  Future<void> postDeviceID() async {
    try {
      const String url = "http://192.168.100.162:8000/api";
      SharedPreferences preferences = await SharedPreferences.getInstance();
      int? id = preferences.getInt("login");
      final response = await http.post(
        Uri.parse('$url/send_deviceid/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'imei': identifier,
        }),
      );
      final body = jsonDecode(response.body);
      HelperController().snackbarSuccess("${body['message']}");
    } catch (e) {
      HelperController().snackbarError("Maaf Terjadi kesalahan");
    }
  }
}
