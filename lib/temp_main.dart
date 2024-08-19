import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alarm_app/src/view/create_room/create_room_view.dart';
import 'package:alarm_app/src/view/create_room/create_room_view_model.dart';
import 'package:alarm_app/src/repository/room_repository.dart';
import 'package:alarm_app/src/repository/http_request.dart';

void main() {
  final httpRequest = Http(); // Http 객체 생성
  final roomRepository = RoomRepository(httpRequest); // RoomRepository 객체 생성

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              CreateRoomViewModel(roomRepository), // CreateRoomViewModel 등록
        ),
      ],
      child: MaterialApp(
        home: CreateRoomView(), // 초기 화면을 CreateRoomView로 설정
      ),
    ),
  );
}
