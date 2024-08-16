import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alarm_app/src/view/auth/login_view.dart'; // 로그인 뷰의 경로로 수정
import 'package:alarm_app/src/view/auth/login_view_model.dart'; // 로그인 뷰모델의 경로로 수정
import 'package:alarm_app/src/repository/auth_repository.dart';
import 'package:alarm_app/src/repository/http_request.dart'; // Http 클래스의 경로

void main() {
  final httpRequest = Http('https://your-api-url.com'); // API URL 설정
  final authRepository = AuthRepository(httpRequest);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel(authRepository)),
      ],
      child: MaterialApp(
        home: SignIn(), // CreateRoomView를 SignIn 뷰로 변경
      ),
    ),
  );
}
