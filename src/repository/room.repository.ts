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

  //SELECT * FROM room WHERE room.topic_id IN (topicIds)랑 똑같다고 함.. createQueryBuilder에 대해 알아볼것
  async getRoomsByTopics(topicIds: number[] | null): Promise<Room[]> {
    const queryBuilder = this.createQueryBuilder('room');
  
    // null이면 다 반환
    if (!topicIds || topicIds.length === 0) {
      return await queryBuilder.getMany();
    }
    return await queryBuilder
      .where('room.topic_id IN (:...topicIds)', { topicIds })
      .andWhere('room.end_time > NOW()') //수정한거
      .getMany();
  }

  async deleteRooms(): Promise<void> {
    this.query(`
      DELETE FROM room
      WHERE end_time < NOW();
    `);
    console.log('Expired rooms deleted.');
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
  ): Promise<Room[]> {
    let query = `SELECT * FROM room WHERE end_time > NOW()`;
  
    if (topicId !== undefined) {
      query += ` AND topic_id = ${topicId}`;
    }
  
    query += ` ORDER BY created_at DESC`;
  
    return await this.query(query);
  }

} 