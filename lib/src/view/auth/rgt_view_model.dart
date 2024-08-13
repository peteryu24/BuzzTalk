// TODO: 임시
import 'package:flutter/material.dart';
import 'package:alarm_app/src/model/auth_model.dart';

class SignUpViewModel extends ChangeNotifier {
  String _player_id = ''; // playerId 필드
  String _password = ''; // password 필드
  bool _isLoading = false;
  bool _obscureText = true;
  bool _obscureConfirmText = true;

  String get player_id => _player_id;
  String get password => _password;
  bool get isLoading => _isLoading;
  bool get obscureText => _obscureText;
  bool get obscureConfirmText => _obscureConfirmText;

  void updatePlayerId(String playerId) {
    _player_id = playerId;
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

    UserModel user = UserModel(player_id: _player_id, password: _password);
    bool success = await user.signUp();

    _isLoading = false;
    notifyListeners();

    if (success) {
      // 회원가입 성공 시 처리 로직
    } else {
      // 회원가입 실패 시 처리 로직
    }
  }
}
