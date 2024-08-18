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
  private validatePlayerId(playerId: string): any {
    const idRegex = /^[a-z0-9]{3,15}$/;
    if (!idRegex.test(playerId)) {
      return {message:'아이디는 영어 소문자와 숫자만 포함되어 있고, 3~15자 사이로 입력해야 합니다.'};
    }
  }
  //수정
  private validatePassword(password: string): any {
    const minLength = 8;
    const upperCaseRegex = /[A-Z]/;
    const lowerCaseRegex = /[a-z]/;
    const numberRegex = /[0-9]/;
    const specialCharRegex = /[!@#$%^&*(),.?":{}|<>]/;

    if (password.length < minLength) {
      return {message:'패스워드는 8자 이상이어야 합니다.'};
    }
    if (!upperCaseRegex.test(password)) {
      return {message:'비밀번호엔 적어도 1개 이상의 대문자가 포함되어 있어야 합니다.'};
    }
    if (!lowerCaseRegex.test(password)) {
      return {message:'비밀번호엔 적어도 1개 이상의 소문자가 포함되어 있어야 합니다.'};
    }
    if (!numberRegex.test(password)) {
      return {message:'비밀번호엔 적어도 1개 이상의 숫자가 포함되어 있어야 합니다.'};
    }
    if (!specialCharRegex.test(password)) {
      return {message:'비밀번호엔 적어도 1개 이상의 특수문자가 포함되어 있어야 합니다.'};
    }
  }
  
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
  async getRoomList(
    topicId: number | undefined,
  ): Promise<any> {
    const res: Room[] | undefined = await this.roomRepository.getRooms(topicId);
    return res;
  }
  

  async createRoom(
    roomName: string,
    topicId: number,
    playerId: string,
    startTime: Date,
    endTime: Date,
  ): Promise<Room> {
    //playerId가 존재하는지 확인하는 단계
    const existingPlayer = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (!existingPlayer) {
      throw new Error('Player Id not exist.');
    }

    const existingTopic = await this.topicRepository.getTopicIdByTopic(topicId);
    if(!existingPlayer){
      throw new Error('Topic Id not exist.');
    }
    const room = new Room();
    room.roomName = roomName;
    room.topicId = topicId;
    room.playerId = playerId;
    room.startTime = startTime;
    room.endTime = endTime;
    return await this.roomRepository.createRoom(room);
  }

  //새로만든거
   // 회원가입
   async register(playerId: string, password: string): Promise<any> {

    this.validatePlayerId(playerId);
    this.validatePassword(password);

    const existingPlayer = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (existingPlayer) {
      return 0;
    }

    const player = await this.playerRepository.createPlayer(playerId, password);
    if (player)
    {
      return 1;
    }
    else
    {
      return 2;
    }
  }

  // 로그인
  async login(playerId: string, password: string): Promise<any> {

    this.validatePlayerId(playerId);
    this.validatePassword(password);

    const player = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (!player || player.password !== password) {
      return 0; //int형식으로 나중에 수정 할거임
    }
    //player 객체 반환
    return player; // 나중에 세션식으로 쓸 때 수정
  }

  // 비밀번호 변경
  async changePassword(playerId: string,oldPassword: string, newPassword: string): Promise<number> 
  {

    this.validatePlayerId(playerId);
    this.validatePassword(newPassword);

    const player = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (!player || player.password !== oldPassword) {
      return 0;
    }

    player.password = newPassword;
    const saveplayer = await this.playerRepository.save(player)
    if(saveplayer)
    {
      return 1;
    }
    else
    {
      return 2;
    }
  }

  // 회원 탈퇴
  async deletePlayer(playerId: string, password: string): Promise<any> {
    
    const player = await this.playerRepository.getPlayerIdByPlayer(playerId);
    if (!player) {
      return 0;
    }
    const playerdestroy = await this.playerRepository.remove(player);
    if(playerdestroy)
    {
      return 1;
    }
    else
    {
      return 2;
    }
  }

}
