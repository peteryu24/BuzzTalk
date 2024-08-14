// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:alarm_app/src/view/chat/chat_view_model.dart';
// import 'package:alarm_app/src/repository/socket_repository.dart';

// class ChatView extends StatelessWidget {
//   final String roomId; // 방 ID
//   final String playerId; // 플레이어 ID

//   const ChatView({
//     super.key,
//     required this.roomId,
//     required this.playerId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => ChatViewModel(
//         //ChatViewModel이 생성될 때 소켓 연결, 방 참가 로직 실행
//         socketRepository: context.read<SocketRepository>(),
//         roomModel: roomModel,
//       ),
//       child: Consumer<ChatViewModel>(
//         builder: (context, viewModel, child) {
//           return Scaffold(
//             appBar: AppBar(
//               centerTitle: true,
//               title: Text(viewModel.roomId),
//             ),
//             body: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     reverse: true,
//                     itemCount: viewModel.messages.length,
//                     itemBuilder: (context, index) {
//                       final messageData = viewModel.messages[index];

//                       //내 id와   messageData['playerId']이 같은지 확인 후 true라면 내 메시지 false라면 상대 메시지
//                       final isMine = messageData['isMine'] as bool;
//                       return Align(
//                         alignment: isMine
//                             ? Alignment.centerRight //상대는 왼쪽
//                             : Alignment.centerLeft, //내 메시지는 오른쪽
//                         child: Container(
//                           padding: const EdgeInsets.all(10.0),
//                           margin: const EdgeInsets.symmetric(
//                             vertical: 5.0,
//                             horizontal: 10.0,
//                           ),
//                           decoration: BoxDecoration(
//                             color: isMine ? Colors.blue : Colors.grey,
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           child: Text(
//                             messageData['message']!,
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: viewModel.controller,
//                           decoration: InputDecoration(
//                             hintText: '메시지 입력',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       ElevatedButton(
//                         onPressed: viewModel.sendMessage,
//                         child: const Text('Send'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alarm_app/src/view/chat/chat_view_model.dart';
import 'package:alarm_app/src/repository/socket_repository.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatViewModel(
        //ChatViewModel이 생성될 때 소켓 연결, 방 참가 로직 실행
        socketRepository: context.read<SocketRepository>(),
        roomModel: context.read<ChatViewModel>().roomModel,
      ),
      child: Consumer<ChatViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(viewModel.roomModel.roomId), //viewModel의 roomID
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

                      //내 id와   messageData['playerId']이 같은지 확인 후 true라면 내 메시지 false라면 상대 메시지
                      final isMine = messageData['isMine'] as bool;
                      return Align(
                        alignment: isMine
                            ? Alignment.centerRight //상대는 왼쪽
                            : Alignment.centerLeft, //내 메시지는 오른쪽
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
