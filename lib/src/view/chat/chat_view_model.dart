import 'package:alarm_app/src/model/auth_model.dart';
import 'package:alarm_app/src/repository/socket_repository.dart';
import 'package:alarm_app/src/view/base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:alarm_app/src/model/room_model.dart';

class ChatViewModel extends BaseViewModel {
  final SocketRepository socketRepository;
  final RoomModel roomModel;
  final AuthModel authModel;
  List<Map<String, dynamic>> messages = [];
  final ScrollController scrollController =
      ScrollController(); // ScrollController 추가
  final TextEditingController controller = TextEditingController();

  ChatViewModel({
    required this.socketRepository,
    required this.roomModel,
    required this.authModel,
  }) {
    socketRepository.initSocket(authModel);
    socketRepository.joinRoom(roomModel.roomId!, authModel.playerId);

    socketRepository.socket.on('msg', (data) {
      final senderId = data['playerId'];
      final message = data['msg'];

      // 메시지 수신 시 나와 상대방의 메시지를 구분
      addMessage(message, senderId);
    });
  }

  void addMessage(String message, String senderId) {
    bool isMine = senderId == authModel.playerId;
    messages.insert(
        0, {'message': message, 'playerId': senderId, 'isMine': isMine});
    notifyListeners();

    //채팅 오면 맨 아래에
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        // scrollController가 연결되어 있는지 확인
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // 메시지 전송 메서드
  void sendMessage() {
    if (controller.text.isNotEmpty) {
      final message = controller.text;
      socketRepository.sendMessage(
          roomModel.roomId!, message, authModel.playerId);

      controller.clear();
    }
  }

  void exitRoom() {
    socketRepository.exitRoom(roomModel.roomId!);
    notifyListeners();
  }

  @override
  void dispose() {
    socketRepository.dispose();
    controller.dispose();
    scrollController.dispose(); // ScrollController 정리
    super.dispose();
  }
}
