import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/pertemuan_controller.dart';
import 'package:siapjulka/controllers/seksi_controller.dart';
import 'package:siapjulka/routes/name_route.dart';

class PertemuanPage extends StatefulWidget {
  const PertemuanPage({Key? key}) : super(key: key);

  @override
  _PertemuanPageState createState() => _PertemuanPageState();
}

class _PertemuanPageState extends State<PertemuanPage> {
  final PertemuanController pertemuanController =
      Get.put(PertemuanController());
  final SeksiController seksiController = Get.put(SeksiController());

  Future<void> _pullRefresh() async {
    pertemuanController.selectSeksi(pertemuanController.idSeksi.toInt());
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
                                                onTap: () {},
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
