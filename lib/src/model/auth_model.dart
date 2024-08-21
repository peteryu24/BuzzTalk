class AuthModel {
  String playerId;
  String password;

  AuthModel({
    required this.playerId,
    required this.password,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      playerId: json['playerId'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'playerId': playerId,
      'password': password,
    };
  }

  // AuthModel의 필드를 업데이트하는 메서드
  void update(AuthModel newAuthData) {
    playerId = newAuthData.playerId;
    password = newAuthData.password;
  }
}
