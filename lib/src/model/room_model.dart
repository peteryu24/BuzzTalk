// TODO: 제거 변경
class RoomModel {
  //final int roomId;
  final String roomName;
  final DateTime startTime;
  final DateTime endTime;
  final int topicId;
  final String playerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  RoomModel(
      { //required this.roomId,
      required this.roomName,
      required this.startTime,
      required this.endTime,
      required this.topicId,
      required this.playerId,
      required this.createdAt,
      required this.updatedAt});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      //roomId: json['roomId'],
      roomName: json['roomName'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      topicId: json['topicId'],
      playerId: json['playerId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //'roomId': roomId,
      'roomName': roomName,
      'startTime': startTime,
      'endTime': startTime,
      'topicId': topicId,
      'playerId': playerId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
