import { DataSource } from 'typeorm';
import { Seeder } from 'typeorm-extension';
import { Topic } from '../../dto/topic.entity';

export default class TopicSeeder implements Seeder {
  async run(dataSource: DataSource): Promise<any> {
    const repository = dataSource.getRepository(Topic);
    await repository.insert([
      {
        topicId: 0,
        topicName: '토픽1',
      },
      {
        topicId: 1,
        topicName: '토픽3',
      },
    ]);
  }
}
