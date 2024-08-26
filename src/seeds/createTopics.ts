import dataSource from '../../data-source';
import { Topic } from '../dto/topic.entity';
import { config } from 'dotenv';

config();

async function seed() {
  try {
    await dataSource.initialize();

    await dataSource.query('TRUNCATE TABLE topic RESTART IDENTITY CASCADE');
    
    const topics = [
      { topicName: '토픽1' },
      { topicName: '토픽2' },
      { topicName: '토픽3' },
      { topicName: '토픽4' },
      { topicName: '토픽5' },
    ];

    for (const topicData of topics) {
      const topic = new Topic();
      topic.topicName = topicData.topicName;
      await dataSource.getRepository(Topic).save(topic);
    }

    console.log('Seeding successfully');
  } catch (error) {
    console.error('Error seeding topics:', error);
  } finally {
    await dataSource.destroy();
  }
}

seed();
