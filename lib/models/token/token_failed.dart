import 'dart:convert';

TokenFail tokenFailFromJson(String str) => TokenFail.fromJson(json.decode(str));

String tokenFailToJson(TokenFail data) => json.encode(data.toJson());

class TokenFail {
  TokenFail({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory TokenFail.fromJson(Map<String, dynamic> json) => TokenFail(
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
