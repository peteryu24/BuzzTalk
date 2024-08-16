class RoomModel {
  final int roomId;
  final String roomName;
  final DateTime startTime;
  final DateTime endTime;
  final int topicId;
  final String playerId;
  final bool book;
  final DateTime createdAt;
  final DateTime updatedAt;

  RoomModel(
      {required this.roomId,
      required this.roomName,
      required this.startTime,
      required this.endTime,
      required this.topicId,
      required this.playerId,
      required this.book,
      required this.createdAt,
      required this.updatedAt});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      roomId: json['room_id'],
      roomName: json['room_name'],
      startTime: DateTime.parse(json['start_time']), // Parsing DateTime
      endTime: DateTime.parse(json['end_time']), // Parsing DateTime
      topicId: json['topic_id'],
      playerId: json['player_id'],
      book: json['book'],
      createdAt: DateTime.parse(json['created_at']), // Parsing DateTime
      updatedAt: DateTime.parse(json['updated_at']), // Parsing DateTime
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'roomName': roomName,
      'startTime': startTime.toIso8601String(), // Converting DateTime to String
      'endTime': endTime.toIso8601String(), // Converting DateTime to String
      'topicId': topicId,
      'playerId': playerId,
      'book': book,
      'createdAt': createdAt.toIso8601String(), // Converting DateTime to String
      'updatedAt': updatedAt.toIso8601String(), // Converting DateTime to String
    };
  }
}
