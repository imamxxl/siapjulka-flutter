import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/token_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TokenController tokenController = Get.put(TokenController());

  Widget searchBar() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        width: 200,
        height: 200,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/stickers/search_look.png",
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(8),
        child: TextFormField(
          textInputAction: TextInputAction.search,
          controller: tokenController.tokenController,
          style: const TextStyle(fontSize: 18),
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: const Color(0xfff3f3f4),
            hintText: "Cari Kelas/Token",
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                tokenController.toHasilSearchPage();
              },
            ),
          ),
        ),
      ),
    ]);
  }

  Widget coution() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Pallete.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'Catatan',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 16),
              ),
              SizedBox(
                width: 5.0,
              ),
              Icon(
                Icons.info,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '1. ',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: Text(
                  'Minta token kepada dosen matakuliah terkait.',
                  maxLines: 4,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '2. ',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: Text(
                  'Inputkan token ke dalam kolom "Cari Kelas/Token".',
                  maxLines: 4,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '3. ',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: Text(
                  'Tunggu dan konfirmasikan kepada dosen pengajar agar anda diverifikasi di kelasnya.',
                  maxLines: 4,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '4. ',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: Text(
                  'PERINGATAN: \n Jika anda TIDAK terverifikasi di kelas tertentu, anda tidak akan dapat mengambil absensi',
                  maxLines: 4,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pullRefresh() async {}

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: ListView(children: [searchBar(), coution()]),
    );
  }
}
