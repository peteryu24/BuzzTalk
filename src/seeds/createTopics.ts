import dataSource from '../../data-source';
import { Topic } from '../dto/topic.entity';
import { config } from 'dotenv';

config();

async function seed() {
  try {
    await dataSource.initialize();

    // 모든 테이블 데이터 삭제
    await dataSource.query('TRUNCATE TABLE topic RESTART IDENTITY CASCADE');
    
    // 새로운 데이터 삽입
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

    console.log('Topics seeded successfully');
  } catch (error) {
    console.error('Error seeding topics:', error);
  } finally {
    await dataSource.destroy();
  }
}

seed();
