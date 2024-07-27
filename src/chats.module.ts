import { Module } from '@nestjs/common';
import { ChatsGateway } from './chats.gateway';

@Module({
  providers: [ChatsGateway],
  exports: [],
})
export class ChatsModule {}
