class RoomModel {
  final int? roomId; // roomId는 선택적
  final String roomName; // roomName은 필수
  final DateTime? startTime; // startTime은 선택적
  final DateTime? endTime; // endTime은 선택적
  final int topicId; // topicId는 필수
  final String playerId; // playerId는 필수
  final DateTime createdAt; // createdAt은 필수
  final DateTime? updatedAt; // updatedAt은 선택적

  RoomModel({
    this.roomId,
    required this.roomName,
    this.startTime,
    this.endTime,
    required this.topicId,
    required this.playerId,
    required this.createdAt,
    this.updatedAt,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      roomId: json['roomId'],
      roomName: json['roomName'],
      startTime:
          json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      topicId: json['topicId'],
      playerId: json['playerId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'roomName': roomName,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'topicId': topicId,
      'playerId': playerId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
