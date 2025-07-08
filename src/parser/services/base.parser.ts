import puppeteer from 'puppeteer';
import { ImportItem, ImportOptions, ParserConfig } from '../interfaces';

export abstract class BaseParser {
  protected config: ParserConfig;

  constructor(config: ParserConfig) {
    this.config = config;
  }

  protected async fetchApiUrl(): Promise<string | null> {
    const browser = await puppeteer.launch({
      headless: true,
      args: ['--no-sandbox', '--disable-setuid-sandbox'],
      timeout: 30000,
    });
    const page = await browser.newPage();
    let foundUrl: string | null = null;

    page.on('request', (request) => {
      const url = request.url();
      if (url.includes(this.config.apiEndpoint) && !foundUrl) {
        foundUrl = url;
      }
    });

    await page.goto(this.config.url, { waitUntil: 'networkidle2' });
    await new Promise((resolve) => setTimeout(resolve, this.config.delay));
    await browser.close();

    return foundUrl;
  }

  protected async importItems<T extends ImportItem>(
    items: T[],
    options: ImportOptions<T>,
  ): Promise<void> {
    const filteredItems = items.filter(options.filterCondition);

    for (const item of filteredItems) {
      let relatedItems: T[] = [];

      if (options.parentRelation) {
        relatedItems = items.filter(
          (i) =>
            i[options.parentRelation!.field] ===
            item[options.parentRelation!.field],
        );
      }

      await options.upsertData(item, relatedItems);
    }
  }
}
