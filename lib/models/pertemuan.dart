import 'package:meta/meta.dart';
import 'dart:convert';

List<Pertemuan> pertemuanFromJson(String str) =>
    List<Pertemuan>.from(json.decode(str).map((x) => Pertemuan.fromJson(x)));

String pertemuanToJson(List<Pertemuan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pertemuan {
  Pertemuan({
    @required this.idAbsensi,
    @required this.kodeSeksi,
    @required this.kodeJurusan,
    @required this.kodeMk,
    @required this.kodeDosen,
    @required this.kodeRuang,
    @required this.hari,
    @required this.jadwalMulai,
    @required this.jadwalSelesai,
    @required this.status,
    @required this.idPertemuan,
    @required this.imeiAbsensi,
    @required this.keterangan,
    @required this.catatan,
    @required this.verifikasi,
    @required this.namaMk,
    @required this.sks,
    @required this.tanggal,
    @required this.materi,
  });

  int? idAbsensi;
  String? kodeSeksi;
  String? kodeJurusan;
  String? kodeMk;
  String? kodeDosen;
  String? kodeRuang;
  String? hari;
  String? jadwalMulai;
  String? jadwalSelesai;
  int? status;
  int? idPertemuan;
  dynamic imeiAbsensi;
  String? keterangan;
  String? catatan;
  int? verifikasi;
  String? namaMk;
  String? sks;
  DateTime? tanggal;
  String? materi;

  factory Pertemuan.fromJson(Map<String, dynamic> json) => Pertemuan(
        idAbsensi: json["id_absensi"],
        kodeSeksi: json["kode_seksi"],
        kodeJurusan: json["kode_jurusan"],
        kodeMk: json["kode_mk"],
        kodeDosen: json["kode_dosen"],
        kodeRuang: json["kode_ruang"],
        hari: json["hari"],
        jadwalMulai: json["jadwal_mulai"],
        jadwalSelesai: json["jadwal_selesai"],
        status: json["status"],
        idPertemuan: json["id_pertemuan"],
        imeiAbsensi: json["imei_absensi"],
        keterangan: (json["keterangan"] == null) ? null : json["keterangan"],
        catatan: (json["catatan"] == null) ? null : json["catatan"],
        verifikasi: (json["verifikasi"] == null) ? null : json["verifikasi"],
        namaMk: json["nama_mk"],
        sks: json["sks"],
        tanggal: DateTime.parse(json["tanggal"]),
        materi: (json["materi"] == null) ? null : json["materi"],
      );

  Map<String, dynamic> toJson() => {
        "id_absensi": idAbsensi,
        "kode_seksi": kodeSeksi,
        "kode_jurusan": kodeJurusan,
        "kode_mk": kodeMk,
        "kode_dosen": kodeDosen,
        "kode_ruang": kodeRuang,
        "hari": hari,
        "jadwal_mulai": jadwalMulai,
        "jadwal_selesai": jadwalSelesai,
        "status": status,
        "id_pertemuan": idPertemuan,
        "imei_absensi": imeiAbsensi,
        "keterangan": (keterangan == null) ? null : keterangan,
        "catatan": (catatan == null) ? null : catatan,
        "verifikasi": (verifikasi == null) ? null : verifikasi,
        "nama_mk": namaMk,
        "sks": sks,
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "materi": (materi == null) ? null : materi,
      };
}
