import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/controllers/search_controller.dart';

class SearchNullPage extends StatefulWidget {
  const SearchNullPage({Key? key}) : super(key: key);

  @override
  _SearchNullPageState createState() => _SearchNullPageState();
}

class _SearchNullPageState extends State<SearchNullPage> {
  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(searchController.clueController.text)),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.width / 2,
          width: MediaQuery.of(context).size.height / 2,
          child: Column(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 5 / 3,
                  child: Image.asset(
                    "assets/stickers/not_found.png",
                  ),
                ),
              ),
              Text(
                'Tidak ada kelas anda untuk hari "${searchController.clueController.text}"',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Pallete.dangerColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
