import { DataSource } from 'typeorm';
import { Seeder } from 'typeorm-extension';
import { Topic } from '../../dto/topic.entity';

export default class TopicSeeder implements Seeder {
  async run(dataSource: DataSource): Promise<any> {
    const repository = dataSource.getRepository(Topic);
    await repository.insert([
      {
        id: 0,
        name: '토픽1',
      },
      {
        id: 1,
        name: '토픽3',
      },
    ]);
  }
}
