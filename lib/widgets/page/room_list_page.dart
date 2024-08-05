import 'package:alarm_app/model/room_model.dart';
import 'package:alarm_app/service/my_room_manager.dart';
import 'package:alarm_app/service/my_room_notifier.dart';
import 'package:alarm_app/service/room_list_notifier.dart';
import 'package:alarm_app/widgets/infinite_scroll_mixin.dart';
import 'package:alarm_app/widgets/room_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoomListPage extends StatefulWidget {
  const RoomListPage({super.key});

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> with InfiniteScrollMixin, WidgetsBindingObserver {

}
