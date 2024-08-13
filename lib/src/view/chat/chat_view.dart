import 'package:alarm_app/src/model/msg_model.dart';
import 'package:alarm_app/src/repository/socket_repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ChatView extends StatefulWidget {
  final String roomId;
  final String roomName;

  const ChatView({super.key, required this.roomId, required this.roomName});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
