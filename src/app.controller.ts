import { Body, Controller, Get, Post, Patch, Delete, Query, UseGuards, Request as Req , Response as Res} from '@nestjs/common';
import { AppService } from './app.service';
import { Room } from './dto/room.entity';
import { Logger } from '@nestjs/common';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  // 회원가입
  @Post('/player/register')
  async register(@Body() body): Promise<any> {
    Logger.log('Register endpoint hit'); 
    try {
      const playerId: string = body.playerId;
      const password: string = body.password;
      const statusCode = await this.appService.register(playerId, password);
      
      if (statusCode === 1) {
        return {
          status: 'success',
          data: { message: '회원가입 성공' },
          error: null,
        };
      } else {
        return {
          status: 'fail',
          data: null,
          error: this.appService.getMessage(statusCode),
        };
      }
    } catch (e) {
      console.log('error',e);
      return this.appService.handleError(e);
    }
  } 

  // 로그인 화면을 어떻게 할건지?
  @Post('/player/login')
  async login(@Body() body , @Req() req ): Promise<any> {
    try{
    const playerId: string = body.playerId;
    const password: string = body.password;
    
    const statusCode = await this.appService.login(playerId, password);
    if (typeof statusCode === 'object' && statusCode !== null){
      
      req.session.player = statusCode; //세션에 저장
      console.log('session 목록:',req.session);
      
      return {
        status: 'success',
        data: { message: '로그인 성공' },
        error: null,
      };
    } else {
      return {
        status: 'fail',
        data: null,
        error: this.appService.getMessage(statusCode),
      };
    }
  } catch (error) {
    return this.appService.handleError(error);
  }
}
    // 2: 없는 아이디
    // 3: 아이디 형식 불일치
    // 4: 비밀번호 형식 불일치
    // 5: 비밀번호 틀림
    // 6: Id 또는 pw 입력값 없이 들어왔을 경우
    // 8: 서버 에러


  //if(req.session !== res.session) { error ;}
  @Post('/player/logout')
  async logout(@Req() req): Promise<any> {
    try{
    req.session.destroy(); // 세션 에서 지우는 메서드
    return {
      status: 'success',
      data:{message:'로그 아웃'},
      error: null
    };
  }catch(e){
    return this.appService.handleError(e);
  }

  }

  // 여기 수정해야함
  @Patch('/player/change-password')
  async changePassword(@Body() body, @Req() req , @Res() res): Promise<any> {
    try{
    if (!req.session.player){
      return {
        status: 'fail',
        data: null,
        error: this.appService.getMessage(0),
      };
    }
    //TODO: 아래코드는 줄일 수 있으면 줄이기
    if(req.session !== res.session) { console.log('error') ;}
    
    const playerId = req.session.player.playerId;
    const oldPassword: string = body.oldPassword;
    const newPassword: string = body.newPassword;
    const statusCode = await this.appService.changePassword(playerId, oldPassword, newPassword);
    if (statusCode === 1) {
      return {
        status: 'success',
        data: { message: '회원가입 성공' },
        error: null,
      };
    } else {
      return {
        status: 'fail',
        data: null,
        error: this.appService.getMessage(statusCode),
      };
    }
    // 1: 성공
    // 2: 비밀번호 미변경 (이전 비밀번호와 일치)
    // 3: 새로운 비밀번호 형식 불일치
    // 4: 기존 비밀번호가 틀림
    // 6: 입력값 없을 경우
    // 7: DB 에러
    // 8: 서버 에러
    }catch(e)
     {
         return this.appService.handleError(e);
     }
  }

  // 회원 탈퇴 // 여기 수정해야함
  @Delete('/player/delete')
  async deletePlayer(@Body() body, @Req() req): Promise<any> {
    try{
      if (!req.session.player){
        return {
          status: 'fail',
          data: null,
          error: this.appService.getMessage(0),
        };
      }
    const playerId = req.session.player.playerId;
    const password = req.session.player.password;
    const statusCode = await this.appService.deletePlayer(playerId,password);
    if (statusCode === 1) {
      return {
        status: 'success',
        data: { message: '회원탈퇴 완료' },
        error: null,
      };
    } else {
      return {
        status: 'fail',
        data: null,
        error: this.appService.getMessage(statusCode),
      };
    }
  }catch(e)
  {
    return this.appService.handleError(e);
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
  async getRoomList(@Query('topicId') topicIds: string | undefined): Promise<any> {
    const topicIdsArray = topicIds
    ? topicIds.split(',').map(id => {
        const parsedId = parseInt(id, 10);
        if (isNaN(parsedId)) {
          throw new Error(`Invalid topicId: ${id}`);
        }
        return parsedId;
      })
    : undefined;

  // topicIdsArray가 배열인 경우에만 이 값을 그대로 전달합니다.
  return await this.appService.getRoomList(topicIdsArray);
  }



  @Post('/room/create')
  async createRoom(@Body() body ,@Req() req): Promise<any> {
    try{
    
    const roomName: string = body.roomName;
    const topicId: number = body.topicId;
    const playerId: string = req.session.player.playerId;
    const startTime: Date = new Date(body.startTime);
    const endTime: Date = new Date(body.endTime);
    
    const statusCode = await this.appService.createRoom(
        roomName,
        topicId,
        playerId,
        startTime,
        endTime,
      );
      console.log(statusCode);
      if (statusCode === 1) {
        return {
          status: 'success',
          data: { message: '회원가입 성공' },
          error: null,
        };
      } else {
        return {
          status: 'fail',
          data: null,
          error: this.appService.getMessage(statusCode),
        };
      }
    // 1: 성공
    // 2: 방 제목 중복
    // 3: 존재하지 않는 플레이어
    // 4: 존재하지 않는 토픽
    // 5: 길이 초과
    // 6: 클라이언트측 입력값 누락
    // 7: DB 에러
    // 8: 서버 에러
  }
  catch(e)
  {
    return this.appService.handleError(e);
  }
}

  @Get('/room/ids')
  async getRooms(@Body() body: { roomIds: string[] }): Promise<Room[]> {
    const roomIds = body.roomIds;
    return await this.appService.getRoomListByIds(roomIds);
  }
}
