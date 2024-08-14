import { Body, Controller, Get, Post, Patch, Delete, Query } from '@nestjs/common';
import { AppService } from './app.service';
import { Room } from './dto/room.entity';
@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}


  // 회원가입
  @Post('/player/register')
  async register(@Body() body): Promise<any> {
    const playerId: string = body.playerId;
    const password: string = body.password;
    return await this.appService.register(playerId, password);
  }

  // 로그인 화면을 어떻게 할건지?
  @Post('/player/login')
  async login(@Body() body): Promise<any> {
    const playerId: string = body.playerId;
    const password: string = body.password;
    //if(body.playerId().length)?
    return await this.appService.login(playerId, password);
  }

  // 비밀번호 변경
  @Patch('/player/change-password')
  async changePassword(@Body() body): Promise<void> {
    const playerId: string = body.playerId;
    const oldPassword: string = body.oldPassword;
    const newPassword: string = body.newPassword;
    return await this.appService.changePassword(playerId, oldPassword, newPassword);
  }

  // 회원 탈퇴
  @Delete('/player/delete')
  async deletePlayer(@Body() body): Promise<void> {
    const playerId: string = body.playerId;
    const password: string = body.password;
    return await this.appService.deletePlayer(playerId,password);
  }

  @Get('/topic/list')
  async getTopicList(): Promise<any> {
    return await this.appService.getTopicList();
  }

  @Get('/topic/room-count')
  async getRoomCountByTopic(): Promise<any> {
    return await this.appService.getRoomCountByTopic();
  }

  @Post('/player')
  async getOrCreatePlayer(@Body() body): Promise<any> {
    const playerId: string = body.playerId;
    const password: string = body.password;

    return await this.appService.getOrCreatePlayer(playerId,password);
  }

  @Post('/room/list')
  async getRoomList(@Body() body): Promise<any> {
    const limit: number = body.limit;
    const cursorId: string | undefined = body.cursorId;
    const topicId: number | undefined = body.topicId;

    return await this.appService.getRoomList(topicId, cursorId, limit);
  }

  @Post('/room/create')
  async createRoom(@Body() body): Promise<any> {
    const roomName: string = body.roomName;
    const topicId: number = body.topicId;
    const playerId: string = body.playerId;
    const startTime: Date = new Date(body.startTime);
    const endTime: Date = new Date(body.endTime);

    try {
      await this.appService.createRoom(
        roomName,
        topicId,
        playerId,
        startTime,
        endTime,
      );
      return {
        success: true,
      };
    } catch (e) {
      return {
        success: false,
      };
    }
  }

  @Post('/room/ids')
  async getRooms(@Body() body: { roomIds: string[] }): Promise<Room[]> {
    const roomIds = body.roomIds;
    return await this.appService.getRoomListByIds(roomIds);
  }
}
