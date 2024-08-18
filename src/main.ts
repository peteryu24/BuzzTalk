import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import session from 'express-session';
import * as passport from 'passport';
import Redis from 'ioredis';
import connectRedis from 'connect-redis';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.setGlobalPrefix('api');

  const RedisStore = require("connect-redis").default; //new아니라 최신버전에서는 이런식으로 
  const redisClient = new Redis({
    host: 'localhost',
    port: 6379,
  });

  // 세션 미들웨어 설정
  app.use(
    session({
      store: new RedisStore({ client: redisClient }),
      secret: 'SECRETKEY',
      resave: false,
      saveUninitialized: false,
      cookie: { secure: false },
    }),
  );

  await app.listen(3000);
}

bootstrap();
