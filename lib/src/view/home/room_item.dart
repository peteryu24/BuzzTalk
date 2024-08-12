import 'package:alarm_app/model/room_model.dart';
import 'package:alarm_app/service/my_room_service.dart';
import 'package:alarm_app/service/topic_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoomItem extends StatelessWidget {
  final RoomModel room;

  const RoomItem({super.key, required this.room});
}
