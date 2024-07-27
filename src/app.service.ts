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

  async getOrCratePlayer(uuid: string): Promise<any> {
    let player = await this.playerRepository.getPlayerByUuid(uuid);
    if (!player) {
      player = await this.playerRepository.createPlayer(uuid);
    }
    return player;
  }

  async getTopicList(): Promise<any> {
    return await this.topicRepository.getTopicList();
  }

  async getRoomCountByTopic(): Promise<any> {
    return await this.topicRepository.getTopicListWithCount();
  }

  async getRoomListByIds(ids: number[]): Promise<Room[]> {
    return await this.roomRepository.getRoomsByIds(ids);
  }

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
      nextCursorId = res[res.length - 1].id.toString();
    }

    return {
      rooms: res,
      cursorId: nextCursorId,
    };
  }

  async createRoom(
    topicId: number,
    roomName: string,
    playerId: number,
    startTime: Date,
    endTime: Date,
  ): Promise<Room> {
    const room = new Room();
    room.topicId = topicId;
    room.name = roomName;
    room.playerId = playerId;
    room.startTime = startTime;
    room.endTime = endTime;
    return await this.roomRepository.createRoom(room);
  }
}
