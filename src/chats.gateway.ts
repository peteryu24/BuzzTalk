import { Logger } from '@nestjs/common';
import {
  MessageBody,
  OnGatewayConnection,
  OnGatewayDisconnect,
  OnGatewayInit,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';

@WebSocketGateway(3001, {
  namespace: 'chat',
  cors: { origin: '*' },
})
export class ChatsGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  connectedClients: { [socketId: string]: boolean } = {};
  clientPlayerId: { [socketId: string]: string } = {};
  roomPlayerIds: { [key: string]: string[] } = {};

  constructor() {}

  @WebSocketServer() server: Server;
  private logger: Logger = new Logger('ChatsGateway');

  getPlayerIds(roomId: string): string[] | undefined {
    return this.roomPlayerIds[roomId];
  }

  afterInit(server: Server) {
    this.logger.log('웹소켓 서버 초기화');
  }

  handleDisconnect(client: Socket) {
    this.logger.log(`Client Disconnected : ${client.id}`);

    if (this.connectedClients[client.id]) {
      delete this.connectedClients[client.id];
    }
  }

  handleConnection(client: Socket, ...args: any[]) {
    this.logger.log(`Client Connected : ${client.id}`);

    if (this.connectedClients[client.id]) {
      client.disconnect(true);
      return;
    }

    this.connectedClients[client.id] = true;
  }

  @SubscribeMessage('join')
  handleJoin(client: Socket, data: { roomId: string; playerId: string }): void {
    const room = data.roomId;
    const playerId = data.playerId;

    this.clientPlayerId[client.id] = playerId;

    // 이미 접속한 방인지 확인
    if (client.rooms.has(room)) {
      return;
    }

    client.join(room);

    if (!this.roomPlayerIds[room]) {
      this.roomPlayerIds[room] = [];
    }
  }

  @SubscribeMessage('exit')
  handleExit(client: Socket, data: { roomId: string }): void {
    const room = data.roomId;
    // 방에 접속되어 있지 않은 경우는 무시
    if (!client.rooms.has(room)) {
      return;
    }

    client.leave(room);
  }

  @SubscribeMessage('getUserList')
  handleGetUserList(client: Socket, room: string): void {
    this.server
      .to(room)
      .emit('userList', { room, userList: this.roomPlayerIds[room] });
  }

  @SubscribeMessage('msg')
  handleChatMessage(
    client: Socket,
    data: { roomId: string; msg: string; playerId: string },
  ): void {
    this.server.to(data.roomId).emit('msg', {
      playerId: this.clientPlayerId[client.id],
      msg: data.msg,
      roomId: data.roomId,
    });
  }
}
