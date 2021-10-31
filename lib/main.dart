import 'package:flutter/material.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Pallete.blueElectronica),
      home: const LoginPage(),
    );
  }
}
