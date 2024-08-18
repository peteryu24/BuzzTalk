import { Body, Controller, Get, Post, Patch, Delete, Query, UseGuards, Request } from '@nestjs/common';
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
    const playerstatus = await this.appService.register(playerId, password);
    switch (playerstatus){
      case 0 :
      {
        return {message:'플레이어가 없거나, 비밀번호가 일치하지 않습니다.'};
      }
      case 1 :
      {
        return {message:'정상적으로 실행이 되었습니다.'};
      }
      case 2 :
      {
        return {message:'에러가 발생하였습니다.'};
      }
      default :
        return {message:'확인되지 않은 오류.'};
    }
  }

  // 로그인 화면을 어떻게 할건지?
  @Post('/player/login')
  async login(@Body() body , @Request() req ): Promise<any> {
    const playerId: string = body.playerId;
    const password: string = body.password;
    
    const playerstatus = await this.appService.login(playerId, password);
    switch (playerstatus){
      case 0 :
      {
        return {message:'플레이어가 없거나, 비밀번호가 일치하지 않습니다.'};
      }
      case playerstatus.player : //성공
      {
        req.session.player = playerstatus;
        return {message:'정상적으로 실행이 되었습니다.'};
      }
      case 2 :
      {
        return {message:'에러가 발생하였습니다.'};
      }
      default :
        return {message:'확인되지 않은 오류.'};
    }
  }

  @Post('/player/logout')
  async logout(@Request() req): Promise<any> {
    req.session.destroy(); // 세션 에서 지우는 메서드
    return { message: '로그아웃 성공' };
  }

  // 비밀번호 변경
  @Patch('/player/change-password')
  async changePassword(@Body() body, @Request() req): Promise<any> {
    if (!req.session.player){
      return { message: '로그인을 하셔야합니다.'};
    }
    
    const playerId: string = body.playerId;
    const oldPassword: string = body.oldPassword;
    const newPassword: string = body.newPassword;
    const playerstatus = await this.appService.changePassword(playerId, oldPassword, newPassword);
    switch (playerstatus){
      case 0 :
      {
        return {message:'플레이어가 없거나, 비밀번호가 일치하지 않습니다.'};
      }
      case 1 :
      {
        return {message:'정상적으로 실행이 되었습니다.'};
      }
      case 2 :
      {
        return {message:'에러가 발생하였습니다.'};
      }
      default :
        return {message:'확인되지 않은 오류.'};
    }
  }

  // 회원 탈퇴
  @Delete('/player/delete')
  async deletePlayer(@Body() body, @Request() req): Promise<any> {
    if (!req.session.player){
      return await { message: '로그인을 하셔야합니다.'};
    }
    const playerId: string = body.playerId;
    const password: string = body.password;
    const playerstatus = await this.appService.deletePlayer(playerId,password);
    switch (playerstatus){
      case 0 :
      {
        return {message:'플레이어가 없거나, 비밀번호가 일치하지 않습니다.'};
      }
      case 1 : //성공
      {
        return {message:'정상적으로 실행이 되었습니다.'};
      }
      case 2 :
      {
        return {message:'에러가 발생하였습니다.'};
      }
      default :
        return {message:'확인되지 않은 오류.'};
    }
  }

  @Get('/topic/list')
  async getTopicList(): Promise<any> {
    return await this.appService.getTopicList();
  }

  @Get('/topic/room-count')
  async getRoomCountByTopic(): Promise<any> {
    return await this.appService.getRoomCountByTopic();
  }

  //삭제예정
  @Post('/player')
  async getOrCreatePlayer(@Body() body): Promise<any> {
    const playerId: string = body.playerId;
    const password: string = body.password;

    return await this.appService.getOrCreatePlayer(playerId,password);
  }

  @Get('/room/list')
  async getRoomList(@Query('topicId') topicId: number | undefined): Promise<any> {
    return await this.appService.getRoomList(topicId);
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
        message:'방 생성 성공'
      };
    } catch (e) {
      console.log('error creating room:',e);
      return {
        message:'방 생성 실패'
      };
    }
  }

  @Get('/room/ids')
  async getRooms(@Body() body: { roomIds: string[] }): Promise<Room[]> {
    const roomIds = body.roomIds;
    return await this.appService.getRoomListByIds(roomIds);
  }
}
