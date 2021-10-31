import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:http/http.dart' as http;
import 'package:siapjulka/pages/home_page.dart';

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
        color: Pallete.blueElectronica,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Pallete.blueElectronica[50],
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
      var response = await http.post(
          Uri.parse("http://192.168.100.162:8000/api/login"),
          body: ({
            "username": usernameController.text,
            "password": passwordController.text
          }));

      try {
        if (response.statusCode == 200) {
          setState(() {
            setState(() {
              if (_state == 0) {
                animateButton();
              }
            });
          });
          final body = jsonDecode(response.body);

          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setInt("id", body['id']);

          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text("Berhasil Login, ID: ${body['id']}"),
          //   backgroundColor: Colors.green[500],
          //   duration: const Duration(milliseconds: 2000),
          // ));

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          final body = jsonDecode(response.body);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${body['message']}"),
            backgroundColor: Colors.red[500],
            duration: const Duration(milliseconds: 2000),
          ));
        }
      } catch (e) {
        // Exception(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Gagal menghubungkan"),
          backgroundColor: Colors.red[500],
          duration: const Duration(milliseconds: 2000),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Username dan Password harus diisi"),
        backgroundColor: Colors.red[500],
        duration: const Duration(milliseconds: 2000),
      ));
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

    Timer(Duration(milliseconds: 1500), () {
      setState(() {
        _state = 2;
      });
    });
  }

  // void pageRoute(String id) async {
  //   // Here share value user ID with shared preference
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   await preferences.setString("User", id);

  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => const HomePage()));
  // }
}
