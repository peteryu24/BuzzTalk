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
    return playerstatus;
    // 1: 성공
    // 2: 아이디 중복
    // 3: 아이디 형식 불일치
    // 4: 비밀번호 형식 불일치
    // 6: Id 또는 pw 입력값 없이 들어왔을 경우
    // 7: DB 에러
    // 8: 서버 에러
  } 

  // 로그인 화면을 어떻게 할건지?
  @Post('/player/login')
  async login(@Body() body , @Request() req ): Promise<any> {
    const playerId: string = body.playerId;
    const password: string = body.password;
    
    const playerstatus = await this.appService.login(playerId, password);
    if(playerstatus == playerstatus.player)
    {
      req.session.player = playerstatus;
      return 1;
    }
    else
    {
      return playerstatus;
    }
    // 2: 없는 아이디
    // 3: 아이디 형식 불일치
    // 4: 비밀번호 형식 불일치
    // 5: 비밀번호 틀림
    // 6: Id 또는 pw 입력값 없이 들어왔을 경우
    // 8: 서버 에러
  }

  @Post('/player/logout')
  async logout(@Request() req): Promise<any> {
    req.session.destroy(); // 세션 에서 지우는 메서드
    return 1;//로그아웃 성공
  }

  // 비밀번호 변경
  @Patch('/player/change-password')
  async changePassword(@Body() body, @Request() req): Promise<any> {
    if (!req.session.player){
      return 0;//로그인을 먼저 해야함
    }
    
    const playerId: string = body.playerId;
    const oldPassword: string = body.oldPassword;
    const newPassword: string = body.newPassword;
    const playerstatus = await this.appService.changePassword(playerId, oldPassword, newPassword);
    return playerstatus;
    // 1: 성공
    // 2: 비밀번호 미변경 (이전 비밀번호와 일치)
    // 3: 새로운 비밀번호 형식 불일치
    // 4: 기존 비밀번호가 틀림
    // 6: 입력값 없을 경우
    // 7: DB 에러
    // 8: 서버 에러
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
    return playerstatus;
    //0:플레이어가 없거나 비밀번호가 일치하지 않음 1:성공 7: DB 에러
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

    const playerstatus = await this.appService.createRoom(
        roomName,
        topicId,
        playerId,
        startTime,
        endTime,
      );
    return playerstatus;
    // 1: 성공
    // 2: 방 제목 중복
    // 3: 존재하지 않는 플레이어
    // 4: 존재하지 않는 토픽
    // 5: 길이 초과
    // 6: 클라이언트측 입력값 누락
    // 7: DB 에러
    // 8: 서버 에러
      
  }

  @Get('/room/ids')
  async getRooms(@Body() body: { roomIds: string[] }): Promise<Room[]> {
    const roomIds = body.roomIds;
    return await this.appService.getRoomListByIds(roomIds);
  }
}
