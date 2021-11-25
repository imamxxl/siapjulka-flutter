import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/pertemuan_controller.dart';
import 'package:siapjulka/models/pertemuan.dart';

class PertemuanWidget extends StatelessWidget {
  PertemuanWidget(this.pertemuan, {Key? key}) : super(key: key);
  final Pertemuan pertemuan;

  final PertemuanController pertemuanController =
      Get.put(PertemuanController());

  // Future<void> _onAbsensi(int idSeksi) async {
  //   pertemuan.idAbsensi = idSeksi;
  //   // pertemuanController.to();
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Material(
        child: InkWell(
          splashColor: Colors.grey[300],
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pertemuan ke-',
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Pallete.primaryColor),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  (() {
                    if (pertemuan.materi == null) {
                      return "Materi kuliah belum dibuat";
                    }
                    return pertemuan.materi!;
                  })(),
                  maxLines: 3,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Kehadiran:',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (pertemuan.keterangan == null) ...[
                      Icon(
                        Icons.circle,
                        color: Pallete.dangerColor,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Expanded(
                        child: Text(
                          'Alfa',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ] else if (pertemuan.keterangan == 'hadir') ...[
                      Icon(
                        Icons.circle,
                        color: Pallete.successColor,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Expanded(
                        child: Text(
                          'Hadir',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ] else ...[
                      Icon(
                        Icons.circle,
                        color: Pallete.warningColor,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Expanded(
                        child: Text(
                          'Izin',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ],
                ),
                // Row(
                //   children: [
                //     Icon(
                //       Icons.circle,
                //       color: Pallete.successColor,
                //       size: 16,
                //     ),
                //     const SizedBox(
                //       width: 5,
                //     ),
                //     Expanded(
                //       child: Text((() {
                //         if (pertemuan.keterangan == null) {
                //           return "Alfa";
                //         } else if (pertemuan.keterangan == 'hadir') {
                //           return "Hadir";
                //         }
                //         return pertemuan.keterangan!;
                //       })()),
                //     )
                //   ],
                // ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
