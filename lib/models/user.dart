import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    @required this.nim,
    @required this.tahun,
    @required this.userId,
    @required this.namaMahasiswa,
    @required this.kodeJurusan,
    @required this.kodeGrup,
    @required this.deviceId,
    @required this.namaJurusan,
    @required this.status,
    @required this.jk,
    @required this.avatar,
  });

  String? nim;
  String? tahun;
  int? userId;
  String? namaMahasiswa;
  String? kodeJurusan;
  dynamic kodeGrup;
  String? deviceId;
  String? namaJurusan;
  int? status;
  String? jk;
  String? avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
        nim: json["nim"],
        tahun: json["tahun"],
        userId: json["user_id"],
        namaMahasiswa: json["nama_mahasiswa"],
        kodeJurusan: json["kode_jurusan"],
        kodeGrup: json["kode_grup"],
        deviceId: json["imei_mahasiswa"],
        namaJurusan: json["nama_jurusan"],
        status: json["status"],
        jk: json["jk"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "nim": nim,
        "tahun": tahun,
        "user_id": userId,
        "nama_mahasiswa": namaMahasiswa,
        "kode_jurusan": kodeJurusan,
        "kode_grup": kodeGrup,
        "imei_mahasiswa": deviceId,
        "nama_jurusan": namaJurusan,
        "status": status,
        "jk": jk,
        "avatar": avatar,
      };

  @override
  String toString() {
    return 'User{nim: $nim, tahun: $tahun, user_id: $userId, nama_mahasiswa: $namaMahasiswa, kode_jurusan: $kodeJurusan, kode_grup: $kodeGrup, imei_mahasiswa: $deviceId, nama_jurusan: $namaJurusan, status: $status, jk: $jk, avatar: $avatar}';
  }

  List<User> userFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<User>.from(data.map((item) => User.fromJson(item)));
  }

  String userToJson(User data) {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }
}
