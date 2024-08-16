import 'dart:convert';
import 'package:http/http.dart' as http;

//singleTon HTTP URL
class Http {
  final String baseUrl;
  static final Http _instance = Http._internal('http://localhost:3000');

  factory Http() {
    return _instance;
  }

  Http._internal(this.baseUrl);

  // GET 요청
  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // POST 요청
  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }
}
