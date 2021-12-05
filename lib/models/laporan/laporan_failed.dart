import 'package:meta/meta.dart';
import 'dart:convert';

LaporanFailed laporanFailedFromJson(String str) =>
    LaporanFailed.fromJson(json.decode(str));

String laporanFailedToJson(LaporanFailed data) => json.encode(data.toJson());

class LaporanFailed {
  LaporanFailed({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory LaporanFailed.fromJson(Map<String, dynamic> json) => LaporanFailed(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
