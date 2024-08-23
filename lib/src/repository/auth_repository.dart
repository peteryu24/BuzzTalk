import 'package:alarm_app/src/model/auth_model.dart'; // 모델 클래스 임포트
import 'package:alarm_app/src/repository/http_request.dart';

class AuthRepository {
  final Http httpRequest;

  AuthRepository(this.httpRequest);

  Future<AuthModel> register(String playerId, String password) async {
    final response = await httpRequest.post('/player/register', {
      'playerId': playerId,
      'password': password,
    });

    if (response['result'] == true) {
      return AuthModel.fromJson(response['data']); // 성공적인 경우 AuthModel 반환
    } else {
      throw Exception(response['errNum'] ?? 20); // 에러 코드 반환
    }
  }

  Future<AuthModel> login(String playerId, String password) async {
    final response = await httpRequest.post('/player/login', {
      'playerId': playerId,
      'password': password,
    });

    if (response['result'] == true) {
      return AuthModel.fromJson(response['data']); // 성공적인 경우 AuthModel 반환
    } else {
      throw Exception(response['errNum'] ?? 20); // 에러 코드 반환
    }
  }

  Future<void> changePassword(
      String oldPassword, String newPassword, String newPasswordCheck) async {
    final response = await httpRequest.post('/player/changePassword', {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'newPasswordCheck': newPasswordCheck,
    });

    if (response['result'] != true) {
      throw Exception(response['errNum'] ?? 20); // 에러 코드 반환
    }
  }

  Future<void> deletePlayer() async {
    final response = await httpRequest.post('/player/delete', {});

    if (response['result'] != true) {
      throw Exception(response['errNum'] ?? 20); // 에러 코드 반환
    }
  }

  Future<void> logout() async {
    final response = await httpRequest.post('/player/logout', {});

    if (response['result'] != true) {
      throw Exception(response['errNum'] ?? 20); // 에러 코드 반환
    }
  }
}
