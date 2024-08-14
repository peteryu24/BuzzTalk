import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Room } from '../dto/room.entity';

@Injectable()
export class RoomRepository extends Repository<Room> {
  constructor(datasource: DataSource) {
    super(Room, datasource.createEntityManager());
  }

  async createRoom(room: Room): Promise<Room> {
    return await this.save(room);
  }
 //여러개의 룸id를 한 번에 찾고싶을때 ...ids로 쓴다고 함.
  async getRoomsByIds(ids: string[]): Promise<Room[]> {
    return await this.createQueryBuilder('room')
      .where('room.room_id IN (:...ids)', { ids })
      .andWhere('room.end_time > NOW()')
      .getMany();
  }

  async getRooms(
    topicId: number | undefined,
    cursorId: string | undefined,
    limit: number,
  ): Promise<Room[]> {
    const query = this.createQueryBuilder('room')
      .where('room.end_time > NOW()');

    if (topicId !== undefined) {
      query.andWhere('room.topic_id = :topic_id', { topicId });
    }

    if (cursorId !== undefined) {
      query.andWhere('room.room_id < :cursorId', { cursorId });
    }

    query.orderBy('room.created_at', 'DESC')
      .limit(limit);

    return await query.getMany();
  }
}

