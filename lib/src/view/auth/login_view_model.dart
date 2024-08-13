import 'package:flutter/material.dart';
import 'package:alarm_app/src/model/auth_model.dart';

class SignInViewModel extends ChangeNotifier {
  String _player_id = '';
  String _password = '';
  bool _isLoading = false;
  bool _isObscureText = true;
  bool _rememberMe = false;

  String get player_id => _player_id;
  String get password => _password;
  bool get isLoading => _isLoading;
  bool get isObscureText => _isObscureText;
  bool get isRememberMe => _rememberMe;

  void updateEmail(String email) {
    _player_id = player_id;
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

  void toggleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  Future<void> signIn() async {
    _isLoading = true;
    notifyListeners();

    UserModel user = UserModel(player_id: _player_id, password: _password);
    bool success = await user.signIn();

    _isLoading = false;
    notifyListeners();

    if (success) {
      // 로그인 성공 시 처리 로직
    } else {
      // 로그인 실패 시 처리 로직
    }
  }
}
