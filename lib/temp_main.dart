import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alarm_app/src/view/create_room/create_room_view.dart';
import 'package:alarm_app/src/view/create_room/create_room_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CreateRoomViewModel()),
      ],
      child: MaterialApp(
        home: CreateRoomView(),
      ),
    ),
  );
}
