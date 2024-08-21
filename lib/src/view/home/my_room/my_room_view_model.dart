import 'package:alarm_app/src/repository/auth_repository.dart';
import 'package:alarm_app/src/view/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:alarm_app/src/view/auth/chg_pwd_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:alarm_app/src/view/auth/chg_pwd_view_model.dart';

class MyRoomViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  MyRoomViewModel({required this.authRepository});

  Future<void> logout(BuildContext context) async {
    try {
      await authRepository.logout();
      GoRouter.of(context).go('/login');
    } catch (e) {
      // 오류 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to logout: $e")),
      );
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      await authRepository.deletePlayer();
      GoRouter.of(context).go('/login');
    } catch (e) {
      // 오류 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete account: $e")),
      );
    }
  }

  void changePassword(BuildContext context) {
    // 비밀번호 변경 화면으로 이동
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (_) =>
              ChangePasswordViewModel(context.read<AuthRepository>()),
          child: const ChangePasswordView(),
        ),
      ),
    );
  }
}
