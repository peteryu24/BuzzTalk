import { Injectable } from '@nestjs/common';
import { RoomRepository } from './repository/room.repository';
import { TopicRepository } from './repository/topic.repository';
import { Room } from './dto/room.entity';
import { PlayerRepository } from './repository/player.repository';

@Injectable()
export class AppService {
  constructor(
    private roomRepository: RoomRepository,
    private topicRepository: TopicRepository,
    private playerRepository: PlayerRepository,
  ) {}
  //아래 2개는 playerId, password 검증 로직을 하는 로직. typescript도 정규표현식 사용 가능
  private validatePlayerId(playerId: string): boolean {
    const idRegex = /^[a-z0-9]{3,15}$/;
    return idRegex.test(playerId);
  }
  
  //수정
  private validatePassword(password: string): boolean {
    const minLength = 8;
    const upperCaseRegex = /[A-Z]/;
    const lowerCaseRegex = /[a-z]/;
    const numberRegex = /[0-9]/;
    const specialCharRegex = /[!@#$%^&*(),.?":{}|<>]/;
  
    return (
      password.length >= minLength &&
      upperCaseRegex.test(password) &&
      lowerCaseRegex.test(password) &&
      numberRegex.test(password) &&
      specialCharRegex.test(password)
    );
  }
  

  //새로만든거
   // 회원가입
   async register(playerId: string, password: string): Promise<number> {
    if (!playerId || !password) {
      return 6; // Id또는 pw입력값없이 들어왔을경우
    }
    const idValidation = this.validatePlayerId(playerId);
    if (!idValidation) {
      return 3; // 아이디 형식 불일치
    }
  
    const passwordValidation = this.validatePassword(password);
    if (!passwordValidation) {
      return 4; // 비밀번호 형식 불일치
    }
  
    const existingPlayer = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (existingPlayer) {
      return 2; // 아이디 중복
    }
  
    try {
      const player = await this.playerRepository.createPlayer(playerId, password);
      if (player) {
        return 1; // 성공
      } else {
        return 7; // DB 에러
      }
    } catch (error) {
      console.error('서버 에러:', error);
      return 8; // 서버 에러
    }
  }
  

  // 로그인
  async login(playerId: string, password: string): Promise<any> {
    if (!playerId || !password) {
      return 6; //Id또는 pw입력값없이 들어왔을경우
    }
  
    const idValidation = this.validatePlayerId(playerId);
    if (!idValidation) {
      return 3; // 아이디 형식 불일치
    }
  
    const passwordValidation = this.validatePassword(password);
    if (!passwordValidation) {
      return 4; // 비밀번호 형식 불일치
    }
  
    const player = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (!player) {
      return 2; // 없는 아이디
    }
  
    if (player.password !== password) {
      return 5; // 비밀번호 틀림
    }
  
    try {
      return player; // 성공(객체는 컨트롤러에서 세션에 담음)
    } catch (e) {
      console.error('서버 에러:', e);
      return 8; // 서버 에러
    }
  }
  

  // 비밀번호 변경
  async changePassword(playerId: string, oldPassword: string, newPassword: string): Promise<number> {
    if (!playerId || !oldPassword || !newPassword) {
      return 6; // 입력값 없을경우
    }
  
    const player = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (!player || player.password !== oldPassword) {
      return 4; // 기존 비밀번호가 틀림
    }
  
    const passwordValidation = this.validatePassword(newPassword);
    if (!passwordValidation) {
      return 3; //없는경우
    }
  
    if (oldPassword === newPassword) {
      return 2; // 비밀번호 미변경 (이전 비밀번호와 일치)
    }
  
    try {
      player.password = newPassword;
      const saveplayer = await this.playerRepository.save(player);
      if (saveplayer) {
        return 1; // 성공
      } else {
        return 7; // DB 에러
      }
    } catch (e) {
      console.error('서버 에러:', e);
      return 8; // 서버 에러  
    }
  }
  

  // 회원 탈퇴
  async deletePlayer(playerId: string, password: string): Promise<any> {
    
    const player = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (!player) {
      return 0; //존재하지 않은 플레이어의 경우
    }

    try{
      const playerdestroy = await this.playerRepository.remove(player);
    if(playerdestroy)
    {
      return 1; //성공
    }
    else
    {
      return 7; // DB에러
    }
  }
  catch(e)
  {
    console.error('서버 에러:',e);
    return 8; //서버 에러
  }
}
  //까지가 player항목=======================================================================//


  async getOrCreatePlayer(playerId: string,password:string): Promise<any> {
    let player = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (!player) {
      player = await this.playerRepository.createPlayer(playerId,password);
    }
    return player;
  }

  async getTopicList(): Promise<any> {
    return await this.topicRepository.getTopicList();
  }

  async getRoomCountByTopic(): Promise<any> {
    return await this.topicRepository.getTopicListWithCount();
  }

  //현재 방의 리스트 순서대로 출력, 만약 방 id를 오름차순으로 넣는다면 받을때는 내림차순으로 방을 보여주는게 맞을듯?
  async getRoomListByIds(ids: string[]): Promise<Room[]> {
    return await this.roomRepository.getRoomsByIds(ids);
  }
  //
  async getRoomList(topicIds: number[] | undefined): Promise<any> {
    if (!topicIds || topicIds.length === 0) {
      // topicId가 주어지지 않은 경우, 모든 Room 반환
      return await this.roomRepository.find();
    } else {
      // 여러 개의 topicId에 해당하는 Room들을 찾기
      const rooms = await this.roomRepository.getRoomsByTopics(topicIds);
      return rooms;
    }
  }
  
  

  async createRoom(
    roomName: string,
    topicId: number,
    playerId: string,
    startTime: Date,
    endTime: Date,
  ): Promise<number> {
    if (!roomName || !topicId || !playerId || !startTime || !endTime) {
      return 6; // 필수 입력값 누락
    }
  
    if (roomName.length > 50) {
      return 5; // 방 제목 형식 불일치 (길이 초과)
    }
  
    const existingPlayer = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (!existingPlayer) {
      return 3; // 존재하지 않는 플레이어의 경우
    }
  
    const existingTopic = await this.topicRepository.getTopicIdByTopic(topicId);
    if (!existingTopic) {
      return 4; // 주제가 존재하지 않음
    }
  
    const existingRoom = await this.roomRepository.getRoomnameByRoom(roomName);
    if (existingRoom) {
      return 2; // 방 제목 중복
    }
  
    try {
      const room = new Room();
      room.roomName = roomName;
      room.topicId = topicId;
      room.playerId = playerId;
      room.startTime = startTime;
      room.endTime = endTime;
  
      const savedRoom = await this.roomRepository.save(room);
      if (savedRoom) {
        return 1; // 성공
      } else {
        return 7; // DB 에러
      }
    } catch (e) {
      console.error('서버 에러:', e);
      return 8; // 서버 에러
    }
  }

  handleError(error: any): { status: string, data: any, error: string } { 
    if (error.name === 'QueryFailedError' || error.code === 'ER_DB_ERROR') {
      // 데이터베이스 관련 에러 처리
      return {
        status: 'error',
        data: null,
        error: 'DB 에러가 발생했습니다.',
      };
    } else {
      // 기타 서버 에러 처리
      return {
        status: 'error',
        data: null,
        error: '서버 에러가 발생했습니다.',
      };
    }
  }
  
// 메시지 반환 함수
  getMessage(statusCode: number): string {
    const messages = {
      0: '로그인 안됨',
      2: '아이디 중복',
      3: '아이디 형식 불일치',
      4: '비밀번호 형식 불일치',
      5: '비밀번호 틀림',
      6: 'Id 또는 pw 입력값 누락',
    };
    return messages[statusCode] || '알 수 없는 오류';

  }
  
}