import {
  BaseEntity,
  Column,
  Entity,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Room } from './room.entity'; // Room 엔티티를 import

@Entity('topic')
export class Topic extends BaseEntity {
  @PrimaryGeneratedColumn('increment', { name: 'topic_id' })
  topicId: number;

  @Column({ type: 'varchar', name: 'topic_name', nullable: false })
  topicName: string;
  //하나의 토픽이 여러개의 룸을 나타낼 수 있음. 일대다 관계
  @OneToMany(() => Room, (room) => room.topic)
  rooms: Room[];
}
