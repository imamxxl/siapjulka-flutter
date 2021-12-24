import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/pertemuan_controller.dart';
import 'package:siapjulka/models/hari/list_hari.dart';

class HariWidget extends StatelessWidget {
  HariWidget(this.listHari, {Key? key}) : super(key: key);
  final ListHari listHari;

  final PertemuanController pertemuanController =
      Get.put(PertemuanController());

  Future<void> _onPertemuan(int idSeksi) async {
    pertemuanController.idSeksi.value = idSeksi;
    pertemuanController.toPertemuanPage();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Material(
        child: InkWell(
          splashColor: Colors.grey[300],
          onTap: () => _onPertemuan(int.parse('${listHari.idSeksi}')),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listHari.kodeSeksi!,
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Pallete.primaryColor),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  listHari.namaMk!,
                  maxLines: 3,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.account_box_sharp,
                      color: Pallete.primaryColor,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        listHari.namaDosen!,
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
                    Icon(
                      Icons.access_time_filled,
                      color: Pallete.primaryColor,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        listHari.hari! +
                            ' (' +
                            listHari.jadwalMulai! +
                            '-' +
                            listHari.jadwalSelesai! +
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
                    Icon(
                      Icons.article,
                      color: Pallete.primaryColor,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        listHari.sks! + ' SKS',
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
                    Icon(
                      Icons.location_on,
                      color: Pallete.primaryColor,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        listHari.kodeRuang!,
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
