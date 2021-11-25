import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/pertemuan_controller.dart';
import 'package:siapjulka/controllers/seksi_controller.dart';
import 'package:siapjulka/pages/pertemuan/pertemuan_widget.dart';

class PertemuanPage extends StatefulWidget {
  const PertemuanPage({Key? key}) : super(key: key);

  @override
  _PertemuanPageState createState() => _PertemuanPageState();
}

class _PertemuanPageState extends State<PertemuanPage> {
  final PertemuanController pertemuanController =
      Get.put(PertemuanController());
  final SeksiController seksiController = Get.put(SeksiController());

  Widget gridView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: Obx(
            () => StaggeredGridView.countBuilder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
              crossAxisCount: 2,
              itemCount: pertemuanController.listPertemuan.length,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              itemBuilder: (context, index) {
                return PertemuanWidget(
                  pertemuanController.listPertemuan[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pullRefresh() async {
    // pertemuanController.selectSeksi(idSeksi!);
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Seksis')),
    //   body: ListView(
    //     children: [gridView()],
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(title: const Text('Pertemuan')),
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pertemuan ' + index.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Pallete.primaryColor),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            (e.materi == null)
                                                ? '"Materi belum dibuat"'
                                                : e.materi.toString(),
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Kehadiran:',
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: (e.keterangan == null
                                                    ? Pallete.successColor
                                                    : Pallete.dangerColor),
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
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {}
                                              // => _onEdit(int.tryParse(e.id)),
                                              ,
                                              child: Icon(
                                                Icons.qr_code_scanner,
                                                color: Pallete.successColor,
                                                size: 30,
                                              )),
                                          const SizedBox(width: 10),
                                          GestureDetector(
                                              onTap: () {}
                                              // => _showMyDialog(context, int.tryParse(e.id))
                                              ,
                                              child: Icon(
                                                  Icons.note_add_outlined,
                                                  size: 30,
                                                  color: Pallete.warningColor)),
                                        ],
                                      ),
                                    ),
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
                        // Get.to(() => AddGamePage());
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
