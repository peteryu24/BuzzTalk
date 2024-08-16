import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:alarm_app/src/repository/http_request.dart';

class AuthRepository {
  final Http httpRequest;

  AuthRepository(this.httpRequest);

  // 회원가입
  Future<void> register(String player_id, String password) async {
    final response = await httpRequest.post('/player/register', {
      'player_id': player_id,
      'password': password,
    });

    if (response['status'] != 'success') {
      throw Exception('Failed to register');
    }
  }

  // 로그인
  Future<bool> login(String player_id, String password) async {
    final response = await httpRequest.post('/player/login', {
      'player_id': player_id,
      'password': password,
    });

    // 응답 내용에 따라 성공 여부 판단
    if (response['status'] == 'success') {
      return true; // 로그인 성공
    } else {
      return false; // 로그인 실패
    }
  }

  // 비밀번호 변경
  Future<void> changePassword(
      String player_id, String oldPassword, String newPassword) async {
    final response = await httpRequest.post('/player/change-password', {
      'player_id': player_id,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    });

    if (response['status'] != 'success') {
      throw Exception('Failed to change password');
    }
  }

  // 회원 탈퇴
  Future<void> deletePlayer(String player_id, String password) async {
    final response = await httpRequest.post('/player/delete', {
      'player_id': player_id,
      'password': password,
    });

    if (response['status'] != 'success') {
      throw Exception('Failed to delete player');
    }
  }
}
