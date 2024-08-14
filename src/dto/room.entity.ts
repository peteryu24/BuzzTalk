import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  PrimaryColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity('room')
export class Room extends BaseEntity {
  @PrimaryColumn('varchar')
  roomId: string;

  @Column({ type: 'timestamp with time zone' })
  startTime: Date;

  @Column({ type: 'timestamp with time zone' })
  endTime: Date;

  @Column({ type: 'integer', nullable: false })
  topicId: number;

  @Column({ type: 'uuid', nullable: false })
  playerId: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
