import 'package:flutter/material.dart';
import 'package:siapjulka/controllers/pertemuan_controller.dart';
import 'package:siapjulka/controllers/seksi_controller.dart';
import 'package:siapjulka/models/user.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:siapjulka/pages/laporan/laporan_widget.dart';
import 'package:siapjulka/services/user_service.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({Key? key}) : super(key: key);

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  late Future<User> futureUser;
  String identifier = '';
  bool visibility = false;

  final SeksiController seksiController = Get.put(SeksiController());
  final PertemuanController pertemuanController =
      Get.put(PertemuanController());

  @override
  void initState() {
    super.initState();
  }

  Widget gridView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: Obx(
            () => StaggeredGridView.countBuilder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
              crossAxisCount: 2,
              itemCount: seksiController.dataSeksi.length,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              itemBuilder: (context, index) {
                return LaporanWidget(seksiController.dataSeksi[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pullRefresh() async {
    seksiController.get();
    futureUser = UserService().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: ListView(children: [
        // buttonGetData(),
        // buttonPostData(),
        gridView(),
      ]),
    );
  }
}
