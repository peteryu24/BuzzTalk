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
  }) async {
    if (newPassword != newPasswordCheck) {
      // 비밀번호 불일치 오류 처리
      _errorPopUtil.showErrorDialog(context, 3); // 비밀번호 불일치 오류 코드
      return;
    }

    try {
      final response = await _authRepository.changePassword(
          oldPassword, newPassword, newPasswordCheck);

      if (response['result'] == true) {
        // 비밀번호 변경 성공
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("비밀번호가 성공적으로 변경되었습니다.")),
        );
        Navigator.pop(context);
      } else {
        // 서버에서 반환된 오류 코드 처리
        final errorCode = response['errNum'] as int? ?? 20; // 기본값 20: 예외 발생
        _errorPopUtil.showErrorDialog(context, errorCode);
      }
    } catch (e) {
      // 예외 발생 시 오류 다이얼로그 표시
      _errorPopUtil.showErrorDialog(context, 20); // 기본 예외 오류 코드
    }
  }
}
