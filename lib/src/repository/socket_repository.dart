import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketRepository {
  late IO.Socket _socket;

  void initializeSocket(
      {required String roomId, required Function(String) onMessageReceived}) {
    _socket = IO.io(
        'http://localhost:3001/chat',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setQuery({'roomId': roomId})
            .build());

    _socket.onConnect((_) {
      print('Connected to server');
      _socket.emit('join', {'roomId': roomId, 'playerId': 'uniquePlayerId'});
    });

    _socket.onDisconnect((_) {
      print('Disconnected from server');
    });

    _socket.on('msg', (data) {
      onMessageReceived(data['msg']);
    });

    _socket.connect();
  }

  void sendMessage(String roomId, String message) {
    _socket.emit('msg',
        {'roomId': roomId, 'msg': message, 'playerId': 'uniquePlayerId'});
  }

  void dispose() {
    _socket.dispose();
  }
}
