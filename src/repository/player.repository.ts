import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Player } from '../dto/player.entity';

@Injectable()
export class PlayerRepository extends Repository<Player> {
  constructor(datasource: DataSource) {
    super(Player, datasource.createEntityManager());
  }

  async getPlayerIdByPlayer(playerId: string): Promise<Player | undefined> {
    return await this.findOneBy({ playerId });
  }

  async createPlayer(playerId: string, password: string): Promise<Player> {
    const player = new Player();
    player.playerId = playerId;
    player.password = password;
    return await this.save(player);
  }
}
