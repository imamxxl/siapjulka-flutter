import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:http/http.dart' as http;
import 'package:siapjulka/routes/name_route.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  int _state = 0;

  @override
  void initState() {
    super.initState();
    _checkInfoLogin();
  }

  Widget _logoIcon() {
    return const Image(
      image: AssetImage('assets/images/elektronika_icon.png'),
      height: 120,
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'Sistem Absensi',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
          children: [
            TextSpan(
              text: ' Perkuliahan',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            TextSpan(
              text: ' Jurusan Elektronika',
              style: TextStyle(color: Color(0xff3E8DBA), fontSize: 20),
            ),
          ]),
    );
  }

  Widget _entryFieldUsername(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: usernameController,
            style: const TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
              hintText: "User",
              suffixIcon: Icon(Icons.account_box),
            ),
          )
        ],
      ),
    );
  }

  Widget _entryFieldPassword(String title, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: passwordController,
        obscureText: isPassword,
        style: const TextStyle(fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Color(0xfff3f3f4),
          hintText: "Password",
          suffixIcon: Icon(Icons.lock),
        ),
      ),
    );
  }

  Widget _usernamePasswordWidget() {
    return Column(
      children: <Widget>[
        _entryFieldUsername("Username"),
        _entryFieldPassword("Password", isPassword: true),
      ],
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Pallete.primaryColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Pallete.primaryColor[200],
          onTap: () {
            _checkLogin();
          },
          child: setUpButtonChild(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: height * .19),
              _logoIcon(),
              const SizedBox(height: 30),
              _title(),
              const SizedBox(height: 30),
              _usernamePasswordWidget(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.centerRight,
                child: const Text('Lupa Password?',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 10),
              _submitButton(),
              SizedBox(height: height * .055),
            ],
          ),
        ),
      ),
    );
  }

  void _checkLogin() async {
    if (passwordController.text.isNotEmpty &&
        usernameController.text.isNotEmpty) {
      // // here ip for teathering smartphones
      // var response = await http.post(
      //     Uri.parse("http://192.168.43.6:8000/api/login"),
      //     body: ({
      //       "username": usernameController.text,
      //       "password": passwordController.text
      //     }));

      // // here ip for wifi
      var response = await http.post(
          Uri.parse("http://192.168.100.162:8000/api/login"),
          body: ({
            "username": usernameController.text,
            "password": passwordController.text
          }));

      try {
        if (response.statusCode == 200) {
          setState(() {
            if (_state == 0) {
              animateButton();
            }
          });
          final body = jsonDecode(response.body);
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setInt("login", body["id"]);
          Get.offAllNamed(NameRoute.home);
        } else {
          final body = jsonDecode(response.body);
          Get.snackbar(
            "Gagal",
            "${body['message']}",
            barBlur: 2.0,
            backgroundColor: Pallete.dangerColor,
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            icon: const Icon(
              Icons.not_interested,
              color: Colors.white,
            ),
          );
        }
      } catch (e) {
        Get.snackbar(
          "Gagal!",
          "Tidak dapat Menghubungkan']}",
          barBlur: 2.0,
          backgroundColor: Pallete.dangerColor,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          icon: const Icon(
            Icons.not_interested,
            color: Colors.white,
          ),
        );
      }
    } else {
      Get.snackbar(
        "Gagal!",
        "Username dan Password harus diisi']}",
        barBlur: 2.0,
        backgroundColor: Pallete.dangerColor,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        icon: const Icon(
          Icons.not_interested,
          color: Colors.white,
        ),
      );
    }
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return const Center(
        child: Text(
          "Sign In",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      );
    } else if (_state == 1) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return const Icon(
        Icons.check,
        color: Colors.white,
        size: 40,
      );
    }
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        _state = 2;
      });
    });
  }

  void _checkInfoLogin() async {
    // Here we check if user already login or id already available or not
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? val = preferences.getInt("login");
    if (val != null) {
      Get.offNamed(NameRoute.home);
    }
  }
}
