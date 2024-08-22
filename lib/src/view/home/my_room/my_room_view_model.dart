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

  void _showConfirmationSheet({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: const Color(0xFF1C1C1E), // 배경 색상 설정
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 20, 42, 128),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        '취소',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConfirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // 확인 버튼 색상 (탈퇴, 로그아웃 등)
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    _showConfirmationSheet(
      context: context,
      title: '로그아웃',
      message: '정말로 로그아웃하시겠습니까?',
      onConfirm: () async {
        try {
          await authRepository.logout();
          GoRouter.of(context).go('/login');
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to logout: $e")),
          );
        }
      },
    );
  }

  Future<void> deleteAccount(BuildContext context) async {
    _showConfirmationSheet(
      context: context,
      title: '계정 삭제',
      message: '탈퇴 후 계정 복구는 불가합니다.\n정말로 탈퇴하시겠습니까?',
      onConfirm: () async {
        try {
          await authRepository.deletePlayer();
          GoRouter.of(context).go('/login');
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to delete account: $e")),
          );
        }
      },
    );
  }

  void changePassword(BuildContext context) {
    _showConfirmationSheet(
      context: context,
      title: '비밀번호 변경',
      message: '비밀번호를 변경하시겠습니까?',
      onConfirm: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) =>
                  ChangePasswordViewModel(context.read<AuthRepository>()),
              child: const ChangePasswordView(),
            ),
          ),
        );
      },
    );
  }
}
