import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Topic } from '../dto/topic.entity';

@Injectable()
export class TopicRepository extends Repository<Topic> {
  //여기서 데이터 받아와서 객체 초기화 하고 사용
  constructor(datasource: DataSource) {
    super(Topic, datasource.createEntityManager());
  }
  async getTopicIdByTopic(topicId: number): Promise<Topic | undefined> {
    return await this.findOneBy({ topicId });
  }

  //topic 정보 전부 가져옴
  async getTopicList(): Promise<Topic[]> {
    return await this.find();
  }

  async getTopicListWithCount(): Promise<any> {
    return await this.query(`
        SELECT t.topic_id,
               COALESCE(a.room_count, 0) AS room_count
        FROM topic t
                 LEFT JOIN (SELECT topic_id,
                                   COUNT(room_id) AS room_count
                            FROM room
                            WHERE end_time > NOW()
                            GROUP BY topic_id) a ON t.topic_id = a.topic_id
        ORDER BY room_count DESC
    `);
  }
}
