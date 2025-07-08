import { Module } from '@nestjs/common';
import { SportsParserService } from './services/sports.parser.service';
import { ParserService } from './services/parser.service';
import { RabbitMQModule } from 'src/rabbitmq/rabbitmq.module';
import { EventsParserService } from './services/events.parser.service';

@Module({
  imports: [RabbitMQModule],
  providers: [ParserService, SportsParserService, EventsParserService],
  exports: [SportsParserService, EventsParserService],
})
export class ParserModule {}
