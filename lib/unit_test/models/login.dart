import 'package:meta/meta.dart';
import 'dart:convert';

Login userFromJson(String str) => Login.fromJson(json.decode(str));

String userToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    @required this.username,
    @required this.password,
  });

  String? username;
  String? password;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
