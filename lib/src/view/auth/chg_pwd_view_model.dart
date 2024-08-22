import 'package:flutter/material.dart';
import 'package:alarm_app/src/repository/auth_repository.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  ChangePasswordViewModel(this._authRepository);

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordCheck,
  }) async {
    if (newPassword != newPasswordCheck) {
      throw Exception("New passwords do not match");
    }

    try {
      final response = await _authRepository.changePassword(
          oldPassword, newPassword, newPasswordCheck);

      if (response['result'] == true) {
        // 성공 시 추가 작업
        print("Password changed successfully");
      } else {
        // 실패 시 서버에서 제공된 오류 메시지를 던짐
        throw Exception(response['msg'] ?? "Failed to change password");
      }
    } catch (e) {
      // 실패 시 추가 작업
      print("Failed to change password: $e");
      rethrow;
    }
  }
}
