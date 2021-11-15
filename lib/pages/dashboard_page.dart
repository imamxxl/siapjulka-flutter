import 'package:flutter/material.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/models/user.dart';
import 'package:siapjulka/services/user_service.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
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

  Widget deviceID() {
    return Visibility(
      visible: true,
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
                  const SizedBox(height: 5),
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
                              confirmTextColor: Colors.white);
                        },
                        child: const Center(
                          child: Text(
                            "Iya, Daftar",
                            style: TextStyle(fontSize: 18, color: Colors.white),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      deviceID(),
      welcomeUsers(),
    ]);
  }
}
