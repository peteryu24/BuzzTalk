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

  @OneToMany(() => Room, (room) => room.topic, { onDelete: 'CASCADE' })
  rooms: Room[];
}
