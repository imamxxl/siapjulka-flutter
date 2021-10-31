import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:http/http.dart' as http;
import 'package:siapjulka/models/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  final bool _isLoading = false;

  String _jsonData = "";
  String _jsonLogin = "";

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
      margin: const EdgeInsets.symmetric(vertical: 20),
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
          child: const Center(
            child: Text(
              "Sign In",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
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

  Widget _usernamePasswordWidget() {
    return Column(
      children: <Widget>[
        _entryFieldUsername("Username"),
        _entryFieldPassword("Password", isPassword: true),
      ],
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
              // _divider(),
              // _facebookButton(),
              SizedBox(height: height * .055),
              // _createAccountLabel(),
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
      final body = jsonDecode(response.body);

      try {
        if (response.statusCode == 200) {
          print("Login username " + response.toString());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Berhasil Login, ID: ${body['id']}"),
            backgroundColor: Colors.green[500],
            duration: const Duration(milliseconds: 2000),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${body['message']}"),
            backgroundColor: Colors.red[500],
            duration: const Duration(milliseconds: 2000),
          ));
        }
      } catch (e) {
        Exception(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Maaf, terjadi kesalahan."),
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
}
