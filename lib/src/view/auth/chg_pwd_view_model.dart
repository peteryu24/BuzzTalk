// TODO: 임시
import 'package:flutter/material.dart';
import 'package:alarm_app/src/model/auth_model.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> changePassword() async {
    _isLoading = true;
    notifyListeners();

    UserModel user = UserModel(player_id: '', password: '');
    bool success = await user.changePassword(emailController.text);

    _isLoading = false;
    notifyListeners();

    if (success) {
    } else {}
  }
}
