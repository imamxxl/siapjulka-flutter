import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/constant/day_item.dart';
import 'package:siapjulka/controllers/dashboard_controller.dart';
import 'package:siapjulka/controllers/pertemuan_controller.dart';
import 'package:siapjulka/controllers/search_controller.dart';
import 'package:siapjulka/controllers/user_controller.dart';
import 'package:siapjulka/controllers/seksi_controller.dart';
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
  final SearchController searchController = Get.put(SearchController());
  final PertemuanController pertemuanController =
      Get.put(PertemuanController());
  final DashboardController dashboardController =
      Get.put(DashboardController());

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
                    '${userController.dataUser.value.nama}'.toUpperCase(),
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
                      'Sepertinya perangkat kamu belum terdaftar di sistem. Silahkan daftar dulu, supaya bisa isi kehadiran.',
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
                              "Ya, Daftar",
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

  Widget hariScroll() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 8, right: 8),
            separatorBuilder: (context, _) => (const SizedBox(
              width: 8,
            )),
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => Row(
              children: [
                buildCard(items[index]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCard(DayItem item) {
    return SizedBox(
      width: 120,
      height: 200,
      child: Column(
        children: [
          Container(
            width: 120,
            height: 200,
            decoration: BoxDecoration(
              color: Color(int.parse(item.color)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                splashColor: Colors.white,
                onTap: () => _onDay(item.hari),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Image.asset(
                            item.image,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        item.hari,
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        item.pesan,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget searchBar() {
    return Container(
      margin: const EdgeInsets.only(top: 15, right: 8, left: 8),
      child: TextFormField(
        controller: searchController.clueController,
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: const Color(0xfff3f3f4),
          hintText: "Cari kelas...",
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              searchController.search();
            },
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

  Future<void> _onDay(String hari) async {
    dashboardController.kodeHari.value = hari;
    dashboardController.toHariPage();
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
        Get.back();
        SnackbarHelper().snackbarSuccess("${body['message']}");
      } else {
        SnackbarHelper().snackbarError('${body!['message']}');
      }
    } catch (e) {
      SnackbarHelper().snackbarError("Terjadi kesalahan. Ulangi lagi nanti");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: SingleChildScrollView(
          child: Column(
            children: [
              checkDeviceID(visibility),
              welcomeUsers(),
              hariScroll(),
              searchBar(),
              gridView(),
            ],
          ),
        ),
        onRefresh: _pullRefresh);
  }
}
