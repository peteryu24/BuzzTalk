import 'package:alarm_app/src/service/local_notification_service.dart';
import 'package:alarm_app/src/view/home/my_room/my_room_view.dart';
import 'package:alarm_app/src/view/home/room_list//room_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            context.read<LocalNotificationService>().scheduleNotification(
                  id: 0,
                  title: 'title',
                  body: 'body',
                  scheduledDateTime: DateTime.now().add(Duration(seconds: 8)),
                );
          },
          child: Text('das'),
        ),
      ),
    );
  }
}
