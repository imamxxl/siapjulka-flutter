import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/pertemuan_controller.dart';
import 'package:siapjulka/controllers/search_controller.dart';
import 'package:siapjulka/controllers/user_controller.dart';
import 'package:siapjulka/controllers/seksi_controller.dart';
import 'package:siapjulka/controllers/test_controller.dart';
import 'package:siapjulka/helper/snakcbar_helper.dart';
import 'package:siapjulka/models/user.dart';
import 'package:siapjulka/network/domain.dart';
import 'package:siapjulka/pages/dashboard/seksi_widget.dart';
import 'package:get/get.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:siapjulka/services/user_service.dart';
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

  final SeksiController seksiController = Get.put(SeksiController());
  final UserController userController = Get.put(UserController());
  final PertemuanController pertemuanController =
      Get.put(PertemuanController());
  final SearchController searchController = Get.put(SearchController());

  @override
  void initState() {
    super.initState();
    getDeviceID();
    futureUser = UserService().getUser();
  }

  void _cariKelas() {
    // searchController.post();
  }

  Widget welcomeUsers() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
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
              Obx(() => Text(
                    '${userController.dataUser.value.nama}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Pallete.primaryColor,
                    ),
                  ))
            ],
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
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
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
                      width: 150,
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
                                // Get.offAllNamed(NameRoute.home);
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
          snapshot.data!.imei == null
              ? deviceID(visibility = true)
              : deviceID(visibility = false);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return deviceID(visibility);
      },
    );
  }

  Widget buttonGetData() {
    // final pcontroller = PertemuanController();
    final controller = TestController();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Pallete.successColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Pallete.successColor[200],
            onTap: () async {
              controller.getData();
            },
            child: const Center(
              child: Text(
                "Get Data",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonPostData() {
    final controller = TestController();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Pallete.successColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Pallete.successColor[200],
            onTap: () async {
              controller.postData();
            },
            child: const Center(
              child: Text(
                "Post Data",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        // controller: se,
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: const Color(0xfff3f3f4),
          hintText: "Cari kelas...",
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  Widget gridView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: Obx(
            () => StaggeredGridView.countBuilder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
              crossAxisCount: 2,
              itemCount: seksiController.dataSeksi.length,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              itemBuilder: (context, index) {
                return SeksiWidget(seksiController.dataSeksi[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pullRefresh() async {
    seksiController.get();
    userController.get();
    futureUser = UserService().getUser();
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
      SnackbarHelper().snackbarError("ID Perangkat tidak ditemukan");
    }
  }

  // post data perangkat ke dalam sistem
  Future<void> postDeviceID() async {
    try {
      String url = Domain().baseUrl;
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

      if (response.statusCode == 200) {
        SnackbarHelper().snackbarSuccess("${body['message']}");
      } else {
        // hideLoading();
        SnackbarHelper().snackbarError('${body!['message']}');
        // SnackbarHelper()
        //     .snackbarWarning('Terjadi kesalahan. Ulangi lagi nanti');
      }
      // final body = jsonDecode(response.body);
      // SnackbarHelper().snackbarSuccess("${body['message']}");
    } catch (e) {
      SnackbarHelper().snackbarError("Terjadi kesalahan. Ulangi lagi nanti");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: ListView(children: [
        checkDeviceID(visibility),
        welcomeUsers(),
        searchBar(),
        // buttonGetData(),
        // buttonPostData(),
        gridView(),
      ]),
    );
  }
}
