import 'package:http/http.dart' as http;

class Domain {
  // ip for product
  String baseUrl = 'https://www.hatipetani.com/api';
  String imageUrl = 'https://www.hatipetani.com';

  // // ip debug with wifi
  // String baseUrl = 'http://192.168.100.162:8000/api';
  // String imageUrl = 'http://192.168.100.162:8000';

  // // ip debug with tethering samsung j6
  // String baseUrl = 'http://192.168.43.6:8000/api';
  // String imageUrl = 'http://192.168.43.6:8000';

  static const int timeOutDuration = 20;

  final String? url;
  final dynamic body;
  final dynamic parameter;

  Domain({this.url, this.body, this.parameter});

  Future<http.Response> post() {
    return http
        .post(Uri.parse(baseUrl + url!), body: body)
        .timeout(const Duration(seconds: timeOutDuration));
  }

  Future<http.Response> get() {
    return http
        .get(Uri.parse(baseUrl + url!))
        .timeout(const Duration(seconds: timeOutDuration));
  }

  Future<http.Response> getparameter() {
    return http
        .get(Uri.parse(baseUrl + url! + parameter))
        .timeout(const Duration(seconds: timeOutDuration));
  }
}
