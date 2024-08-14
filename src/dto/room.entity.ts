import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  ManyToOne,
  PrimaryColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Player } from './player.entity';
import { Topic } from './topic.entity';

@Entity('room')
export class Room extends BaseEntity {
  @PrimaryColumn('varchar', { name: 'room_id' })
  roomId: string;

  @Column({ type: 'timestamptz', name: 'start_time', nullable: false })
  startTime: Date;

  @Column({ type: 'timestamptz', name: 'end_time', nullable: false })
  endTime: Date;

  @Column({ type: 'integer', name: 'topic_id', nullable: false })
  topicId: number;

  @Column({ type: 'varchar', name: 'player_id', nullable: false })
  playerId: string;
  //아래 두개는 여러개의 룸이 하나의 topic, player을 표현 가능. 연관관계를 가지고 있어 반대편이 지워질경우 room에 대한 정보 자동 삭제.
  @ManyToOne(() => Topic, (topic) => topic.rooms, { onDelete: 'CASCADE' })
  topic: Topic;

  @ManyToOne(() => Player, (player) => player.rooms, { onDelete: 'CASCADE' })
  player: Player;

  @CreateDateColumn({ type: 'timestamptz', name: 'created_at', default: () => 'CURRENT_TIMESTAMP' })
  createdAt: Date;

  @UpdateDateColumn({ type: 'timestamptz', name: 'updated_at', default: () => 'CURRENT_TIMESTAMP' })
  updatedAt: Date;
}

