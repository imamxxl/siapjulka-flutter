import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/scanner_controller.dart';
import 'package:siapjulka/helper/snakcbar_helper.dart';
import 'package:siapjulka/pages/scanner_home/scanner_hasil.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  bool flashOn = false;
  bool frontCam = false;

  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? qrcode;

  var textQrController = TextEditingController();
  String identifier = '';
  int? userlogin;

  final ScannerController scannerController = Get.put(ScannerController());

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getDeviceID();
    userLogin();
    super.initState();
  }

  void _isiAbsensi() {
    scannerController.post();
  }

  Widget formData() {
    return Visibility(
      visible: false,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.only(top: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: scannerController.idController
                  ..text = userlogin.toString(),
                decoration: const InputDecoration(
                  hintText: 'Id User',
                ),
              ),
              TextField(
                controller: scannerController.qrcodeController
                  ..text = qrcode != null ? '${qrcode!.code}' : '',
                decoration: const InputDecoration(hintText: 'QR Code'),
              ),
              TextField(
                controller: scannerController.deviceController
                  ..text = identifier,
                decoration: const InputDecoration(hintText: 'Device Id'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Pallete.primaryColor,
                ),
                onPressed: () => _isiAbsensi(),
                child: const Text('Kirim'),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    formData();
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: onQRViewCreated,
            overlay: QrScannerOverlayShape(
                borderWidth: 8.0, borderColor: Pallete.primaryColor),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                'Scan QR Code',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  color: Colors.white,
                  icon: Icon(
                    (flashOn ? Icons.flash_on : Icons.flash_off),
                  ),
                  onPressed: () {
                    setState(() {
                      flashOn = !flashOn;
                    });
                    controller!.toggleFlash();
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(
                    (frontCam ? Icons.camera_front : Icons.camera_rear),
                  ),
                  onPressed: () {
                    setState(() {
                      frontCam = !frontCam;
                    });
                    controller!.flipCamera();
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // get Device ID login for validation
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

  // created controller default from QRViewController
  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen((qrcode) {
      setState(() => this.qrcode = qrcode);
      if (mounted) {
        controller.dispose();
        Get.to(const ScannerHasilPage());
      }
    });
  }

  // check QR Code result from the scanning
  buildResult() => Text(
        qrcode != null ? '${qrcode!.code}' : 'QR Code belum ada',
        maxLines: 3,
        style: const TextStyle(color: Colors.white),
      );

  // check id user login from user
  void userLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userlogin = preferences.getInt("login");
    });
  }
}
