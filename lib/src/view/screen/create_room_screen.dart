import 'dart:convert';

import 'package:alarm_app/main.dart';
import 'package:alarm_app/model/topic_model.dart';
import 'package:alarm_app/service/device_info_manager.dart';
import 'package:alarm_app/service/topic_manager.dart';
import 'package:alarm_app/widgets/screen/topic_filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {

}
