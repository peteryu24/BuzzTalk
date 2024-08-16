import 'package:alarm_app/src/view/chat/chat_view.dart';
import 'package:alarm_app/util/helper/route.dart';
import 'package:alarm_app/src/service/local_notification_service.dart';
import 'package:alarm_app/src/service/my_room_service.dart';
import 'package:alarm_app/src/service/topic_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

String serverUrl = 'http://IP:3000';
String serverWsUrl = 'http://IP/chat';

late SharedPreferences prefs;

void main() async {
  tz.initializeTimeZones();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => LocalNotificationService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ,
    );
  }
}
