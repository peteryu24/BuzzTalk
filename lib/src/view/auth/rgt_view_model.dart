import 'package:flutter/material.dart';
import 'package:alarm_app/src/repository/auth_repository.dart';
import 'package:alarm_app/src/view/auth/login_view.dart';
import 'package:alarm_app/util/auth_utils.dart'; // AuthUtils 임포트

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
  final AuthUtils _validator = AuthUtils(); // AuthUtils 인스턴스 추가
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
      _clearPasswordFields();
      notifyListeners();
      return;
    }

    // 2순위: 비밀번호 형식 체크
    if (!_validator.isValidPassword(_password)) {
      _isLoading = false;
      _passwordError = '비밀번호 형식이 맞지 않습니다.';
      _clearPasswordFields();
      notifyListeners();
      return;
    }

    // 3순위: 비밀번호 일치 체크
    if (!passwordsMatch()) {
      _isLoading = false;
      _clearPasswordFields();
      _showErrorDialog(context, '비밀번호 불일치', '다시 시도하세요');
      notifyListeners();
      return;
    }

    try {
      final response = await _authRepository.register(_playerId, _password);

      if (response['status'] == 'success') {
        // 회원가입 성공 시 로그인 화면으로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else if (response['status'] == 'fail') {
        // fail 상태일 때 에러 메시지 표시
        _showErrorDialog(context, '회원가입 실패', response['error']);
      } else if (response['status'] == 'error') {
        // error 상태일 때 일반 에러 메시지 표시
        _showErrorDialog(context, '회원가입 실패', '잠시 후 다시 시도해주세요.');
      }
    } catch (e) {
      _showErrorDialog(context, '회원가입 실패', '잠시 후 다시 시도해주세요.');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _clearPasswordFields() {
    passwordController.clear();
    confirmPasswordController.clear();
    _password = '';
    _confirmPassword = '';
    _obscureText = true;
    _obscureConfirmText = true;
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
