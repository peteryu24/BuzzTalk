import { Body, Controller, Get, Post, Patch, Delete, Query, UseGuards, Req } from '@nestjs/common';
import { AppService } from './app.service';
import { Logger } from '@nestjs/common';
import { BuzzTalkResult } from './buzzTalkResult.utils'; // Import your utility class

@Controller()
export class AppController {
  private buzzTalkResult: BuzzTalkResult = new BuzzTalkResult(); // Create an instance of BuzzTalkResult

  constructor(private readonly appService: AppService) {}

  @Post('/player/register')
  async register(@Body() body): Promise<any> {
    Logger.log('Register endpoint hit'); 
    try {
      const playerId: string = body.playerId;
      const password: string = body.password;

      const statusCode = await this.appService.register(playerId, password);
      
      if (statusCode === 0) {
        return this.buzzTalkResult.success({ message: '회원가입 성공' });
      } 
      
      // 회원가입 실패 
      return this.buzzTalkResult.resultError(statusCode);
      
    } catch (e) {
      return this.buzzTalkResult.handleError(e);
    }
  }

  @Post('/player/login')
  async login(@Body() body, @Req() req): Promise<any> {
    try {
      const playerId: string = body.playerId;
      const password: string = body.password;
    
      const statusCode = await this.appService.login(playerId, password);
      if (typeof statusCode === 'object' && statusCode !== null) {
        req.session.player = statusCode; // Save to session
        console.log('session 목록:', req.session.player);
        
        return this.buzzTalkResult.success({ message: '로그인 성공' });
      } 

      // 로그인 실패
      return this.buzzTalkResult.resultError(statusCode);
    
    } catch (error) {
      return this.buzzTalkResult.handleError(error);
    }
  }

  @Post('/player/logout')
  async logout(@Req() req): Promise<any> {
    if (!req.session) {
      return this.buzzTalkResult.resultError(8);
    }
    
    try {
      req.session.destroy(); // Remove from session
      return this.buzzTalkResult.success({ message: '로그아웃 성공' });
    } catch (e) {
      return this.buzzTalkResult.handleError(e);
    }
  }

  @Post('/player/changePassword')
  async changePassword(@Body() body, @Req() req): Promise<any> {
    try {
      if (!req.session.player) {
        return this.buzzTalkResult.resultError(8);
      }
      
      const playerId = req.session.player.playerId;
      const oldPassword: string = body.oldPassword;
      const newPassword: string = body.newPassword;

      const statusCode = await this.appService.changePassword(playerId, oldPassword, newPassword);
      
      if (statusCode === 0) {
        return this.buzzTalkResult.success({ message: '변경 성공' });
      } 

      // 비밀번호 변경 실패
      return this.buzzTalkResult.resultError(statusCode);
      
    } catch (e) {
      return this.buzzTalkResult.handleError(e);
    }
  }

  @Post('/player/delete')
  async deletePlayer(@Body() body, @Req() req): Promise<any> {
    try {
      if (!req.session.player) {
        return this.buzzTalkResult.resultError(8);
      }

      const playerId = req.session.player.playerId;
      const password = req.session.player.password;
      const statusCode = await this.appService.deletePlayer(playerId, password);
      
      if (statusCode === 0) {
        return this.buzzTalkResult.success({ message: '회원탈퇴 완료' });
      } 

      // 회원 탈퇴 실패
      return this.buzzTalkResult.resultError(statusCode);
      
    } catch (e) {
      return this.buzzTalkResult.handleError(e);
    }
  }

  @Get('/topic/list')
  async getTopicList(): Promise<any> {
    try {
      const topics = await this.appService.getTopicList();
  
      if (topics !== 5) { // 토픽이 있을 때
        return this.buzzTalkResult.success(topics);
      }
      
      // 토픽이 없을 때 
      return this.buzzTalkResult.resultError(topics);
    
  
    } catch (e) {
      return this.buzzTalkResult.handleError(e); // 예외 처리
    }
  }
  


  @Get('/topic/roomCount')
async getRoomCountByTopic(): Promise<any> {
  try {
    const roomCount = await this.appService.getRoomCountByTopic();

    if (roomCount !== 999) { // 성공
      return this.buzzTalkResult.success(roomCount);
    }
    
    // 실패
    return this.buzzTalkResult.resultError(roomCount);
    
    
  } catch (e) {
    return this.buzzTalkResult.handleError(e); 
  }
}


@Post('/player/getInfo')
async getPlayer(@Body() body): Promise<any> {
  try {
    const playerId: string = body.playerId;
    const password: string = body.password;
    
    const result = await this.appService.getPlayer(playerId, password);

    if (typeof result !== 'number') { // result가 숫자 형식이 아니면 성공
      return this.buzzTalkResult.success(result);
    }
    // 실패 
    return this.buzzTalkResult.resultError(result);

  } catch (e) {
    return this.buzzTalkResult.handleError(e);
  }
}


@Post('/room/getList')
async getRoomList(@Body() body): Promise<any> {
  try {
    const limit: number = body.limit;
    const cursorId: number | undefined = body.cursorId;
    const topicIds: number[] | undefined = body.topicIds; // topicIds를 배열로 받음

    const rooms = await this.appService.getRoomList(topicIds, cursorId, limit);

    // 성공
    if (rooms !== 5) {
      return this.buzzTalkResult.success(rooms);
    } 

    // 실패
    return this.buzzTalkResult.resultError(rooms); 
    
  } catch (e) {
    return this.buzzTalkResult.handleError(e);
  }
}



  @Post('/room/create')
  async createRoom(@Body() body, @Req() req): Promise<any> {
    try {
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
      
      if (statusCode === 0) {
        return this.buzzTalkResult.success({ message: '방 생성 성공' });
      } else {
        return this.buzzTalkResult.resultError(statusCode);
      }
    } catch (e) {
      return this.buzzTalkResult.handleError(e);
    }
  } 

  @Post('/room/getListByIds')
async getListByIds(@Body() body: { roomIds: string[] }): Promise<any> {
  try {
    const roomIds = body.roomIds;
    const rooms = await this.appService.getRoomListByIds(roomIds);

    // 성공
    if (rooms !== 5) {
      return this.buzzTalkResult.success(rooms);
    }

    // 실패
    return this.buzzTalkResult.resultError(rooms); 
    
  } catch (e) {
    return this.buzzTalkResult.handleError(e);
  }
}

}
