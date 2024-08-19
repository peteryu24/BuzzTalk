import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:alarm_app/src/repository/http_request.dart';

class AuthRepository {
  final Http httpRequest;

  AuthRepository(this.httpRequest);

  // 회원가입
  Future<Map<String, dynamic>> register(
      String playerId, String password) async {
    final response = await httpRequest.post('/player/register', {
      'playerId': playerId,
      'password': password,
    });

    return response;
  }

  // 로그인
  Future<bool> login(String playerId, String password) async {
    final response = await httpRequest.post('/player/login', {
      'playerId': playerId,
      'password': password,
    });

    if (response['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  // 비밀번호 변경
  Future<void> changePassword(
      String playerId, String oldPassword, String newPassword) async {
    final response = await httpRequest.post('/player/change-password', {
      'playerId': playerId,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    });

    if (response['status'] != 'success') {
      throw Exception('Failed to change password');
    }
  }

  // 회원 탈퇴
  Future<void> deletePlayer(String playerId) async {
    final response = await httpRequest.post('/player/delete', {
      'playerId': playerId,
    });

    if (response['status'] != 'success') {
      throw Exception('Failed to delete player');
    }
  }
}
