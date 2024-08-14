import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  OneToMany,
  PrimaryColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity('player')
export class Player extends BaseEntity {
  @PrimaryColumn('uuid')
  playerId: string;

  @Column({ type: 'varchar', nullable: false })
  password: string;
}
