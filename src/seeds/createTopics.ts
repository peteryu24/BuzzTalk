import dataSource from 'data-source'; // 수정된 경로를 입력
import { Topic } from '../dto/topic.entity'; // 올바른 경로로 수정
import { config } from 'dotenv';

config();

async function seed() {
  try {
    await dataSource.initialize();
    
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
      await dataSource.getRepository(Topic).save(topic); // getRepository()를 사용하여 Topic 저장
    }

    console.log('Topics seeded successfully');
  } catch (error) {
    console.error('Error seeding topics:', error);
  } finally {
    await dataSource.destroy(); // 데이터베이스 연결 종료
  }
}

seed();
