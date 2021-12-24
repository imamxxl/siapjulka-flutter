import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:siapjulka/controllers/dashboard_controller.dart';
import 'package:siapjulka/pages/hari/hari_widget.dart';

class HariListPage extends StatefulWidget {
  const HariListPage({Key? key}) : super(key: key);

  @override
  _HariListPageState createState() => _HariListPageState();
}

class _HariListPageState extends State<HariListPage> {
  final DashboardController dashboardController =
      Get.put(DashboardController());

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
              itemCount: dashboardController.listHari.length,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              itemBuilder: (context, index) {
                return HariWidget(dashboardController.listHari[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pullRefresh() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text('Jadwal ${dashboardController.kodeHari}')),
        ),
        body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: SingleChildScrollView(
              child: Column(children: [
            gridView(),
          ])),
        ));
  }
}
