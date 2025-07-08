import { Injectable } from '@nestjs/common';
import { BaseParser } from './base.parser';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class SportsParserService extends BaseParser {
  private readonly prisma = new PrismaClient();

  constructor() {
    super({
      url: 'https://fon.bet/sports',
      apiEndpoint: 'events/listBase',
      delay: 10000,
    });
  }

  public async parse(): Promise<boolean> {
    const apiUrl = await this.fetchApiUrl();
    if (!apiUrl) return false;

    console.log('Parsing from url: ', apiUrl);
    const response = await fetch(apiUrl);
    const data = await response.json();

    const allSegments = data.sports.filter((item) => item.kind === 'segment');
    const segmentsByParentId = new Map<number, any[]>();

    allSegments.forEach((segment) => {
      if (segment.parentId) {
        const arr = segmentsByParentId.get(segment.parentId) || [];
        segmentsByParentId.set(segment.parentId, [...arr, segment]);
      }
    });

    await this.importItems(data.sports, {
      filterCondition: (item) => item.kind === 'sport',
      parentRelation: {
        field: 'parentId',
        value: (parentItem) => parentItem.id,
      },
      upsertData: async (sport) => {
        const relatedSegments = segmentsByParentId.get(sport.id) || [];

        await this.prisma.sport.upsert({
          where: { fonbetId: sport.id },
          update: {
            name: sport.name,
            alias: sport.alias,
            childIds: relatedSegments.map((s) => s.id),
          },
          create: {
            fonbetId: sport.id,
            name: sport.name,
            alias: sport.alias,
            childIds: relatedSegments.map((s) => s.id),
          },
        });
      },
    });

    console.log('Sports parsing completed');
    return true;
  }

  async onModuleDestroy() {
    await this.prisma.$disconnect();
  }
}
