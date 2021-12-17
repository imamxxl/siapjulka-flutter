import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/pertemuan_controller.dart';
import 'package:siapjulka/controllers/seksi_controller.dart';
import 'package:siapjulka/helper/snakcbar_helper.dart';
import 'package:siapjulka/routes/name_route.dart';

class PertemuanPage extends StatefulWidget {
  const PertemuanPage({Key? key}) : super(key: key);

  @override
  _PertemuanPageState createState() => _PertemuanPageState();
}

class _PertemuanPageState extends State<PertemuanPage> {
  String identifier = '';

  final PertemuanController pertemuanController =
      Get.put(PertemuanController());

  final SeksiController seksiController = Get.put(SeksiController());

  Future<void> _pullRefresh() async {
    pertemuanController.selectSeksi(pertemuanController.idSeksi.toInt());
  }

  @override
  void initState() {
    super.initState();
    getDeviceID();
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
        title: const Text('Pertemuan'),
      ),
      body: SafeArea(
        child: Obx(
          () => RefreshIndicator(
            onRefresh: _pullRefresh,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: pertemuanController.listPertemuan.map((e) {
                          var index =
                              pertemuanController.listPertemuan.indexOf(e);
                          index++;
                          return Card(
                            color: (e.verifikasi == null
                                ? Colors.white
                                : Colors.white60),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pertemuan ' + index.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Pallete.primaryColor),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          e.namaMk!,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          (e.materi == null)
                                              ? '"Materi belum dibuat"'
                                              : e.materi.toString(),
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Kehadiran:',
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: (e.keterangan == null
                                                  ? Pallete.dangerColor
                                                  : (e.keterangan == 'hadir'
                                                      ? Pallete.successColor
                                                      : Pallete.warningColor)),
                                              size: 16,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              (e.keterangan == null
                                                  ? 'ALPA'
                                                  : e.keterangan
                                                      .toString()
                                                      .toUpperCase()),
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: (e.verifikasi == null
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // Button Hadir
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(
                                                      NameRoute.scanner);
                                                },
                                                // => _onEdit(int.tryParse(e.id)),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.qr_code_scanner,
                                                      color:
                                                          Pallete.successColor,
                                                      size: 30,
                                                    ),
                                                    const Text('Scan',
                                                        maxLines: 2)
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              // Button izin
                                              GestureDetector(
                                                onTap: () {
                                                  Get.bottomSheet(Container(
                                                    height: 320,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                    color: Pallete.primaryColor,
                                                    child: Center(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          // for id_seksi
                                                          Visibility(
                                                            visible: false,
                                                            child: TextField(
                                                              controller: pertemuanController
                                                                  .idAbsensiController
                                                                ..text = e.idAbsensi ==
                                                                        null
                                                                    ? 'Id absensi'
                                                                    : '${e.idAbsensi}',
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                              ),
                                                            ),
                                                          ),
                                                          Visibility(
                                                            visible: false,
                                                            child: TextField(
                                                              controller:
                                                                  pertemuanController
                                                                      .deviceController
                                                                    ..text =
                                                                        identifier,
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                              ),
                                                            ),
                                                          ),
                                                          const Text(
                                                            'Perhatian',
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          const Text(
                                                            'Saat anda memilih kehadiran "Izin", maka anda diwajibkan untuk mengunggah bukti surat keterangan sakit atau keterangan izin. \n\nAnda harus mengunggah surat keterangan berbentuk PDF (max. 2MB)',
                                                            maxLines: 10,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          Container(
                                                            width: 100,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 2,
                                                              ),
                                                              color: Colors
                                                                  .transparent,
                                                            ),
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child: InkWell(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  splashColor:
                                                                      Colors
                                                                          .grey,
                                                                  onTap: () {
                                                                    pertemuanController
                                                                        .pickfile();
                                                                  },
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .description_outlined,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Text(
                                                                          (pertemuanController.file == null
                                                                              ? 'Pilih File'
                                                                              : pertemuanController.file.toString()),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                height: 40,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 2,
                                                                  ),
                                                                  color: Colors
                                                                      .transparent,
                                                                ),
                                                                child: Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child:
                                                                      InkWell(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    splashColor:
                                                                        Colors
                                                                            .grey,
                                                                    onTap: () {
                                                                      Get.back();
                                                                    },
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Text(
                                                                        "Batal",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              Colors.white,
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
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                child: Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child:
                                                                      InkWell(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    splashColor:
                                                                        Colors
                                                                            .grey,
                                                                    onTap: () {
                                                                      pertemuanController
                                                                          .uploadPDF();
                                                                    },
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "Kirim",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              Pallete.primaryColor,
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
                                                // => _showMyDialog(context, int.tryParse(e.id)),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .document_scanner_outlined,
                                                        size: 30,
                                                        color: Pallete
                                                            .warningColor),
                                                    const Text('Izin',
                                                        maxLines: 2)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.done,
                                                color: Pallete.successColor,
                                                size: 32,
                                              ),
                                              const Text('Absensi \n selesai',
                                                  maxLines: 2)
                                            ],
                                          )),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                      backgroundColor: Pallete.primaryColor,
                      child: const Icon(Icons.qr_code_scanner),
                      onPressed: () {
                        Get.toNamed(NameRoute.scanner);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
