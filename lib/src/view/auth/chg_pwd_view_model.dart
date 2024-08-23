import 'package:flutter/material.dart';
import 'package:alarm_app/src/repository/auth_repository.dart';
import 'package:alarm_app/util/error_pop_util.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final ErrorPopUtils _errorPopUtil = ErrorPopUtils();

  ChangePasswordViewModel(this._authRepository);

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordCheck,
    required BuildContext context,
    required VoidCallback onClearTextFields, // 추가된 콜백
  }) async {
    if (newPassword != newPasswordCheck) {
      _errorPopUtil.showErrorDialog(context, 8); // Password mismatch error code
      onClearTextFields(); // 텍스트 필드 초기화 호출
      return;
    }

    try {
      await _authRepository.changePassword(
        oldPassword,
        newPassword,
        newPasswordCheck,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("비밀번호가 성공적으로 변경되었습니다.")),
      );
      Navigator.pop(context);
    } catch (e) {
      int errorCode = e is int ? e : 20; // 기본값 20
      onClearTextFields(); // 텍스트 필드 초기화 호출
      _errorPopUtil.showErrorDialog(context, errorCode);
      notifyListeners();
    }
  }
}
