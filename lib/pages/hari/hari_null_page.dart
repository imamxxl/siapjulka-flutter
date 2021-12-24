import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/dashboard_controller.dart';

class HariNullPage extends StatefulWidget {
  const HariNullPage({Key? key}) : super(key: key);

  @override
  _HariNullPageState createState() => _HariNullPageState();
}

class _HariNullPageState extends State<HariNullPage> {
  final DashboardController dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Jadwal ${dashboardController.kodeHari}')),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.width / 2,
          width: MediaQuery.of(context).size.height / 2,
          child: Column(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 5 / 3,
                  child: Image.asset(
                    "assets/stickers/not_found.png",
                  ),
                ),
              ),
              Text(
                'Tidak ada kelas anda untuk hari ${dashboardController.kodeHari}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Pallete.dangerColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
