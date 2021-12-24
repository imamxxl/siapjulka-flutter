import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/token_controller.dart';
import 'package:siapjulka/helper/snakcbar_helper.dart';

class HasilSearchPage extends StatefulWidget {
  const HasilSearchPage({Key? key}) : super(key: key);

  @override
  _HasilSearchPageState createState() => _HasilSearchPageState();
}

class _HasilSearchPageState extends State<HasilSearchPage> {
  TokenController tokenController = Get.put(TokenController());

  String identifier = '';
  int? userlogin;

  @override
  void initState() {
    init();
    getDeviceID();
    userLogin();
    super.initState();
  }

  void init() async {
    tokenController.get();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // check id user login from user
  void userLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userlogin = preferences.getInt("login");
    });
  }

  // mengambil device_id
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
      SnackbarHelper().snackbarError("ID Perangkat tidak ditemukan");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Pencarian Kelas'),
      ),
      body: Obx(
        () => ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tokenController
                                        .tokenSuccess.value.data!.kodeSeksi ==
                                    null
                                ? 'Seksi'
                                : '${tokenController.tokenSuccess.value.data!.kodeSeksi}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Pallete.primaryColor),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            tokenController.tokenSuccess.value.data!.namaMk ==
                                    null
                                ? 'Matakuliah'
                                : '${tokenController.tokenSuccess.value.data!.namaMk}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.article,
                                color: Pallete.primaryColor,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                tokenController.tokenSuccess.value.data!.sks ==
                                        null
                                    ? '0 SKS'
                                    : '${tokenController.tokenSuccess.value.data!.sks}'
                                        ' SKS',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    color: Colors.black87),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.account_box_sharp,
                                color: Pallete.primaryColor,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                tokenController.tokenSuccess.value.data!
                                            .namaDosen ==
                                        null
                                    ? 'Dosen'
                                    : '${tokenController.tokenSuccess.value.data!.namaDosen}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    color: Colors.black87),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_filled,
                                color: Pallete.primaryColor,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                tokenController.tokenSuccess.value.data!.hari ==
                                        null
                                    ? 'Jadwal'
                                    : '${tokenController.tokenSuccess.value.data!.hari}'
                                        ' ('
                                        '${tokenController.tokenSuccess.value.data!.jadwalMulai}'
                                        '-'
                                        '${tokenController.tokenSuccess.value.data!.jadwalSelesai}'
                                        ')',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    color: Colors.black87),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Pallete.primaryColor,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                tokenController.tokenSuccess.value.data!
                                            .kodeRuang ==
                                        null
                                    ? 'Ruangan'
                                    : '${tokenController.tokenSuccess.value.data!.kodeRuang}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    color: Colors.black87),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(Container(
                          height: 140,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          color: Pallete.primaryColor,
                          child: Center(
                            child: Column(
                              children: [
                                // for id_seksi
                                Visibility(
                                  visible: false,
                                  child: TextField(
                                    controller: tokenController.seksiController
                                      ..text = tokenController.tokenSuccess
                                                  .value.data!.id ==
                                              null
                                          ? 'Id seksi'
                                          : '${tokenController.tokenSuccess.value.data!.id}',
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                // for user_id
                                Visibility(
                                  visible: false,
                                  child: TextField(
                                    controller: tokenController.userContnroller
                                      ..text = userlogin.toString(),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: TextField(
                                    controller: tokenController.deviceController
                                      ..text = identifier,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Anda yakin ingin bergabung di dalam kelas matakuliah ${tokenController.tokenSuccess.value.data!.namaMk}?',
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        color: Colors.transparent,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          splashColor: Colors.grey,
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: const Center(
                                            child: Text(
                                              "Batal",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          splashColor: Colors.grey,
                                          onTap: () {
                                            tokenController.post();
                                          },
                                          child: Center(
                                            child: Text(
                                              "Masuk",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Pallete.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_box_outlined,
                            color: Pallete.successColor,
                            size: 32,
                          ),
                          const Text('Join kelas', maxLines: 2)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
