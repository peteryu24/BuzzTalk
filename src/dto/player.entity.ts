import {
  BaseEntity,
  Column,
  Entity,
  OneToMany,
  PrimaryColumn,
} from 'typeorm';
import { Room } from './room.entity';

@Entity('player')
export class Player extends BaseEntity {
  @PrimaryColumn('varchar', { name: 'player_id' })
  playerId: string;

  @Column({ type: 'varchar', name: 'password', nullable: false })
  password: string;

  @OneToMany(() => Room, (room) => room.player, { onDelete: 'CASCADE' })
  rooms: Room[];
}
