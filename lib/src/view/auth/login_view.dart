import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alarm_app/src/view/auth/login_view_model.dart';
import 'package:alarm_app/src/repository/auth_repository.dart';
import 'package:alarm_app/src/repository/http_request.dart';
import 'package:alarm_app/src/view/auth/rgt_view.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final httpRequest = Http();
    final authRepository = AuthRepository(httpRequest);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider(
        create: (_) => LoginViewModel(authRepository),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Consumer<LoginViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        const Positioned(
                          left: 28,
                          top: 150,
                          child: Text(
                            'BuzzTalk',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 28,
                          top: 500,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 317,
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: viewModel.isLoading
                                      ? null
                                      : () {
                                          viewModel.signIn(context);
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 20, 42, 128),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: viewModel.isLoading
                                      ? const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        )
                                      : const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '로그인',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: 'Airbnb Cereal App',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Icon(Icons.arrow_forward,
                                                color: Colors.white),
                                          ],
                                        ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp()),
                                  );
                                },
                                child: const DonTHaveAnAccountSignUp(),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 28,
                          top: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTextField(
                                label: '아이디',
                                icon: Icons.person,
                                onChanged: viewModel.updatePlayerId,
                                errorText: viewModel.playerIdError,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                label: '비밀번호',
                                icon: Icons.lock,
                                controller: viewModel.passwordController,
                                obscureText: viewModel.isObscureText,
                                onChanged: viewModel.updatePassword,
                                onToggleVisibility: viewModel.toggleObscureText,
                                errorText: viewModel.passwordError,
                              ),
                            ],
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

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required Function(String) onChanged,
    TextEditingController? controller,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 317,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE4DEDE)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF747688)),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: label,
                      hintStyle: const TextStyle(
                        color: Color(0xFF747688),
                        fontSize: 14,
                        fontFamily: 'Airbnb Cereal App',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                if (onToggleVisibility != null)
                  GestureDetector(
                    onTap: onToggleVisibility,
                    child: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF747688),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              errorText,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}

class DonTHaveAnAccountSignUp extends StatelessWidget {
  const DonTHaveAnAccountSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUp()),
        );
      },
      child: const Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '계정이 없으신가요? ',
              style: TextStyle(
                color: Color(0xFF110C26),
                fontSize: 15,
                fontFamily: 'Airbnb Cereal App',
              ),
            ),
            TextSpan(
              text: '회원가입',
              style: TextStyle(
                color: Color.fromARGB(255, 20, 42, 128),
                fontSize: 15,
                fontFamily: 'Airbnb Cereal App',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
