import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  ManyToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
  JoinColumn
} from 'typeorm';
import { Player } from './player.entity'; 
import { Topic } from './topic.entity'; 

@Entity('room')
export class Room extends BaseEntity {
  @PrimaryGeneratedColumn('increment', { name: 'room_id' })
  roomId: number;

  @Column({type:'varchar', name: 'room_name', nullable: false })
  roomName: string;

  @Column({ type: 'timestamp', name: 'start_time', nullable: false })
  startTime: Date;

  @Column({ type: 'timestamp', name: 'end_time', nullable: false })
  endTime: Date;

  @Column({ type: 'integer', name: 'topic_id', nullable: false })
  topicId: number;

  @Column({ type: 'varchar', name: 'player_id', nullable: false })
  playerId: string;

  @Column({type:'boolean', name:'book', nullable: false, default:false})
  book: boolean;

  @ManyToOne(() => Topic, (topic) => topic.rooms, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'topic_id' })
  topic: Topic;

  @ManyToOne(() => Player, (player) => player.rooms, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'player_id' })
  player: Player;

  @CreateDateColumn({ type: 'timestamptz', name: 'created_at', default: () => 'CURRENT_TIMESTAMP' })
  createdAt: Date;

  @UpdateDateColumn({ type: 'timestamptz', name: 'updated_at', default: () => 'CURRENT_TIMESTAMP' })
  updatedAt: Date;
}
