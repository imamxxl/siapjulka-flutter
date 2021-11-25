import 'package:meta/meta.dart';
import 'dart:convert';

List<Pertemuan> pertemuanFromJson(String str) =>
    List<Pertemuan>.from(json.decode(str).map((x) => Pertemuan.fromJson(x)));

String pertemuanToJson(List<Pertemuan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pertemuan {
  Pertemuan({
    @required this.idAbsensi,
    @required this.idPertemuan,
    @required this.idSeksi,
    @required this.idUser,
    @required this.imeiAbsensi,
    @required this.qrcode,
    @required this.qrcodeImage,
    @required this.keterangan,
    @required this.catatan,
    @required this.verifikasi,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.tanggal,
    @required this.materi,
  });

  int? idAbsensi;
  int? idPertemuan;
  int? idSeksi;
  int? idUser;
  dynamic imeiAbsensi;
  String? qrcode;
  String? qrcodeImage;
  String? keterangan;
  String? catatan;
  int? verifikasi;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? tanggal;
  String? materi;

  factory Pertemuan.fromJson(Map<String, dynamic> json) => Pertemuan(
        idAbsensi: json["id_absensi"],
        idPertemuan: json["id_pertemuan"],
        idSeksi: json["id_seksi"],
        idUser: json["id_user"],
        imeiAbsensi: json["imei_absensi"],
        qrcode: json["qrcode"],
        qrcodeImage: json["qrcode_image"],
        keterangan: (json["keterangan"] == null) ? null : json["keterangan"],
        catatan: (json["catatan"] == null) ? null : json["catatan"],
        verifikasi: (json["verifikasi"] == null) ? null : json["verifikasi"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        tanggal: DateTime.parse(json["tanggal"]),
        materi: (json["materi"] == null) ? null : json["materi"],
      );

  Map<String, dynamic> toJson() => {
        "id_absensi": idAbsensi,
        "id_pertemuan": idPertemuan,
        "id_seksi": idSeksi,
        "id_user": idUser,
        "imei_absensi": imeiAbsensi,
        "qrcode": qrcode,
        "qrcode_image": qrcodeImage,
        "keterangan": (keterangan == null) ? null : keterangan,
        "catatan": (catatan == null) ? null : catatan,
        "verifikasi": (verifikasi == null) ? null : verifikasi,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "materi": (materi == null) ? null : materi,
      };
}
