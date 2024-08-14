import {
  BaseEntity,
  Column,
  Entity,
  OneToMany,
  PrimaryColumn,
} from 'typeorm';
import { Room } from './room.entity'; // Room 엔티티를 import

@Entity('player')
export class Player extends BaseEntity {
  @PrimaryColumn('varchar', { name: 'player_id' })
  playerId: string;

  @Column({ type: 'varchar', name: 'password', nullable: false })
  password: string;
  //하나의 플레이어가 여러개의 룸을 나타낼 수 있음. 다대일 관계
  @OneToMany(() => Room, (room) => room.player)
  rooms: Room[];
}

