import 'package:alarm_app/route.dart';
import 'package:alarm_app/service/device_info_manager.dart';
import 'package:alarm_app/service/local_notification_manager.dart';
import 'package:alarm_app/service/my_room_manager.dart';
import 'package:alarm_app/service/my_room_notifier.dart';
import 'package:alarm_app/service/topic_manager.dart';
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
