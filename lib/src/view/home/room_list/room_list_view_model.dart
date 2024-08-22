import 'dart:convert';

import 'package:alarm_app/main.dart';
import 'package:alarm_app/src/repository/room_repository.dart';
import 'package:alarm_app/src/repository/shared_preferences_repository.dart';
import 'package:alarm_app/src/service/local_notification_service.dart';
import 'package:alarm_app/src/view/base_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:alarm_app/src/model/room_model.dart';
import 'package:flutter/cupertino.dart';

class RoomListViewModel extends BaseViewModel {
  final RoomRepository roomRepository;
  final LocalNotificationService localNotificationService;
  final SharedPreferencesRepository sharedPreferencesRepository;

  List<RoomModel> roomList = []; // 방 목록을 저장할 리스트
  bool isLoading = false; // 로딩 상태 관리

  RoomListViewModel(
      {required this.roomRepository,
      required this.localNotificationService,
      required this.sharedPreferencesRepository});

  // 서버에서 방 목록을 가져오는 메서드
  Future<void> roomListFetch(List<int?>? topicIDList,
      {bool refresh = false}) async {
    isLoading = true;
    notifyListeners(); // 로딩 중 상태를 UI에 반영

    if (refresh) {
      // 새로고침인 경우 기존 데이터를 초기화
      roomList = [];
    }

    try {
      roomList =
          await roomRepository.getRoomList(topicIDList); // 서버에서 방 목록 가져오기

      // 방 목록을 가져온 후 각 방에 대한 예약 정보를 로컬에서 조회하여 설정
      for (RoomModel room in roomList) {
        bool isReserved = sharedPreferencesRepository.isReserved(room);
        print('방 ${room.roomId} 예약 상태: $isReserved'); // 예약 여부 출력 (디버그용)
        room.book = isReserved;
      }
    } catch (e) {
      // 오류 처리
      print("방 목록 가져오기 실패: $e");
    } finally {
      isLoading = false;
      notifyListeners(); // 데이터 로딩이 끝났음을 UI에 알림
    }
  }

  void bookScheduleChat(RoomModel room) {
    localNotificationService.scheduleNotification(
        id: room.roomId!,
        title: room.roomName,
        body: '채팅이 시작되었습니다.',
        scheduledDateTime: room.startTime!,
        payload: room.roomId.toString());

    sharedPreferencesRepository.saveReservation(room);
    notifyListeners();
  }

  void cancelScheduleChat(RoomModel room) {
    localNotificationService.cancelNotification(room.roomId!);
    sharedPreferencesRepository.removeReservation(room);
    notifyListeners();
  }
}
