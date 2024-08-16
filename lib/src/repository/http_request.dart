import 'dart:convert';
import 'package:http/http.dart' as http;

class Http {
  final String baseUrl;
  Http(this.baseUrl);

  //연결 설정
  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      // 서버 오류 메시지를 처리
      Map<String, dynamic> errorResponse;
      try {
        errorResponse = jsonDecode(response.body);
      } catch (e) {
        errorResponse = {'error': 'An unexpected error occurred'};
      }
      String errorMessage = errorResponse['message'] ?? 'error!';
      throw Exception(errorMessage);
    }
  }
}
