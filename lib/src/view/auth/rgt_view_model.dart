import 'package:flutter/material.dart';
import 'package:alarm_app/src/repository/auth_repository.dart';
import 'package:alarm_app/util/auth_utils.dart';
import 'package:alarm_app/util/error_pop_util.dart';
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
  final AuthUtils _validator = AuthUtils();
  final ErrorPopUtils _errorPopUtil = ErrorPopUtils();
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
    _setLoadingState(true);

    if (!_validateInputs(context)) {
      _setLoadingState(false);
      return;
    }

    try {
      await _authRepository.register(_playerId, _password);
      _handleResponse(context);
    } catch (e) {
      _clearPasswordFields(); // 실패 시 비밀번호 관련 필드를 초기화
      if (e is Exception) {
        _errorPopUtil.showErrorDialog(context, int.parse(e.toString()));
      } else {
        _errorPopUtil.showErrorDialog(context, 20); // 예외 코드
      }
    } finally {
      _setLoadingState(false);
    }
  }

  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool _validateInputs(BuildContext context) {
    if (!_validator.isValidPlayerId(_playerId)) {
      _playerIdError = '아이디 형식이 맞지 않습니다.';
      _clearPasswordFields();
      return false;
    }

    if (!_validator.isValidPassword(_password)) {
      _passwordError = '비밀번호 형식이 맞지 않습니다.';
      _clearPasswordFields();
      return false;
    }

    if (!passwordsMatch()) {
      _errorPopUtil.showErrorDialog(context, 4); // 비밀번호 불일치 코드
      _clearPasswordFields();
      return false;
    }

    return true;
  }

  void _handleResponse(BuildContext context) {
    // 회원가입 성공 시 로그인 화면으로 이동
    _navigateToLogin(context);
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
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
}
