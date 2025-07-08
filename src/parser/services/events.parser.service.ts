import { Injectable } from '@nestjs/common';
import { BaseParser } from './base.parser';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class EventsParserService extends BaseParser {
  private readonly prisma = new PrismaClient();

  constructor() {
    super({
      url: 'https://fon.bet/sports',
      apiEndpoint: 'events/listBase',
      delay: 10000,
    });
  }

  public async parse(): Promise<boolean> {
    console.log('Starting events parsing...');
    const apiUrl = await this.fetchApiUrl();
    if (!apiUrl) return false;

    console.log('Parsing events from:', apiUrl);
    const response = await fetch(apiUrl);
    const data = await response.json();

    const allSports = await this.prisma.sport.findMany();
    const sportMap = new Map<number, (typeof allSports)[0]>();

    for (const sport of allSports) {
      for (const childId of sport.childIds) {
        sportMap.set(childId, sport);
      }
    }

    for (const event of data.events) {
      try {
        const sport = sportMap.get(event.sportId);

        if (!sport) {
          console.warn(
            `Sport not found for event ${event.id} with sportId ${event.sportId}`,
          );
          continue;
        }

        let parentConnect = {};
        if (event.parentId) {
          parentConnect = {
            parent: {
              connect: {
                fonbetId: event.parentId,
              },
            },
          };
        }

        const eventData = {
          fonbetId: event.id,
          sortOrder: event.sortOrder,
          level: event.level,
          num: event.num,
          sportId: sport.id,
          sports: {
            connect: { id: sport.id },
          },
          kind: event.kind,
          rootKind: event.rootKind,
          team1Id: event.team1Id,
          team2Id: event.team2Id,
          team1: event.team1,
          team2: event.team2,
          name:
            event.name ||
            (event.team1 && event.team2
              ? `${event.team1} vs ${event.team2}`
              : null),
          startTime: new Date(event.startTime),
          place: event.place,
          priority: event.priority,
          ...parentConnect,
        };

        await this.prisma.event.upsert({
          where: { fonbetId: event.id },
          update: eventData,
          create: eventData,
        });
      } catch (error) {
        console.error(`Error processing event ${event.id}:`, error);
      }
    }

    return true;
  }

  async onModuleDestroy() {
    await this.prisma.$disconnect();
  }
}
