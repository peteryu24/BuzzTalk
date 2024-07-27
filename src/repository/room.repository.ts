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

  async getRoomsByIds(ids: number[]): Promise<Room[]> {
    return await this.query(
      `SELECT * FROM room WHERE id IN (${ids.join(',')}) AND end_time > NOW()`,
    );
  }

  async getRooms(
    topicId: number | undefined,
    cursorId: string | undefined,
    limit: number,
  ): Promise<Room[] | undefined> {
    let query = `SELECT * FROM room`;
    query += ` WHERE end_time > NOW()`;
    if (topicId) {
      query += ` AND topic_id = ${topicId}`;
    }
    if (cursorId) {
      query += ` AND id < ${cursorId}`;
    }
    query += ` ORDER BY id DESC LIMIT ${limit}`;
    return await this.query(query);
  }
}
