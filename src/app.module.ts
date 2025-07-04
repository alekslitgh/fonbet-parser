import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { RabbitmqModule } from './rabbitmq/rabbitmq.module';
import { CronModule } from './cron/cron.module';
import { ParserService } from './parser/parser.service';
import { ParserModule } from './parser/parser.module';

@Module({
  imports: [PrismaModule, RabbitmqModule, CronModule, ParserModule],
  controllers: [AppController],
  providers: [AppService, ParserService],
})
export class AppModule {}
