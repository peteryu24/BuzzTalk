import 'dart:convert';

import 'package:alarm_app/main.dart';
import 'package:alarm_app/model/room_model.dart';
import 'package:alarm_app/service/local_notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyRoomViewModel extends ChangeNotifier {}
