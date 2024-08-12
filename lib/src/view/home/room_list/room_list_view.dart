import 'package:alarm_app/model/room_model.dart';
import 'package:alarm_app/service/my_room_service.dart';
import 'package:alarm_app/service/my_room_view_model.dart';
import 'package:alarm_app/service/room_list_view_model.dart';
import 'package:alarm_app/widgets/infinite_scroll_mixin.dart';
import 'package:alarm_app/widgets/room_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoomListView extends StatefulWidget {
  const RoomListView({super.key});

  @override
  State<RoomListView> createState() => _RoomListViewState();
}

class _RoomListViewState extends State<RoomListView>
    with InfiniteScrollMixin, WidgetsBindingObserver {}
