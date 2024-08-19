import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import session from 'express-session';
import * as passport from 'passport';
import Redis from 'ioredis';
import connectRedis from 'connect-redis';
import cors from 'cors'; // 여기를 변경

async function bootstrap() {
  const app = await NestFactory.create(AppModule);



  const RedisStore = require("connect-redis").default;
  const redisClient = new Redis({
    host: 'localhost',
    port: 6379,
  });

  // CORS 설정 추가
  app.use(cors({
    origin: 'http://localhost:3000', // 필요한 도메인으로 변경
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    credentials: true,
  }));

  // 요청을 확인하는 미들웨어 추가
  app.use((req, res, next) => {
    console.log(`Request received: ${req.method} ${req.url}`);
    next();
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