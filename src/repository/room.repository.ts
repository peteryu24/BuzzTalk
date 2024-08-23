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

 //여러개의 룸id를 한 번에 찾고싶을때 ...ids로 쓴다고 함.
  async getRoomsByIds(ids: string[]): Promise<Room[]> {
    return await this.createQueryBuilder('room')
      .where('room.room_id IN (:...ids)', { ids })
      .andWhere('room.end_time > NOW()')
      .getMany();
  }

  async getRooms(
    topicIds: number[] | undefined,
    cursorId: number | undefined,
    limit: number,
  ): Promise<Room[]> {
    const queryBuilder = this.createQueryBuilder('room')
      .where('room.end_time > NOW()'); // 만료되지 않은 방만 선택

    // topicIds가 존재하고 배열에 값이 있으면 해당 topicId를 기준으로 필터링
    if (topicIds && topicIds.length > 0) {
      queryBuilder.andWhere('room.topic_id IN (:...topicIds)', { topicIds });
    }

    // cursorId가 존재하면 해당 id보다 작은 id를 가진 레코드만 선택
    if (cursorId) {
      queryBuilder.andWhere('room.room_id < :cursorId', { cursorId });
    }

    // 생성일 기준으로 내림차순 정렬하고 리미트 만큼 반환
    queryBuilder.orderBy('room.created_at', 'DESC').limit(limit);

    return await queryBuilder.getMany();
  }

} 