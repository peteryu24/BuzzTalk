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

  LoginViewModel(this._authRepository);

  String get playerId => _playerId;
  String get password => _password;
  bool get isLoading => _isLoading;
  bool get isObscureText => _isObscureText;
  String? get playerIdError => _playerIdError;
  String? get passwordError => _passwordError;

  void updatePlayerId(String playerId) {
    _playerId = playerId;
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password;
    notifyListeners();
  }

  void toggleObscureText() {
    _isObscureText = !_isObscureText;
    notifyListeners();
  }

  // 영어 소문자와 숫자만 포함된 패턴, 최소 3자 이상, 최대 15자 이하
  bool playerIdFlag(String playerId) {
    return RegExp(r'^[a-z0-9]{3,15}$').hasMatch(playerId);
  }

  // 최소 8자, 대문자, 소문자, 숫자, 특수문자를 각각 최소 하나씩 포함
  bool passwordIdFlag(String password) {
    return password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  Future<void> signIn() async {
    _isLoading = true;
    _playerIdError = null;
    _passwordError = null;
    notifyListeners();

    if (!playerIdFlag(_playerId)) {
      _playerIdError = '아이디 형식 불일치 다시 시도하세요';
    }
    if (!passwordIdFlag(_password)) {
      _passwordError = '비번 형식 불일치 다시 시도하세요';
    }
    if (_playerIdError != null || _passwordError != null) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      bool success = await _authRepository.login(_playerId, _password);

      _isLoading = false;
      notifyListeners();

      if (!success) {
        _playerIdError = 'Login failed';
      }
    } catch (e) {
      _isLoading = false;
      _playerIdError = 'An error occurred';
      notifyListeners();
    }
  }
}
