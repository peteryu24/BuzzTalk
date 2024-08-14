import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ChatsModule } from './chats.module';
import { RoomRepository } from './repository/room.repository';
import { TopicRepository } from './repository/topic.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { config } from 'dotenv';
import { Room } from './dto/room.entity';
import { Topic } from './dto/topic.entity';
import { SnakeNamingStrategy } from 'typeorm-naming-strategies';
import { PlayerRepository } from './repository/player.repository';
import { Player } from './dto/player.entity';

config();
@Module({
  imports: [
    ChatsModule,
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        type: 'postgres',
        host: configService.get<string>('DB_HOST', 'localhost'),  // 환경 변수 DB_HOST에서 값 가져오기, 기본값 'localhost'
        port: configService.get<number>('DB_PORT', 3000),          // 환경 변수 DB_PORT에서 값 가져오기, 기본값 5432
        username: configService.get<string>('DB_USERNAME', 'postgres'), // 환경 변수 DB_USERNAME에서 값 가져오기
        password: configService.get<string>('DB_PASSWORD', '1234'), // 환경 변수 DB_PASSWORD에서 값 가져오기
        database: configService.get<string>('DB_DATABASE', 'test'),
        entities: [Room, Topic, Player],
        synchronize: true,
        namingStrategy: new SnakeNamingStrategy(),
        timezone: 'UTC',
      }),
      inject: [ConfigService],
    }),
  ],
  controllers: [AppController],
  providers: [AppService, RoomRepository, TopicRepository, PlayerRepository],
})
export class AppModule {}
