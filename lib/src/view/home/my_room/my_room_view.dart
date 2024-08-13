import 'package:alarm_app/src/service/my_room_service.dart';
import 'package:alarm_app/src/view/base_view.dart';
import 'package:alarm_app/src/view/home/my_room/my_room_view_model.dart';
import 'package:alarm_app/src/view/home/room_item.dart';
import 'package:flutter/material.dart';

class MyRoomView extends StatelessWidget {
  const MyRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: MyRoomViewModel(),
      builder: (context, viewModel) => Scaffold(),
    );
  }
}
