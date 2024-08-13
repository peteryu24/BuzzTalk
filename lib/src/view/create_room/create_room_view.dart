import 'dart:convert';

import 'package:alarm_app/main.dart';
import 'package:alarm_app/model/topic_model.dart';
import 'package:alarm_app/service/device_info_service.dart';
import 'package:alarm_app/service/topic_service.dart';
import 'package:alarm_app/widgets/screen/topic_filter_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class CreateRoomView extends StatefulWidget {
  const CreateRoomView({super.key});

  @override
  State<CreateRoomView> createState() => _CreateRoomViewState();
}

class _CreateRoomViewState extends State<CreateRoomView> {}