import 'package:meta/meta.dart';
import 'dart:convert';

SeksiFail seksiFailFromJson(String str) => SeksiFail.fromJson(json.decode(str));

String seksiFailToJson(SeksiFail data) => json.encode(data.toJson());

class SeksiFail {
  SeksiFail({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory SeksiFail.fromJson(Map<String, dynamic> json) => SeksiFail(
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
