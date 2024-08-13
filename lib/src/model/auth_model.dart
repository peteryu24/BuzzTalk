class UserModel {
  String player_id;
  String password;

  UserModel({required this.player_id, required this.password});

  // TODO: 로그인 로직
  Future<bool> signIn() async {
    return true;
  }

  // TODO: 회원가입 로직
  Future<bool> signUp() async {
    return true;
  }

  // TODO: 비밀번호 변경 로직
  Future<bool> resetPassword(String email) async {
    return true;
  }
}
