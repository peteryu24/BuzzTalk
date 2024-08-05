import 'package:alarm_app/model/msg_model.dart';
import 'package:alarm_app/service/device_info_manager.dart';
import 'package:alarm_app/service/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ChatScreen extends StatefulWidget {
  final String roomId;
  final String roomName;

  const ChatScreen({super.key, required this.roomId, required this.roomName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {

}
