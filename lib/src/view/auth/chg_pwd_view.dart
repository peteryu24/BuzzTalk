import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alarm_app/src/view/auth/chg_pwd_view_model.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordCheckController =
      TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordCheckController.dispose();
    super.dispose();
  }

  void _clearTextFields() {
    _oldPasswordController.clear();
    _newPasswordController.clear();
    _newPasswordCheckController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("비밀번호 변경"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(
              label: "기존 비밀번호",
              controller: _oldPasswordController,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: "새로운 비밀번호",
              controller: _newPasswordController,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: "비밀번호 확인",
              controller: _newPasswordCheckController,
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                await context.read<ChangePasswordViewModel>().changePassword(
                      oldPassword: _oldPasswordController.text,
                      newPassword: _newPasswordController.text,
                      newPasswordCheck: _newPasswordCheckController.text,
                      context: context,
                      onClearTextFields: _clearTextFields, // 콜백 전달
                    );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 20, 42, 128),
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    "비밀번호 변경",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 20, 42, 128),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
