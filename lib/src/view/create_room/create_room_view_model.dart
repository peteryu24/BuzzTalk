import 'package:flutter/material.dart';
import 'package:alarm_app/src/model/room_model.dart';
import 'package:alarm_app/src/service/create_room_service.dart';

class CreateRoomViewModel extends ChangeNotifier {
  final RoomService _roomService = RoomService();

  Future<void> setRoomDetails({
    required String roomName,
    required int topicId,
    required DateTime selectedDate,
    required TimeOfDay startTime,
  }) async {
    RoomModel roomModel = RoomModel(
      roomName: roomName,
      topicId: topicId,
      selectedDate: selectedDate,
      startTime: startTime,
    );

    try {
      await _roomService.submitRoomDetails(roomModel);
      // 성공
      print("Room Created.");
    } catch (e) {
      // 실패
      print("Failed: $e");
    }
  }
}
