import 'package:http/http.dart' as http;

//jika melalui real device
const urlBase = 'http://192.168.100.162:8000/api';

// //jika melalui emulator
// const urlBase = 'http://10.0.2.2/api/';

class Request {
  String? url;
  dynamic body;

  Request({this.url, this.body});

  Future<http.Response> post() {
    return http
        .post(Uri.parse(urlBase + url!), body: body)
        .timeout(const Duration(minutes: 2));
  }

  Future<http.Response> get() {
    print(urlBase + url!);
    return http
        .get(Uri.parse(urlBase + url!))
        .timeout(const Duration(minutes: 2));
  }
}
