// To parse this JSON data, do
//
//     final absensi = absensiFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Absensi absensiFromJson(String str) => Absensi.fromJson(json.decode(str));

String absensiToJson(Absensi data) => json.encode(data.toJson());

class Absensi {
  Absensi({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory Absensi.fromJson(Map<String, dynamic> json) => Absensi(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    @required this.idAbsensi,
    @required this.idPertemuan,
    @required this.idSeksi,
    @required this.idUser,
    @required this.qrcode,
    @required this.keterangan,
    @required this.catatan,
    @required this.verifikasi,
  });

  int? idAbsensi;
  int? idPertemuan;
  int? idSeksi;
  int? idUser;
  String? qrcode;
  String? keterangan;
  dynamic catatan;
  dynamic verifikasi;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idAbsensi: json["id_absensi"],
        idPertemuan: json["id_pertemuan"],
        idSeksi: json["id_seksi"],
        idUser: json["id_user"],
        qrcode: json["qrcode"],
        keterangan: json["keterangan"],
        catatan: json["catatan"],
        verifikasi: json["verifikasi"],
      );

  Map<String, dynamic> toJson() => {
        "id_absensi": idAbsensi,
        "id_pertemuan": idPertemuan,
        "id_seksi": idSeksi,
        "id_user": idUser,
        "qrcode": qrcode,
        "keterangan": keterangan,
        "catatan": catatan,
        "verifikasi": verifikasi,
      };
}
