import 'package:alarm_app/src/repository/socket_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alarm_app/src/view/chat/chat_view_model.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatViewModel(
        socketRepository: context.read<SocketRepository>(),
        roomModel: context.read<ChatViewModel>().roomModel, // 기존의 RoomModel을 사용
      ),
      child: Consumer<ChatViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(viewModel.roomModel.roomId
                  as String), // ViewModel에서 roomId를 가져옴
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: viewModel.messages.length,
                    itemBuilder: (context, index) {
                      final messageData = viewModel.messages[index];
                      final isMine = messageData['isMine'] as bool;

                      return Align(
                        alignment: isMine
                            ? Alignment.centerRight // 내 메시지는 오른쪽
                            : Alignment.centerLeft, // 상대는 왼쪽
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 10.0,
                          ),
                          decoration: BoxDecoration(
                            color: isMine ? Colors.blue : Colors.grey,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            messageData['message']!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: viewModel.controller,
                          decoration: InputDecoration(
                            hintText: '메시지 입력',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: viewModel.sendMessage,
                        child: const Text('Send'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
