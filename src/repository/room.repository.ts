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
  
  async getRoomnameByRoom(roomName: string): Promise<Room | undefined> {
    return await this.findOneBy({ roomName });
  }

  async deleteRooms(): Promise<void> {
    this.query(`
      DELETE FROM room
      WHERE end_time < NOW();
    `);
  }
  
  async getRooms(
    topicIds: number[] | undefined,
    cursorId: number | undefined,
    limit: number,
  ): Promise<Room[]> {
    const queryBuilder = this.createQueryBuilder('room')
      .where('room.end_time > NOW()');

    if (topicIds && topicIds.length > 0) {
      queryBuilder.andWhere('room.topic_id IN (:...topicIds)', { topicIds });
    }

    if (cursorId) {
      queryBuilder.andWhere('room.room_id < :cursorId', { cursorId });
    }

    queryBuilder.orderBy('room.created_at', 'DESC').limit(limit);

    return await queryBuilder.getMany();
  }

} 