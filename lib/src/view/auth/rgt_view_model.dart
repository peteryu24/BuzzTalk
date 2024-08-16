/*
1순위: 아이디 형식 불일치
2순위: 비밀번호 형식 불일치
3순위: 비밀번호 & 비밀번호 검증 불일치

영어 소문자와 숫자만 포함된 패턴, 최소 3자 이상, 최대 15자 이하
최소 8자, 대문자, 소문자, 숫자, 특수문자를 각각 최소 하나씩 포함
*/
import 'package:flutter/material.dart';
import 'package:alarm_app/src/repository/auth_repository.dart';
import 'package:alarm_app/util/auth_utils.dart';
import 'package:alarm_app/src/view/auth/login_view.dart';

class RgtViewModel extends ChangeNotifier {
  String _playerId = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isLoading = false;
  bool _obscureText = true;
  bool _obscureConfirmText = true;

  String? _playerIdError;
  String? _passwordError;

  final AuthRepository _authRepository;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _validator = AuthUtils();

  RgtViewModel(this._authRepository);

  String get playerId => _playerId;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  bool get isLoading => _isLoading;
  bool get obscureText => _obscureText;
  bool get obscureConfirmText => _obscureConfirmText;

  String? get playerIdError => _playerIdError;
  String? get passwordError => _passwordError;

  void updatePlayerId(String playerId) {
    _playerId = playerId;
    _playerIdError = null;
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password;
    _passwordError = null;
    notifyListeners();
  }

  void updateConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  void toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  void toggleObscureConfirmText() {
    _obscureConfirmText = !_obscureConfirmText;
    notifyListeners();
  }

  bool passwordsMatch() {
    return _password == _confirmPassword;
  }

  Future<void> signUp(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    // 1순위: 아이디 형식 체크
    if (!_validator.isValidPlayerId(_playerId)) {
      _isLoading = false;
      _playerIdError = '아이디 형식이 맞지 않습니다.';
      _clearPasswordFields(); // 비밀번호 필드 초기화
      notifyListeners();
      return;
    }

    // 2순위: 비밀번호 형식 체크
    if (!_validator.isValidPassword(_password)) {
      _isLoading = false;
      _passwordError = '비밀번호 형식이 맞지 않습니다.';
      _clearPasswordFields(); // 비밀번호 필드 초기화
      notifyListeners();
      return;
    }

    // 3순위: 비밀번호 일치 체크
    if (!passwordsMatch()) {
      _isLoading = false;
      notifyListeners();
      _clearPasswordFields();
      _showErrorDialog(context, '비밀번호 불일치', '다시 시도하세요');
      return;
    }

    try {
      await _authRepository.register(_playerId, _password);
      // 회원가입 성공 시 로그인 화면으로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } catch (e) {
      _showErrorDialog(context, '회원가입 실패', '다시 시도하세요');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _clearPasswordFields() {
    // 텍스트 필드를 비워서 초기화
    passwordController.clear(); // Password 입력 필드 초기화
    confirmPasswordController.clear(); // Confirm Password 입력 필드 초기화
    _password = '';
    _confirmPassword = '';
    _obscureText = true; // 비밀번호 필드를 다시 숨김 상태로
    _obscureConfirmText = true; // 비밀번호 확인 필드를 다시 숨김 상태로
    notifyListeners();
  }

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
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
