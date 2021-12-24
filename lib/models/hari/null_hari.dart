import 'dart:convert';

NullHari nullHariFromJson(String str) => NullHari.fromJson(json.decode(str));

String nullHariToJson(NullHari data) => json.encode(data.toJson());

class NullHari {
  NullHari({
    this.status,
    this.type,
    this.message,
    this.data,
  });

  String? status;
  String? type;
  String? message;
  dynamic data;

  factory NullHari.fromJson(Map<String, dynamic> json) => NullHari(
        status: json["status"],
        type: json["type"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "type": type,
        "message": message,
        "data": data,
      };
}
