import 'package:alarm_app/src/model/room_model.dart';
import 'package:alarm_app/src/service/my_room_service.dart';
import 'package:alarm_app/src/view/base_view.dart';
import 'package:alarm_app/src/view/home/room_list/room_list_view_model.dart';
import 'package:alarm_app/util/helper/infinite_scroll_mixin.dart';
import 'package:alarm_app/src/view/home/room_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoomListView extends StatelessWidget {
  const RoomListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: RoomListViewModel(),
        builder: (context, viewModel) => Scaffold(
              body: Center(
                child: Text('홈'),
              ),
            ));
  }
}
