import 'package:flutter/material.dart';
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
  DateTime? _startTime;
  DateTime? _endTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CreateRoomViewModel>().fetchTopics();
    });
  }

  @override
  void dispose() {
    _roomNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("방 만들기"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<CreateRoomViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                children: [
                  if (viewModel.isLoading) const CircularProgressIndicator(),
                  TextField(
                    controller: _roomNameController,
                    decoration: InputDecoration(
                      labelText: "방 이름",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 20, 42, 128),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          hint: const Text(
                            "주제를 선택하세요",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: _topicId,
                          onChanged: (value) {
                            setState(() {
                              _topicId = value;
                            });
                          },
                          items: viewModel.topics.map((topic) {
                            return DropdownMenuItem<int>(
                              value: topic['topicId'],
                              child: Text(
                                topic['topicName'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                          isExpanded: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () async {
                      final selectedStartTime = await _selectDateTime(context);
                      if (selectedStartTime != null) {
                        setState(() {
                          _startTime = selectedStartTime;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 20, 42, 128),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: Text(
                      _startTime != null
                          ? "시작 시간: ${_startTime!.toIso8601String()}"
                          : "시작 시간 선택",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final selectedEndTime = await _selectDateTime(context);
                      if (selectedEndTime != null) {
                        setState(() {
                          _endTime = selectedEndTime;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 20, 42, 128),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: Text(
                      _endTime != null
                          ? "종료 시간: ${_endTime!.toIso8601String()}"
                          : "종료 시간 선택",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 370),
                  ElevatedButton(
                    onPressed: () {
                      if (_roomNameController.text.isNotEmpty &&
                          _topicId != null &&
                          _endTime != null) {
                        context.read<CreateRoomViewModel>().createRoom(
                              roomName: _roomNameController.text,
                              topicId: _topicId!,
                              startTime: _startTime,
                              endTime: _endTime!,
                              context: context,
                            );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("모든 필드를 입력해주세요.")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 20, 42, 128),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: const Text(
                      "방 생성하기",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _selectDateTime(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 20, 42, 128),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 20, 42, 128),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        return DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      }
    }
    return null;
  }
}
