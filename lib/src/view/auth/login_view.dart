// TODO: 임시
// TODO: Remember me : SharedPreferences?
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alarm_app/src/view/auth/login_view_model.dart';
import 'package:alarm_app/src/view/auth/rgt_view.dart';
import 'package:alarm_app/src/view/auth/chg_pwd_view.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider(
        create: (_) => SignInViewModel(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Consumer<SignInViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                          left: 29,
                          top: 270,
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: Color(0xFF110C26),
                              fontSize: 24,
                              fontFamily: 'Airbnb Cereal App',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 28,
                          top: 400,
                          right: 28,
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Switch.adaptive(
                                      value: viewModel.isRememberMe,
                                      onChanged: (value) {
                                        viewModel.toggleRememberMe(value);
                                      },
                                      activeColor: Color(0xFF5668FF),
                                    ),
                                  ),
                                  Text(
                                    'Remember Me',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xFF110C26),
                                      fontSize: 14,
                                      fontFamily: 'Airbnb Cereal App',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangePassword()), // ResetPassword 화면으로 이동
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color(0xFF110C26),
                                    fontSize: 14,
                                    fontFamily: 'Airbnb Cereal App',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 50,
                          top: 500,
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: viewModel.isLoading
                                    ? null
                                    : () {
                                        viewModel.signIn();
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF3D55F0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  minimumSize: Size(273, 56),
                                ),
                                child: viewModel.isLoading
                                    ? CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'SIGN IN',
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
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SignUp()), // SignUp 화면으로 이동
                                  );
                                },
                                child: DonTHaveAnAccountSignUp(),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 28,
                          top: 269,
                          child: Container(
                            width: 317,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Color(0xFFE4DEDE)),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Icon(Icons.email, color: Color(0xFF747688)),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) =>
                                          viewModel.updateEmail(value),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'abc@email.com',
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
                        ),
                        Positioned(
                          left: 28,
                          top: 344,
                          child: Container(
                            width: 317,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Color(0xFFE4DEDE)),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Icon(Icons.lock, color: Color(0xFF747688)),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: TextField(
                                      obscureText: viewModel.isObscureText,
                                      onChanged: (value) =>
                                          viewModel.updatePassword(value),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Your password',
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
                                    onTap: () => viewModel.toggleObscureText(),
                                    child: Icon(
                                      viewModel.isObscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Color(0xFF747688),
                                    ),
                                  ),
                                ],
                              ),
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
}

class DonTHaveAnAccountSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Don’t have an account?  ',
            style: TextStyle(
              color: Color(0xFF110C26),
              fontSize: 15,
              fontFamily: 'Airbnb Cereal App',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          TextSpan(
            text: 'Sign up',
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
    );
  }
}
