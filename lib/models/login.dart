import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.id,
    required this.username,
    required this.nama,
    required this.jk,
    required this.emailVerifiedAt,
    required this.status,
    required this.level,
    required this.avatar,
    required this.imei,
  });

  int id;
  String username;
  String nama;
  String jk;
  dynamic emailVerifiedAt;
  int status;
  String level;
  String avatar;
  dynamic imei;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        id: json["id"],
        username: json["username"],
        nama: json["nama"],
        jk: json["jk"],
        emailVerifiedAt: json["email_verified_at"],
        status: json["status"],
        level: json["level"],
        avatar: json["avatar"],
        imei: json["imei"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "nama": nama,
        "jk": jk,
        "email_verified_at": emailVerifiedAt,
        "status": status,
        "level": level,
        "avatar": avatar,
        "imei": imei,
      };
}
