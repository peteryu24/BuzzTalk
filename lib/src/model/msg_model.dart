class MsgModel {
  final String playerId;
  final String password;
//여기 패스워드는 나중에 지울거
  MsgModel({
    required this.playerId,
    required this.password,
  });

  factory MsgModel.fromJson(Map<String, dynamic> json) {
    return MsgModel(
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
}
