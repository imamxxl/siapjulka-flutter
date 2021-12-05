import 'package:meta/meta.dart';
import 'dart:convert';

TokenSuccess tokenSuccessFromJson(String str) =>
    TokenSuccess.fromJson(json.decode(str));

String tokenSuccessToJson(TokenSuccess data) => json.encode(data.toJson());

class TokenSuccess {
  TokenSuccess({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory TokenSuccess.fromJson(Map<String, dynamic> json) => TokenSuccess(
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
    @required this.id,
    @required this.kodeSeksi,
    @required this.token,
    @required this.kodeJurusan,
    @required this.kodeMk,
    @required this.kodeDosen,
    @required this.kodeRuang,
    @required this.hari,
    @required this.jadwalMulai,
    @required this.jadwalSelesai,
    @required this.status,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.namaMk,
    @required this.sks,
    @required this.userId,
    @required this.namaDosen,
    @required this.nipDosen,
  });

  int? id;
  String? kodeSeksi;
  String? token;
  String? kodeJurusan;
  String? kodeMk;
  String? kodeDosen;
  String? kodeRuang;
  String? hari;
  String? jadwalMulai;
  String? jadwalSelesai;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? namaMk;
  String? sks;
  int? userId;
  String? namaDosen;
  String? nipDosen;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        kodeSeksi: json["kode_seksi"],
        token: json["token"],
        kodeJurusan: json["kode_jurusan"],
        kodeMk: json["kode_mk"],
        kodeDosen: json["kode_dosen"],
        kodeRuang: json["kode_ruang"],
        hari: json["hari"],
        jadwalMulai: json["jadwal_mulai"],
        jadwalSelesai: json["jadwal_selesai"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        namaMk: json["nama_mk"],
        sks: json["sks"],
        userId: json["user_id"],
        namaDosen: json["nama_dosen"],
        nipDosen: json["nip_dosen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_seksi": kodeSeksi,
        "token": token,
        "kode_jurusan": kodeJurusan,
        "kode_mk": kodeMk,
        "kode_dosen": kodeDosen,
        "kode_ruang": kodeRuang,
        "hari": hari,
        "jadwal_mulai": jadwalMulai,
        "jadwal_selesai": jadwalSelesai,
        "status": status,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "nama_mk": namaMk,
        "sks": sks,
        "user_id": userId,
        "nama_dosen": namaDosen,
        "nip_dosen": nipDosen,
      };
}
