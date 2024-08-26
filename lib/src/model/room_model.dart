class RoomModel {
  final int? roomId;
  final String roomName;
  final DateTime? startTime;
  final DateTime endTime;
  final int topicId;
  final String? playerId;
  bool book;
  final DateTime? updatedAt;

  RoomModel({
    this.roomId,
    required this.roomName,
    this.startTime,
    required this.endTime,
    required this.topicId,
    this.playerId,
    this.book = false, // 기본값 false
    this.updatedAt,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      roomId: json['roomId'],
      roomName: json['roomName'],
      startTime:
          json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      endTime: DateTime.parse(json['endTime']),
      topicId: json['topicId'],
      playerId: json['playerId'],
      book: json['book'] ?? false,
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'roomName': roomName,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'topicId': topicId,
      'playerId': playerId,
      'book': book,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
