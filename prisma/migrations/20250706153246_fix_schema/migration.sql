/*
  Warnings:

  - You are about to drop the `BetGroup` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Outcome` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "BetGroup" DROP CONSTRAINT "BetGroup_eventId_fkey";

-- DropForeignKey
ALTER TABLE "Outcome" DROP CONSTRAINT "Outcome_betGroupId_fkey";

-- DropForeignKey
ALTER TABLE "events" DROP CONSTRAINT "events_parentId_fkey";

-- AlterTable
ALTER TABLE "events" ALTER COLUMN "team1" DROP NOT NULL;

-- DropTable
DROP TABLE "BetGroup";

-- DropTable
DROP TABLE "Outcome";

-- CreateTable
CREATE TABLE "bet_groups" (
    "id" SERIAL NOT NULL,
    "eventId" INTEGER NOT NULL,
    "groupType" TEXT,

    CONSTRAINT "bet_groups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "outcomes" (
    "id" SERIAL NOT NULL,
    "betGroupId" INTEGER NOT NULL,
    "outcomeType" TEXT,
    "value" TEXT,
    "odd" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "outcomes_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "bet_groups_eventId_idx" ON "bet_groups"("eventId");

-- CreateIndex
CREATE INDEX "bet_groups_groupType_idx" ON "bet_groups"("groupType");

-- CreateIndex
CREATE INDEX "outcomes_betGroupId_idx" ON "outcomes"("betGroupId");

-- CreateIndex
CREATE INDEX "outcomes_outcomeType_idx" ON "outcomes"("outcomeType");

-- CreateIndex
CREATE INDEX "outcomes_odd_idx" ON "outcomes"("odd");

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "events"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bet_groups" ADD CONSTRAINT "bet_groups_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "events"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "outcomes" ADD CONSTRAINT "outcomes_betGroupId_fkey" FOREIGN KEY ("betGroupId") REFERENCES "bet_groups"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
