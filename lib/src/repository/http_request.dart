import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Http {
  final String baseUrl;
  static final Http _instance = Http._internal('http://172.30.1.71:3000');

  factory Http() {
    return _instance;
  }

  Http._internal(this.baseUrl);

  // 쿠키 저장
  Future<void> _saveCookie(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('connect.sid', cookie);
  }

  // 쿠키 로드
  Future<String?> _loadCookie() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('connect.sid');
  }

  Future<dynamic> get(String endpoint) async {
    final cookie = await _loadCookie();
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: cookie != null ? {'Cookie': 'connect.sid=$cookie'} : {},
    );

    if (response.statusCode == 200) {
      final setCookieHeader = response.headers['set-cookie'];
      if (setCookieHeader != null) {
        final cookieValue = _extractCookieValue(setCookieHeader);
        if (cookieValue != null) {
          await _saveCookie(cookieValue);
        }
      }

      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // POST 요청
  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> data) async {
    final cookie = await _loadCookie();
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (cookie != null) 'Cookie': 'connect.sid=$cookie',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final setCookieHeader = response.headers['set-cookie'];
      if (setCookieHeader != null) {
        final cookieValue = _extractCookieValue(setCookieHeader);
        if (cookieValue != null) {
          await _saveCookie(cookieValue);
        }
      }

      return jsonDecode(response.body);
    } else {
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

  String? _extractCookieValue(String setCookieHeader) {
    final cookieParts = setCookieHeader.split(';');
    if (cookieParts.isNotEmpty) {
      return cookieParts[0].split('=')[1];
    }
    return null;
  }
}
