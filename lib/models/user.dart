import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.nim,
    this.tahun,
    this.userId,
    this.namaMahasiswa,
    this.kodeJurusan,
    this.kodeGrup,
    this.imeiMahasiswa,
    this.createdAt,
    this.updatedAt,
    this.namaJurusan,
    this.status,
    this.id,
    this.username,
    this.nama,
    this.jk,
    this.emailVerifiedAt,
    this.password,
    this.level,
    this.avatar,
    this.imei,
    this.rememberToken,
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
