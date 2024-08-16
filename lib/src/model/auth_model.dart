class AuthModel {
  final String player_id;
  final String password;

  AuthModel({
    required this.player_id,
    required this.password,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      player_id: json['player_id'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player_id': player_id,
      'password': password,
    };
  }
}
