import 'package:meta/meta.dart';
import 'dart:convert';

NullSearch nullSearchFromJson(String str) =>
    NullSearch.fromJson(json.decode(str));

String nullSearchToJson(NullSearch data) => json.encode(data.toJson());

class NullSearch {
  NullSearch({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  String? status;
  String? message;
  dynamic data;

  factory NullSearch.fromJson(Map<String, dynamic> json) => NullSearch(
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
