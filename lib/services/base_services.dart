import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:siapjulka/helper/app_exceptions.dart';

class BaseService {
  static const int timeOutDuration = 20;

  // Get
  Future<dynamic> get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response =
          await http.get(uri).timeout(const Duration(seconds: timeOutDuration));
      return processResponse(response);
    } on SocketException {
      throw FetchDataException('Tidak ada koneksi internet', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Data tidak dapat diakses saat ini', uri.toString());
    }
  }

  // Post
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await http
          .post(uri, body: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      throw BadRequestException(
          '{"message":"Imei tidak ditemukan", "status":"Error"}',
          response.request!.url.toString());
      // return _processResponse(response);
    } on SocketException {
      throw FetchDataException('Tidak ada koneksi internet', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Data tidak dapat diakses saat ini', uri.toString());
    }
  }

  // Delete
  // Other

  dynamic processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error dideteksi, kode : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
