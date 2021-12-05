import 'dart:convert';

LaporanSuccess laporanSuccessFromJson(String str) =>
    LaporanSuccess.fromJson(json.decode(str));

String laporanSuccessToJson(LaporanSuccess data) => json.encode(data.toJson());

class LaporanSuccess {
  LaporanSuccess({
    this.status,
    this.message,
    this.seksi,
    this.nama,
    this.nim,
    this.pertemuan,
    this.absensiBelumDiverifikasi,
    this.hadir,
    this.izin,
    this.alpa,
  });

  String? status;
  String? message;
  Seksi? seksi;
  String? nama;
  String? nim;
  int? pertemuan;
  int? absensiBelumDiverifikasi;
  int? hadir;
  int? izin;
  int? alpa;

  factory LaporanSuccess.fromJson(Map<String, dynamic> json) => LaporanSuccess(
        status: json["status"],
        message: json["message"],
        seksi: Seksi.fromJson(json["seksi"]),
        nama: json["nama"],
        nim: json["nim"],
        pertemuan: json["pertemuan"],
        absensiBelumDiverifikasi: json["absensi_belum_diverifikasi"],
        hadir: json["hadir"],
        izin: json["izin"],
        alpa: json["alpa"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "seksi": seksi!.toJson(),
        "nama": nama,
        "nim": nim,
        "pertemuan": pertemuan,
        "absensi_belum_diverifikasi": absensiBelumDiverifikasi,
        "hadir": hadir,
        "izin": izin,
        "alpa": alpa,
      };
}

class Seksi {
  Seksi({
    this.kodeSeksi,
    this.idSeksi,
    this.namaMk,
    this.namaDosen,
    this.hari,
    this.jadwalMulai,
    this.jadwalSelesai,
    this.sks,
    this.kodeRuang,
  });

  int? idSeksi;
  String? kodeSeksi;
  String? namaMk;
  String? namaDosen;
  String? hari;
  String? jadwalMulai;
  String? jadwalSelesai;
  String? sks;
  String? kodeRuang;

  factory Seksi.fromJson(Map<String, dynamic> json) => Seksi(
        idSeksi: json["id_seksi"],
        kodeSeksi: json["kode_seksi"],
        namaMk: json["nama_mk"],
        namaDosen: json["nama_dosen"],
        hari: json["hari"],
        jadwalMulai: json["jadwal_mulai"],
        jadwalSelesai: json["jadwal_selesai"],
        sks: json["sks"],
        kodeRuang: json["kode_ruang"],
      );

  Map<String, dynamic> toJson() => {
        "id_seksi": idSeksi,
        "kode_seksi": kodeSeksi,
        "nama_mk": namaMk,
        "nama_dosen": namaDosen,
        "hari": hari,
        "jadwal_mulai": jadwalMulai,
        "jadwal_selesai": jadwalSelesai,
        "sks": sks,
        "kode_ruang": kodeRuang,
      };
}
