import { Module } from '@nestjs/common';
import { RabbitMQService } from './rabbitmq.service';
import { SportsParserService } from 'src/parser/services/sports.parser.service';
import { EventsParserService } from 'src/parser/services/events.parser.service';

@Module({
  providers: [RabbitMQService, SportsParserService, EventsParserService],
  exports: [RabbitMQService],
})
export class RabbitMQModule {}
