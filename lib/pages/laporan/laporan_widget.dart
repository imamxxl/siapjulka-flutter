import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/laporan_controller.dart';
import 'package:siapjulka/models/seksi/seksi_list.dart';
import 'package:siapjulka/controllers/seksi_controller.dart';

class LaporanWidget extends StatelessWidget {
  LaporanWidget(this.seksi, {Key? key}) : super(key: key);
  final Seksi seksi;

  final SeksiController seksiController = Get.put(SeksiController());
  final LaporanController laporanController = Get.put(LaporanController());

  Future<void> _onDetail(int idSeksi) async {
    laporanController.idSeksi.value = idSeksi;
    laporanController.toDetailPage();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Material(
        child: InkWell(
          splashColor: Colors.grey[300],
          onTap: () => _onDetail(int.parse('${seksi.idSeksi}')),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  seksi.kodeSeksi!,
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  seksi.namaMk!,
                  maxLines: 3,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Pallete.primaryColor),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.account_box_sharp,
                      color: Colors.black54,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        seksi.namaDosen!,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_filled,
                      color: Colors.black54,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        seksi.hari! +
                            ' (' +
                            seksi.jadwalMulai! +
                            '-' +
                            seksi.jadwalSelesai! +
                            ')',
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.article,
                      color: Colors.black54,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        seksi.sks! + ' SKS',
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.black54,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        seksi.kodeRuang!,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
