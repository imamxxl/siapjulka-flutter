import 'package:meta/meta.dart';
import 'dart:convert';

List<ListHari> listHariFromJson(String str) =>
    List<ListHari>.from(json.decode(str).map((x) => ListHari.fromJson(x)));

String listHariToJson(List<ListHari> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListHari {
  ListHari({
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
    @required this.idParticipant,
    @required this.idSeksi,
    @required this.imeiParticipant,
    @required this.keterangan,
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
  int? idParticipant;
  int? idSeksi;
  String? imeiParticipant;
  int? keterangan;

  factory ListHari.fromJson(Map<String, dynamic> json) => ListHari(
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
        idParticipant: json["id_participant"],
        idSeksi: json["id_seksi"],
        imeiParticipant: json["imei_participant"],
        keterangan: json["keterangan"],
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
        "id_participant": idParticipant,
        "id_seksi": idSeksi,
        "imei_participant": imeiParticipant,
        "keterangan": keterangan,
      };
}
