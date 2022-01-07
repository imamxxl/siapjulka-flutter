import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/laporan_controller.dart';

class LaporanDetailPage extends StatelessWidget {
  LaporanDetailPage({Key? key}) : super(key: key);

  final LaporanController laporanController = Get.put(LaporanController());
  Future<void> _pullRefresh() async {
    laporanController.get(laporanController.idSeksi.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
            title: Text(
                '${laporanController.laporanSuccess.value.seksi!.namaMk}')),
        body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: ListView(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Laporan Absensi',
                        maxLines: 3,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Matakuliah ${laporanController.laporanSuccess.value.seksi!.namaMk} - ${laporanController.laporanSuccess.value.seksi!.sks} SKS',
                        maxLines: 3,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Table(
                        border:
                            TableBorder.all(color: Colors.black54, width: 1.5),
                        children: [
                          TableRow(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                child: const Center(
                                  child: Text(
                                    'Nama',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                child: const Center(
                                  child: Text(
                                    'NIM',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                color: Pallete.successColor,
                                child: const Center(
                                  child: Text(
                                    'HADIR',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                color: Pallete.warningColor,
                                child: const Center(
                                  child: Text(
                                    'IZIN',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                color: Pallete.dangerColor,
                                child: const Center(
                                  child: Text(
                                    'ALPA',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              child: Center(
                                child: Text(
                                  '${laporanController.laporanSuccess.value.nama}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              child: Center(
                                child: Text(
                                  '${laporanController.laporanSuccess.value.nim}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              child: Center(
                                child: Text(
                                  '${laporanController.laporanSuccess.value.hadir}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              child: Center(
                                child: Text(
                                  '${laporanController.laporanSuccess.value.izin}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              child: Center(
                                child: Text(
                                  '${laporanController.laporanSuccess.value.alpa}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ]),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Pallete.primaryColor,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Total pertemuan: ${laporanController.laporanSuccess.value.pertemuan}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black54),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Pallete.warningColor,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Absensi yang belum diverifikasi oleh dosen: ${laporanController.laporanSuccess.value.absensiBelumDiverifikasi}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black54),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
