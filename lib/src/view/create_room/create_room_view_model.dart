import 'package:flutter/material.dart';
import 'package:alarm_app/src/model/room_model.dart';
import 'package:alarm_app/src/repository/room_repository.dart';
import 'package:alarm_app/util/error_pop_util.dart';
import 'package:go_router/go_router.dart';

class CreateRoomViewModel extends ChangeNotifier {
  final RoomRepository _roomRepository;
  final ErrorPopUtils _errorPopUtil = ErrorPopUtils();

  bool _isLoading = false;
  String? _errorMessage;
  List<Map<String, dynamic>> _topics = [];

  CreateRoomViewModel(this._roomRepository);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Map<String, dynamic>> get topics => _topics;

  Future<void> fetchTopics([BuildContext? context]) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _topics = await _roomRepository.getTopicList();
      _isLoading = false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to fetch topics: $e';
    }
    notifyListeners();
  }

  Future<void> createRoom({
    required String roomName,
    required int topicId,
    DateTime? startTime,
    required DateTime endTime,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _errorMessage = null;
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
        context.replace('/'); // 홈 화면으로 이동
      } else {
        int errorCode = response['errNum'] ?? 20; // Default to 20 if not found
        _errorPopUtil.showErrorDialog(context, errorCode);
      }
    } catch (e) {
      _errorPopUtil.showErrorDialog(context, 20); // General error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
