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
  
  async getOrCreatePlayer(playerId: string,password:string): Promise<any> {
    let player = await this.playerRepository.getPlayerByPlayerId(playerId);
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
  async getRoomList(
    topicId: number | undefined,
    cursorId: string | undefined,
    limit: number,
  ): Promise<any> {
    const res: Room[] | undefined = await this.roomRepository.getRooms(
      topicId,
      cursorId,
      limit,
    );

    if (!res) {
      return {
        rooms: [],
        cursorId: undefined,
      };
    }

    let nextCursorId: string | undefined = undefined;
    if (res.length === limit) {
      nextCursorId = res[res.length - 1].roomId.toString();
    }

    return {
      rooms: res,
      cursorId: nextCursorId,
    };
  }

  async createRoom(
    roomId: string,
    topicId: number,
    playerId: string,
    startTime: Date,
    endTime: Date,
  ): Promise<Room> {
    const room = new Room();
    room.roomId = roomId;
    room.topicId = topicId;
    room.playerId = playerId;
    room.startTime = startTime;
    room.endTime = endTime;
    return await this.roomRepository.createRoom(room);
  }

  //새로만든거
   // 회원가입
   async register(playerId: string, password: string): Promise<any> {
    const existingPlayer = await this.playerRepository.getPlayerByPlayerId(playerId);
    if (existingPlayer) {
      throw new Error('Player with this ID already exists');
    }

    const player = await this.playerRepository.createPlayer(playerId, password);
    
    return player;
  }

  // 로그인
  async login(playerId: string, password: string): Promise<any> {
    const player = await this.playerRepository.getPlayerByPlayerId(playerId);
    if (!player || player.password !== password) {
      return('Error'); //int형식으로 나중에 수정 할거임
    }
    //player 객체 반환
    return player; // 나중에 세션식으로 쓸 때 수정
  }

  // 비밀번호 변경
  async changePassword(playerId: string,oldPassword: string, newPassword: string): Promise<void> 
  {
    const player = await this.playerRepository.getPlayerByPlayerId(playerId);
    if (!player || player.password !== oldPassword) {
      throw new Error('Invalid credentials');
    }

    player.password = newPassword;
    await this.playerRepository.save(player);
  }

  // 회원 탈퇴
  async deletePlayer(playerId: string, password: string): Promise<void> {
    const player = await this.playerRepository.getPlayerByPlayerId(playerId);
    if (!player) {
      throw new Error('Player not found');
    }
    await this.playerRepository.remove(player);
  }

}
