import 'package:flutter/material.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/pages/nav_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siapjulka',
      home: const NavPage(),
      theme: ThemeData(primarySwatch: Pallete.primaryColor),
    );
  }
}
