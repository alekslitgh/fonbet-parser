import { Module } from '@nestjs/common';
import { ScheduleModule } from '@nestjs/schedule';
import { ParserModule } from './parser/parser.module';
import { RabbitMQModule } from './rabbitmq/rabbitmq.module';

@Module({
  imports: [ScheduleModule.forRoot(), RabbitMQModule, ParserModule],
  providers: [],
})
export class AppModule {}
