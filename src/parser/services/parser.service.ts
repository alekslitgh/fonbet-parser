import { Injectable, OnModuleInit } from '@nestjs/common';
import { SchedulerRegistry } from '@nestjs/schedule';
import { CronJob } from 'cron';
import { RabbitMQService } from 'src/rabbitmq/rabbitmq.service';

@Injectable()
export class ParserService implements OnModuleInit {
  private isInitialParseDone = false;

  constructor(
    private readonly rabbit: RabbitMQService,
    private readonly scheduler: SchedulerRegistry,
  ) {}

  async onModuleInit() {
    if (!this.isInitialParseDone) {
      await this.rabbit.sendTask({ type: 'initial_parse' });
      this.isInitialParseDone = true;
    }

    const job = new CronJob('0 * * * *', () => {
      this.rabbit.sendTask({ type: 'scheduled_parse' });
    });

    this.scheduler.addCronJob('hourlyParse', job);
    job.start();
  }
}
