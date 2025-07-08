/*
  Warnings:

  - You are about to drop the column `createdAt` on the `events` table. All the data in the column will be lost.
  - You are about to drop the column `tournamentId` on the `events` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `events` table. All the data in the column will be lost.
  - You are about to drop the `tournaments` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "events" DROP CONSTRAINT "events_sportId_fkey";

-- DropForeignKey
ALTER TABLE "events" DROP CONSTRAINT "events_tournamentId_fkey";

-- DropForeignKey
ALTER TABLE "tournaments" DROP CONSTRAINT "tournaments_sportId_fkey";

-- DropIndex
DROP INDEX "events_sportId_idx";

-- DropIndex
DROP INDEX "events_startTime_idx";

-- DropIndex
DROP INDEX "events_tournamentId_idx";

-- AlterTable
ALTER TABLE "events" DROP COLUMN "createdAt",
DROP COLUMN "tournamentId",
DROP COLUMN "updatedAt";

-- DropTable
DROP TABLE "tournaments";

-- CreateTable
CREATE TABLE "_SportToEvents" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_SportToEvents_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "_SportToEvents_B_index" ON "_SportToEvents"("B");

-- AddForeignKey
ALTER TABLE "_SportToEvents" ADD CONSTRAINT "_SportToEvents_A_fkey" FOREIGN KEY ("A") REFERENCES "events"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_SportToEvents" ADD CONSTRAINT "_SportToEvents_B_fkey" FOREIGN KEY ("B") REFERENCES "sports"("id") ON DELETE CASCADE ON UPDATE CASCADE;
