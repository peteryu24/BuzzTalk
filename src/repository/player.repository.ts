import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Player } from '../dto/player.entity';

@Injectable()
export class PlayerRepository extends Repository<Player> {
  constructor(datasource: DataSource) {
    super(Player, datasource.createEntityManager());
  }

  async getPlayerByUuid(uuid: string): Promise<Player | undefined> {
    return await this.findOneBy({ uuid });
  }

  async createPlayer(uuid: string): Promise<Player> {
    const player = new Player();
    player.uuid = uuid;
    return await this.save(player);
  }
}
