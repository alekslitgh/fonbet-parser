-- CreateEnum
CREATE TYPE "BetGroupType" AS ENUM ('MAIN', 'DOUBLE_CHANCE', 'HANDICAP', 'TOTAL', 'PLAYER_STATS', 'PERIOD', 'SPECIAL');

-- CreateEnum
CREATE TYPE "OutcomeType" AS ENUM ('HOME_WIN', 'DRAW', 'AWAY_WIN', 'HOME_DRAW', 'HOME_AWAY', 'AWAY_DRAW', 'OVER', 'UNDER', 'CUSTOM');

-- CreateTable
CREATE TABLE "sports" (
    "id" SERIAL NOT NULL,
    "fonbetId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "sports_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "events" (
    "id" SERIAL NOT NULL,
    "fonbetId" INTEGER NOT NULL,
    "parentId" INTEGER,
    "sportId" INTEGER NOT NULL,
    "team1" TEXT NOT NULL,
    "team2" TEXT,
    "name" TEXT,
    "startTime" TIMESTAMP(3) NOT NULL,
    "isLive" BOOLEAN NOT NULL DEFAULT false,
    "tournament" TEXT,
    "sportMeta" JSONB,

    CONSTRAINT "events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BetGroup" (
    "id" SERIAL NOT NULL,
    "eventId" INTEGER NOT NULL,
    "groupType" "BetGroupType" NOT NULL,

    CONSTRAINT "BetGroup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Outcome" (
    "id" SERIAL NOT NULL,
    "betGroupId" INTEGER NOT NULL,
    "outcomeType" "OutcomeType" NOT NULL,
    "value" TEXT,
    "odd" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "Outcome_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "sports_fonbetId_key" ON "sports"("fonbetId");

-- CreateIndex
CREATE INDEX "sports_fonbetId_idx" ON "sports"("fonbetId");

-- CreateIndex
CREATE UNIQUE INDEX "events_fonbetId_key" ON "events"("fonbetId");

-- CreateIndex
CREATE INDEX "events_fonbetId_idx" ON "events"("fonbetId");

-- CreateIndex
CREATE INDEX "events_parentId_idx" ON "events"("parentId");

-- CreateIndex
CREATE INDEX "events_sportId_idx" ON "events"("sportId");

-- CreateIndex
CREATE INDEX "BetGroup_eventId_idx" ON "BetGroup"("eventId");

-- CreateIndex
CREATE INDEX "BetGroup_groupType_idx" ON "BetGroup"("groupType");

-- CreateIndex
CREATE INDEX "Outcome_betGroupId_idx" ON "Outcome"("betGroupId");

-- CreateIndex
CREATE INDEX "Outcome_outcomeType_idx" ON "Outcome"("outcomeType");

-- CreateIndex
CREATE INDEX "Outcome_odd_idx" ON "Outcome"("odd");

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_sportId_fkey" FOREIGN KEY ("sportId") REFERENCES "sports"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "events"("fonbetId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BetGroup" ADD CONSTRAINT "BetGroup_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "events"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Outcome" ADD CONSTRAINT "Outcome_betGroupId_fkey" FOREIGN KEY ("betGroupId") REFERENCES "BetGroup"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
