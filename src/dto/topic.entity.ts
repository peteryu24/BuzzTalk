import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity('topic')
export class Topic extends BaseEntity {
  @PrimaryGeneratedColumn()
  topicId: number;

  @Column()
  topicName: string;
}
