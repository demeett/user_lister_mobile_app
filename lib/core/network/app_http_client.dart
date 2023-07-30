import 'package:http/http.dart' as http;

class AppHttpClient {
  late final http.Client _httpClient;
  AppHttpClient._() {
    _httpClient = http.Client();
  }
  static final instance = AppHttpClient._();
  http.Client get service => _httpClient;
}
