import 'package:meta/meta.dart';
import 'dart:convert';

List<Search> searchFromJson(String str) =>
    List<Search>.from(json.decode(str).map((x) => Search.fromJson(x)));

String searchToJson(List<Search> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Search {
  Search({
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
  String? namaMk;
  String? sks;
  int? userId;
  String? namaDosen;
  String? nipDosen;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
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
        "nama_mk": namaMk,
        "sks": sks,
        "user_id": userId,
        "nama_dosen": namaDosen,
        "nip_dosen": nipDosen,
      };
}
