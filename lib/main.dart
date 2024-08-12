import 'package:alarm_app/util/helper/route.dart';
import 'package:alarm_app/service/device_info_service.dart';
import 'package:alarm_app/service/local_notification_service.dart';
import 'package:alarm_app/service/my_room_service.dart';
import 'package:alarm_app/service/my_room_view_model.dart';
import 'package:alarm_app/service/topic_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String serverUrl = 'http://IP:3000';
String serverWsUrl = 'http://IP/chat';

late SharedPreferences prefs;

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
}
