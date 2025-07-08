import { Injectable } from '@nestjs/common';
import * as amqp from 'amqp-connection-manager';
import { Channel, Message } from 'amqplib';
import { EventsParserService } from 'src/parser/services/events.parser.service';
import { SportsParserService } from 'src/parser/services/sports.parser.service';

@Injectable()
export class RabbitMQService {
  private channelWrapper: amqp.ChannelWrapper;

  constructor(
    private readonly sportsParser: SportsParserService,
    private readonly eventsParser: EventsParserService,
  ) {
    const connection = amqp.connect(['amqp://localhost']);

    this.channelWrapper = connection.createChannel({
      json: true,
      setup: async (channel: Channel) => {
        await channel.assertQueue('parse_tasks', {
          durable: true,
          arguments: {
            'x-single-active-consumer': true,
          },
        });
        await channel.prefetch(1);
        await channel.consume('parse_tasks', (msg) => this.handleMessage(msg), {
          noAck: false,
        });
      },
    });
  }

  private async handleMessage(msg: Message | null) {
    if (!msg) return;

    try {
      const task = JSON.parse(msg.content.toString());

      const sportsResult = await this.sportsParser.parse();

      if (sportsResult) {
        await this.eventsParser.parse();
      }

      this.channelWrapper.ack(msg);
    } catch (error) {
      console.error('Error processing task:', error);
      this.channelWrapper.nack(msg);
    }
  }

  async sendTask(task: { type: string }) {
    await this.channelWrapper.sendToQueue(
      'parse_tasks',
      Buffer.from(JSON.stringify(task)),
      { persistent: true },
    );
  }

  async onModuleDestroy() {
    await this.channelWrapper.close();
  }
}
