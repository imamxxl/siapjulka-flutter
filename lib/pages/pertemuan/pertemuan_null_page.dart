import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/pertemuan_controller.dart';

class PertemuanNullPage extends StatefulWidget {
  const PertemuanNullPage({Key? key}) : super(key: key);

  @override
  _PertemuanNullPageState createState() => _PertemuanNullPageState();
}

class _PertemuanNullPageState extends State<PertemuanNullPage> {
  final PertemuanController pertemuanController =
      Get.put(PertemuanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('${pertemuanController.namaMK}')),
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
                'Data pertemuan tidak ditemukan',
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
