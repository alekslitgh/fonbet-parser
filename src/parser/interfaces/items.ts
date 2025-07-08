export interface ImportItem {
  id: number;
  name: string;
  kind: string;
  parentId?: number;
  [key: string]: any;
}

export interface ImportOptions<T extends ImportItem> {
  filterCondition: (item: T) => boolean;
  parentRelation?: {
    field: keyof T;
    value: T[keyof T];
  };
  upsertData: (item: T, relatedItems: T[]) => any;
}
