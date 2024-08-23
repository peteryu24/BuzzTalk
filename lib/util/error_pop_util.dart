import 'package:flutter/material.dart';

class ErrorPopUtils {
  final Map<int, String> _errorMessages = {
    0: '성공적인 결과입니다.',
    1: '이미 존재하는 아이디입니다.',
    2: '아이디 형식이 올바르지 않습니다.',
    3: '비밀번호 형식이 올바르지 않습니다.',
    4: '아이디 또는 비밀번호가 입력되지 않았습니다.',
    5: '존재하지 않는 데이터입니다.',
    6: '비밀번호가 틀렸습니다.',
    8: '새로운 비밀번호가 이전 비밀번호와 동일합니다.',
    10: '존재하지 않는 아이디이거나 기존 비밀번호가 틀립니다.',
    12: '방 제목이 중복되었습니다.',
    13: '필수 입력값이 누락되었습니다.',
    14: '방 제목 길이가 50자를 초과했습니다.',
    15: '존재하지 않는 주제입니다.',
    19: '데이터베이스 오류가 발생했습니다.',
    20: '예외가 발생했습니다.',
    999: '방 갯수 조회 실패했습니다.',
  };

  String getErrorMessage(int errorCode) {
    return _errorMessages[errorCode] ?? '알 수 없는 오류가 발생했습니다.';
  }

  void showErrorDialog(BuildContext context, int errorCode) {
    String errorMessage = getErrorMessage(errorCode);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('오류'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
