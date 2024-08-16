import 'package:alarm_app/util/auth_utils.dart';
import 'package:flutter/material.dart';
import 'package:alarm_app/src/repository/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  String _playerId = '';
  String _password = '';
  bool _isLoading = false;
  bool _isObscureText = true;
  String? _playerIdError;
  String? _passwordError;

  final AuthRepository _authRepository;

  // 영어 소문자와 숫자만 포함된 패턴, 최소 3자 이상, 최대 15자 이하
  // 최소 8자, 대문자, 소문자, 숫자, 특수문자를 각각 최소 하나씩 포함
  final _validator = AuthUtils();

  LoginViewModel(this._authRepository);

  String get playerId => _playerId;
  String get password => _password;
  bool get isLoading => _isLoading;
  bool get isObscureText => _isObscureText;
  String? get playerIdError => _playerIdError;
  String? get passwordError => _passwordError;

  void updatePlayerId(String playerId) {
    _playerId = playerId;
    _playerIdError = null; // 에러 메시지 초기화
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password;
    _passwordError = null; // 에러 메시지 초기화
    notifyListeners();
  }

  void toggleObscureText() {
    _isObscureText = !_isObscureText;
    notifyListeners();
  }

  Future<void> signIn() async {
    _isLoading = true;
    _playerIdError = null;
    _passwordError = null;
    notifyListeners();

    // 1순위: 아이디 형식 불일치 처리
    if (!_validator.isValidPlayerId(_playerId)) {
      _isLoading = false;
      _playerIdError = '아이디 형식이 맞지 않습니다.';
      notifyListeners();
      return;
    }

    // 2순위: 비밀번호 형식 불일치 처리
    if (!_validator.isValidPassword(_password)) {
      _isLoading = false;
      _passwordError = '비밀번호 형식이 맞지 않습니다.';
      notifyListeners();
      return;
    }

    // 형식 체크가 모두 통과된 경우 로그인 시도
    try {
      bool success = await _authRepository.login(_playerId, _password);

      _isLoading = false;
      notifyListeners();

      if (!success) {
        _playerIdError = '로그인 실패';
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      _playerIdError = '오류가 발생했습니다';
      notifyListeners();
    }
  }
}
