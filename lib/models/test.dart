// To parse this JSON data, do
//
//     final test = testFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Test testFromJson(String str) => Test.fromJson(json.decode(str));

String testToJson(Test data) => json.encode(data.toJson());

class Test {
  Test({
    @required this.nim,
    @required this.tahun,
    @required this.userId,
    @required this.namaMahasiswa,
    @required this.kodeJurusan,
    @required this.kodeGrup,
    @required this.imeiMahasiswa,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.namaJurusan,
    @required this.status,
    @required this.id,
    @required this.username,
    @required this.nama,
    @required this.jk,
    @required this.emailVerifiedAt,
    @required this.password,
    @required this.level,
    @required this.avatar,
    @required this.imei,
    @required this.rememberToken,
  });

  String? nim;
  String? tahun;
  int? userId;
  String? namaMahasiswa;
  String? kodeJurusan;
  dynamic kodeGrup;
  String? imeiMahasiswa;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? namaJurusan;
  int? status;
  int? id;
  String? username;
  String? nama;
  String? jk;
  dynamic emailVerifiedAt;
  String? password;
  String? level;
  String? avatar;
  String? imei;
  dynamic rememberToken;

  factory Test.fromJson(Map<String, dynamic> json) => Test(
        nim: json["nim"],
        tahun: json["tahun"],
        userId: json["user_id"],
        namaMahasiswa: json["nama_mahasiswa"],
        kodeJurusan: json["kode_jurusan"],
        kodeGrup: json["kode_grup"],
        imeiMahasiswa: json["imei_mahasiswa"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        namaJurusan: json["nama_jurusan"],
        status: json["status"],
        id: json["id"],
        username: json["username"],
        nama: json["nama"],
        jk: json["jk"],
        emailVerifiedAt: json["email_verified_at"],
        password: json["password"],
        level: json["level"],
        avatar: json["avatar"],
        imei: json["imei"],
        rememberToken: json["remember_token"],
      );

  Map<String, dynamic> toJson() => {
        "nim": nim,
        "tahun": tahun,
        "user_id": userId,
        "nama_mahasiswa": namaMahasiswa,
        "kode_jurusan": kodeJurusan,
        "kode_grup": kodeGrup,
        "imei_mahasiswa": imeiMahasiswa,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "nama_jurusan": namaJurusan,
        "status": status,
        "id": id,
        "username": username,
        "nama": nama,
        "jk": jk,
        "email_verified_at": emailVerifiedAt,
        "password": password,
        "level": level,
        "avatar": avatar,
        "imei": imei,
        "remember_token": rememberToken,
      };
}
