class RoomModel {
  final int? roomId; // roomId는 선택적
  final String roomName; // roomName은 필수
  final int topicId; // topicId는 필수
  final DateTime? selectedTime; // selectedTime은 선택적, 서버에서 처리 가능

  RoomModel({
    this.roomId,
    required this.roomName,
    required this.topicId,
    this.selectedTime,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      roomId: json['roomId'],
      roomName: json['roomName'],
      topicId: json['topicId'],
      selectedTime: json['selectedTime'] != null
          ? DateTime.parse(json['selectedTime'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'roomName': roomName,
      'topicId': topicId,
      'selectedTime': selectedTime?.toIso8601String(),
    };
  }
}
