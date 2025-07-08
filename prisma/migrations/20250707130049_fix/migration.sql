-- CreateTable
CREATE TABLE "events" (
    "id" SERIAL NOT NULL,
    "fonbetId" INTEGER NOT NULL,
    "sortOrder" TEXT NOT NULL,
    "level" INTEGER NOT NULL,
    "num" INTEGER NOT NULL,
    "sportId" INTEGER NOT NULL,
    "kind" INTEGER NOT NULL,
    "rootKind" INTEGER NOT NULL,
    "team1Id" INTEGER,
    "team2Id" INTEGER,
    "team1" TEXT,
    "team2" TEXT,
    "name" TEXT,
    "startTime" INTEGER NOT NULL,
    "place" TEXT NOT NULL,
    "priority" INTEGER NOT NULL,
    "parentId" INTEGER,
    "substituteRootEvent" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_SportToEvents" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_SportToEvents_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "events_fonbetId_key" ON "events"("fonbetId");

-- CreateIndex
CREATE INDEX "_SportToEvents_B_index" ON "_SportToEvents"("B");

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "events"("fonbetId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_SportToEvents" ADD CONSTRAINT "_SportToEvents_A_fkey" FOREIGN KEY ("A") REFERENCES "events"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_SportToEvents" ADD CONSTRAINT "_SportToEvents_B_fkey" FOREIGN KEY ("B") REFERENCES "sports"("id") ON DELETE CASCADE ON UPDATE CASCADE;
