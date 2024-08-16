import 'package:flutter/material.dart';
import 'package:alarm_app/src/repository/auth_repository.dart';
import 'package:alarm_app/util/auth_utils.dart';

class RgtViewModel extends ChangeNotifier {
  String _playerId = '';
  String _password = '';
  bool _isLoading = false;
  bool _obscureText = true;
  bool _obscureConfirmText = true;

  final AuthRepository _authRepository;

  // 영어 소문자와 숫자만 포함된 패턴, 최소 3자 이상, 최대 15자 이하
  // 최소 8자, 대문자, 소문자, 숫자, 특수문자를 각각 최소 하나씩 포함
  final _validator = AuthUtils();

  RgtViewModel(this._authRepository);

  String get playerId => _playerId;
  String get password => _password;
  bool get isLoading => _isLoading;
  bool get obscureText => _obscureText;
  bool get obscureConfirmText => _obscureConfirmText;

  void updatePlayerId(String playerId) {
    _playerId = playerId;
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password;
    notifyListeners();
  }

  void toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  void toggleObscureConfirmText() {
    _obscureConfirmText = !_obscureConfirmText;
    notifyListeners();
  }

  Future<void> signUp() async {
    _isLoading = true;
    notifyListeners();

    if (!_validator.isValidPlayerId(_playerId)) {
      print('아이디 형식 불일치');
      _isLoading = false;
      notifyListeners();
      return;
    }

    if (!_validator.isValidPassword(_password)) {
      print('비번 형식 불일치');
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      await _authRepository.register(_playerId, _password);
      // 회원가입 성공 시 처리 로직
    } catch (e) {
      print('회원가입 실패: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
