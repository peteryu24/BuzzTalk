import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import session from 'express-session';
import passport from 'passport';
import Redis from 'ioredis';
import connectRedis from 'connect-redis';
import cors from 'cors';
async function bootstrap() {
  const app = await NestFactory.create(AppModule);

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
  app.use(
    cors({
      origin: 'http://localhost:3000', // 클라이언트의 도메인
      credentials: true, // 쿠키를 포함시키기 위해 필요
    }),
  );

  
  app.use(passport.initialize());
  app.use(passport.session());

  await app.listen(3000);
}

bootstrap();


