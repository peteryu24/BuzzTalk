import 'package:alarm_app/service/my_room_service.dart';
import 'package:alarm_app/service/my_room_view_model.dart';
import 'package:alarm_app/widgets/room_item.dart';
import 'package:flutter/material.dart';

class MyRoomView extends StatefulWidget {
  const MyRoomView({super.key});

  @override
  State<MyRoomView> createState() => _MyRoomViewState();
}

class _MyRoomViewState extends State<MyRoomView> with WidgetsBindingObserver {}
