import 'dart:convert';
import 'package:alarm_app/main.dart';
import 'package:alarm_app/src/model/topic_model.dart';
import 'package:alarm_app/src/service/topic_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:alarm_app/src/view/create_room/create_room_view_model.dart';

class CreateRoomView extends StatefulWidget {
  const CreateRoomView({super.key});

  @override
  State<CreateRoomView> createState() => _CreateRoomViewState();
}

class _CreateRoomViewState extends State<CreateRoomView> {
  final TextEditingController _roomNameController = TextEditingController();
  int? _topicId;
  DateTime? _selectedDate;
  TimeOfDay? _startTime;

  @override
  void dispose() {
    _roomNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("방 만들기"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_roomNameController.text.isNotEmpty &&
                  _topicId != null &&
                  _selectedDate != null &&
                  _startTime != null) {
                context.read<CreateRoomViewModel>().setRoomDetails(
                      roomName: _roomNameController.text,
                      topicId: _topicId!,
                      selectedDate: _selectedDate!,
                      startTime: _startTime!,
                    );

                // 예를 들어, 서버에 데이터가 성공적으로 전송된 후 화면을 닫을 수 있습니다.
                Navigator.pop(context, true);
              } else {
                // 모든 필드가 입력되었는지 확인
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("모든 필드를 입력해주세요.")),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _roomNameController,
              decoration: InputDecoration(labelText: "방 이름"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final selectedTopic = await _showTopicSelectionDialog(context);
                if (selectedTopic != null) {
                  setState(() {
                    _topicId = int.parse(selectedTopic);
                  });
                }
              },
              child: Text(_topicId != null ? "토픽 $_topicId 선택됨" : "주제 선택"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final selectedDate = await _selectDate(context);
                if (selectedDate != null) {
                  setState(() {
                    _selectedDate = selectedDate;
                  });
                }
              },
              child: Text(_selectedDate != null
                  ? _selectedDate!.toIso8601String()
                  : "날짜 선택"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final selectedTime = await _selectTime(context);
                if (selectedTime != null) {
                  setState(() {
                    _startTime = selectedTime;
                  });
                }
              },
              child: Text(
                  _startTime != null ? _startTime!.format(context) : "시간 선택"),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _showTopicSelectionDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("주제를 선택하세요."),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop("1"); // 예: 토픽 1의 ID
                },
                child: Text("토픽1"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop("2"); // 예: 토픽 2의 ID
                },
                child: Text("토픽2"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<DateTime?> _selectDate(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }
}
