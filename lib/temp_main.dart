import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alarm_app/src/view/auth/login_view.dart';
import 'package:alarm_app/src/view/auth/login_view_model.dart';
import 'package:alarm_app/src/repository/auth_repository.dart';
import 'package:alarm_app/src/repository/http_request.dart';

void main() {
  final httpRequest = Http();
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
