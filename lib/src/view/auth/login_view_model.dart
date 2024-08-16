import 'package:flutter/material.dart';
import 'package:alarm_app/src/repository/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  String _player_id = '';
  String _password = '';
  bool _isLoading = false;
  bool _isObscureText = true;
  //bool _rememberMe = false;
  String? _playerIdError;
  String? _passwordError;

  final AuthRepository _authRepository;

  LoginViewModel(this._authRepository);

  String get player_id => _player_id;
  String get password => _password;
  bool get isLoading => _isLoading;
  bool get isObscureText => _isObscureText;
  //bool get isRememberMe => _isRememberMe;
  String? get playerIdError => _playerIdError;
  String? get passwordError => _passwordError;

  void updatePlayerId(String playerId) {
    _player_id = playerId;
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

/*
  void toggleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }
  */

  bool isValidPlayerId(String playerId) {
    return RegExp(r'^[a-z0-9]{3,15}$').hasMatch(playerId);
  }

  bool isValidPassword(String password) {
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

    if (!isValidPlayerId(_player_id)) {
      _playerIdError = '아이디 형식 불일치 다시 시도하세요';
    }
    if (!isValidPassword(_password)) {
      _passwordError = '비번 형식 불일치 다시 시도하세요';
    }
    if (_playerIdError != null || _passwordError != null) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      bool success = await _authRepository.login(_player_id, _password);

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
