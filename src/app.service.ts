/*
0: 성공적인 결과 (회원가입, 로그인, 비밀번호 변경, 방 생성 등 성공).
1: 이미 존재하는 아이디인 경우 (아이디 중복).
2: 아이디 형식이 올바르지 않은 경우 (validatePlayerId 메서드 통과 실패).
3: 비밀번호 형식이 올바르지 않은 경우 (validatePassword 메서드 통과 실패).
4: playerId 또는 password가 입력되지 않은 경우.
5: 존재하지 않는 데이터 (아이디, 플레이어, 토픽)
6: 비밀번호가 틀린 경우.
8: 새로운 비밀번호가 이전 비밀번호와 동일한 경우.
10: 존재하지 않는 아이디이거나 기존 비밀번호가 틀린 경우 (비밀번호 변경 시).
12: 방 제목이 중복된 경우.
13: 필수 입력값이 누락된 경우 (roomName, topicId, playerId, startTime, endTime 중 하나).
14: 방 제목 길이가 50자를 초과한 경우.
15: 존재하지 않는 주제인 경우.
19: 데이터베이스(DB) 에러 (데이터 저장 실패).
20: 예외가 발생한 경우 (catch 블록에서 리턴). 
999: 방 갯수 조회 실패
*/


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
  
   // 회원가입
   async register(playerId: string, password: string): Promise<number> {
    if (!playerId || !password) {
      return 4; // Id또는 pw입력값없이 들어왔을경우
    }
    const idValidation = this.validatePlayerId(playerId);
    if (!idValidation) {
      return 2; // 아이디 형식 불일치
    }
  
    const passwordValidation = this.validatePassword(password);
    if (!passwordValidation) {
      return 3; // 비밀번호 형식 불일치
    }
  
    const existingPlayer = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (existingPlayer) {
      return 1; // 아이디 중복
    }
  
    try {
      const player = await this.playerRepository.createPlayer(playerId, password);
      if (player) {
        return 0; // 성공
      } else {
        return 19; // DB 에러
      }
    } catch (error) {
      console.log('service error');
      return 20;
    }
  }
  

  // 로그인
  async login(playerId: string, password: string): Promise<any> {
    if (!playerId || !password) {
      return 4; //Id또는 pw입력값없이 들어왔을경우
    }
  
    const idValidation = this.validatePlayerId(playerId);
    if (!idValidation) {
      return 2; // 아이디 형식 불일치
    }
  
    const passwordValidation = this.validatePassword(password);
    if (!passwordValidation) {
      return 3; // 비밀번호 형식 불일치
    }
  
    const player = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (!player) {
      return 5; // 없는 아이디
    }
  
    if (player.password !== password) {
      return 6; // 비밀번호 틀림
    }
  
    try {
      if(player)
        {
          return player;
        }
        else{
          return 19;
        }
    } catch (e) {
      console.log('service error');
      return 20;
    }
  }
  

  // 비밀번호 변경
  async changePassword(playerId: string, oldPassword: string, newPassword: string): Promise<number> {
    if (!playerId || !oldPassword || !newPassword) {
      return 4; // 입력값 없을경우
    }
  
    const player = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (!player || player.password !== oldPassword) {
      return 10; // 기존 비밀번호가 틀림
    }
  
    if (oldPassword === newPassword) {
      return 8; // 비밀번호 미변경 (이전 비밀번호와 일치)
    }
  
    try {
      player.password = newPassword;
      const saveplayer = await this.playerRepository.save(player);
      if (saveplayer) {
        return 0; // 성공
      } else {
        return 19; // DB 에러
      }
    } catch (e) {
      console.log('service error');
      return 20; 
    }
  }
  

  // 회원 탈퇴
  async deletePlayer(playerId: string, password: string): Promise<any> {
    
    const player = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (!player) {
      return 5; //존재하지 않은 플레이어의 경우
    }

    try{
      const playerdestroy = await this.playerRepository.remove(player);
    if(playerdestroy)
    {
      return 0; //성공
    }
    else
    {
      return 19; // DB에러
    }
  }
  catch(e)
  {
    console.log('service error');
    return 20;
  }
}

  async getPlayer(playerId: string, password: string): Promise<any> {
    try {
      let player = await this.playerRepository.getPlayerIdByPlayer(playerId);
      
      if (!player) { 
          return 5;
      }

      return player;
    } catch (e) {
      console.log('service error');
      return 20;
    }
  }
  

  async getTopicList(): Promise<any> {
    const topics = await this.topicRepository.getTopicList();
    
    if (topics && topics.length > 0) {
      return topics;  // 토픽이 있을 때 
    } else {
      return 5;  // 토픽이 없을 때 
    }
  }
  

  async getRoomCountByTopic(): Promise<any> {
    const roomCount = await this.topicRepository.getTopicListWithCount();
    
    if (roomCount === null || roomCount === undefined || roomCount.length === 0) {
      return 999; 
    }
    
    return roomCount;
  }
  
  async getRoomList(
    topicIds: number[] | undefined,
    cursorId: number | undefined,
    limit: number,
  ): Promise<any> {
    this.roomRepository.deleteRooms();
    const res: Room[] | undefined = await this.roomRepository.getRooms(
      topicIds,
      cursorId,
      limit,
    );

    if (!res) {
      return 5;
    }

    const rooms = res.map(room => ({
      roomId: room.roomId,
      roomName: room.roomName,
      startTime: room.startTime?.toISOString(),
      endTime: room.endTime?.toISOString(),
      topicId: room.topicId,
      playerId: room.playerId,
      book: room.book,
      updatedAt: room.updatedAt?.toISOString(),
    }));

    let nextCursorId: string | undefined = undefined;
    if (res.length === limit) {
      nextCursorId = res[res.length - 1].roomId.toString();
    }

    return {
      rooms: rooms,       // 변환된 rooms 배열을 반환
      cursorId: nextCursorId,
    };
  }
  
  async createRoom(
    roomName: string,
    topicId: number,
    playerId: string,
    startTime: Date,
    endTime: Date,
  ): Promise<number> {
    if (!roomName || !topicId || !playerId || !startTime || !endTime) {
      return 13; // 필수 입력값 누락
    }
  
    if (roomName.length > 50) {
      return 14; // 방 제목 형식 불일치 (길이 초과)
    }


    const existingPlayer = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (!existingPlayer) {
      return 5; // 존재하지 않는 플레이어의 경우
    }
  
    const existingTopic = await this.topicRepository.getTopicIdByTopic(topicId);
    if (!existingTopic) {
      return 15; // 주제가 존재하지 않음
    }
  
    const existingRoom = await this.roomRepository.getRoomnameByRoom(roomName);
    if (existingRoom) {
      return 12; // 방 제목 중복
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
        return 0; // 성공
      } else {
        return 19; // DB 에러
      }
    } catch (e) {
      console.log('service error');
    return 20;
    }
  }
}