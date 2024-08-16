import 'package:flutter/material.dart';
import 'package:alarm_app/src/repository/auth_repository.dart';
import 'package:alarm_app/src/repository/http_request.dart';

class RgtViewModel extends ChangeNotifier {
  String _player_id = ''; // playerId 필드
  String _password = ''; // password 필드
  bool _isLoading = false;
  bool _obscureText = true;
  bool _obscureConfirmText = true;

  final AuthRepository _authRepository;

  RgtViewModel(this._authRepository);

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

    try {
      await _authRepository.register(_player_id, _password);
      // 회원가입 성공 시 처리 로직
    } catch (e) {
      // 회원가입 실패 시 처리 로직
      print('회원가입 실패: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
