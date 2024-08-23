import 'package:flutter/material.dart';
import 'package:alarm_app/src/model/room_model.dart';
import 'package:alarm_app/src/repository/room_repository.dart';
import 'package:alarm_app/util/error_pop_util.dart';

class CreateRoomViewModel extends ChangeNotifier {
  final RoomRepository _roomRepository;
  final ErrorPopUtils _errorPopUtil = ErrorPopUtils();
  bool _isLoading = false;
  List<Map<String, dynamic>> _topics = []; // 추가: topics 데이터 저장용

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get topics => _topics;

  CreateRoomViewModel(this._roomRepository);

  Future<void> fetchTopics() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Assuming getTopicList returns a list of topics
      _topics = await _roomRepository.getTopicList();
    } catch (e) {
      // Handle error
      // Example: print or log error, show a general error message
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createRoom({
    required String roomName,
    required int topicId,
    DateTime? startTime,
    required DateTime endTime,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    RoomModel roomModel = RoomModel(
      roomName: roomName,
      topicId: topicId,
      startTime: startTime,
      endTime: endTime,
    );

    try {
      final response = await _roomRepository.createRoom(roomModel);

      if (response['result'] == true) {
        print("Room Created Successfully.");
        if (context.mounted) {
          Navigator.of(context)
              .pushReplacementNamed('/'); // Home screen navigation
        }
      } else {
        int errorCode = response['errNum'] ?? 20; // Default to 20 if not found
        if (context.mounted) {
          _errorPopUtil.showErrorDialog(context, errorCode);
        }
      }
    } catch (e) {
      if (context.mounted) {
        _errorPopUtil.showErrorDialog(context, 20); // General error
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
