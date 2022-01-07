import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/scanner_controller.dart';

class ScannerHasilPage extends StatefulWidget {
  const ScannerHasilPage({Key? key}) : super(key: key);

  @override
  _ScannerHasilPageState createState() => _ScannerHasilPageState();
}

class _ScannerHasilPageState extends State<ScannerHasilPage> {
  final ScannerController scannerController = Get.put(ScannerController());

  @override
  void initState() {
    _isiAbsensi();
    super.initState();
  }

  void _isiAbsensi() {
    scannerController.post();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Absensi'),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.width / 2,
          width: MediaQuery.of(context).size.height / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 5 / 3,
                  child: Image.asset(
                    "assets/stickers/result.png",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Lihat hasil absensi dari pop up di bawah',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Pallete.warningColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
