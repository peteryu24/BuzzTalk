// TODO: 임시
// TODO: 프론트에서도 아이디와 비밀번호 유효성 검증하기(특수문자, sql injection 방지, 아이디 중복, etc)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alarm_app/src/view/auth/rgt_view_model.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => SignUpViewModel(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Consumer<SignUpViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign up',
                    style: TextStyle(
                      color: Color(0xFF110C26),
                      fontSize: 24,
                      fontFamily: 'Airbnb Cereal App',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildInputField(
                          icon: Icons.person, // 여전히 사용할 수 있음
                          hintText: 'Username',
                          onChanged: viewModel.updatePlayerId,
                        ),
                        SizedBox(height: 20),
                        _buildPasswordField(
                          icon: Icons.lock,
                          hintText: 'Password',
                          obscureText: viewModel.obscureText,
                          onChanged: viewModel.updatePassword,
                          onToggle: viewModel.toggleObscureText,
                        ),
                        SizedBox(height: 20),
                        _buildPasswordField(
                          icon: Icons.lock,
                          hintText: 'Confirm password',
                          obscureText: viewModel.obscureConfirmText,
                          onChanged:
                              viewModel.updatePassword, // 비밀번호 확인도 동일하게 업데이트
                          onToggle: viewModel.toggleObscureConfirmText,
                        ),
                        SizedBox(height: 60),
                        _buildButton(
                          text: 'SIGN UP',
                          color: Color(0xFF3D55F0),
                          textColor: Colors.white,
                          icon: Icons.arrow_forward,
                          onPressed: viewModel.isLoading
                              ? null
                              : () {
                                  viewModel.signUp();
                                },
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Already have an account?  ',
                                    style: TextStyle(
                                      color: Color(0xFF110C26),
                                      fontSize: 15,
                                      fontFamily: 'Airbnb Cereal App',
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Sign in',
                                    style: TextStyle(
                                      color: Color(0xFF5668FF),
                                      fontSize: 15,
                                      fontFamily: 'Airbnb Cereal App',
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String hintText,
    required Function(String) onChanged,
  }) {
    return Center(
      child: Container(
        width: 317,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE4DEDE)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(icon, color: Color(0xFF747688)),
              SizedBox(width: 16),
              Expanded(
                child: TextField(
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: Color(0xFF747688),
                      fontSize: 14,
                      fontFamily: 'Airbnb Cereal App',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required IconData icon,
    required String hintText,
    required bool obscureText,
    required Function(String) onChanged,
    required VoidCallback onToggle,
  }) {
    return Center(
      child: Container(
        width: 317,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE4DEDE)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(icon, color: Color(0xFF747688)),
              SizedBox(width: 16),
              Expanded(
                child: TextField(
                  onChanged: onChanged,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: Color(0xFF747688),
                      fontSize: 14,
                      fontFamily: 'Airbnb Cereal App',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: onToggle,
                child: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Color(0xFF747688),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required Color color,
    required Color textColor,
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          fixedSize: Size(280, 56),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontFamily: 'Airbnb Cereal App',
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
            ),
            SizedBox(width: 10),
            Icon(icon, color: textColor),
          ],
        ),
      ),
    );
  }
}
