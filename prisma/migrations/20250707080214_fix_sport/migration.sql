/*
  Warnings:

  - You are about to drop the column `isLive` on the `events` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `events` table. All the data in the column will be lost.
  - You are about to drop the column `parentId` on the `events` table. All the data in the column will be lost.
  - You are about to drop the column `parentIds` on the `events` table. All the data in the column will be lost.
  - You are about to drop the column `sportMeta` on the `events` table. All the data in the column will be lost.
  - You are about to drop the column `tournament` on the `events` table. All the data in the column will be lost.
  - You are about to drop the `sport_segments` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "bet_groups" DROP CONSTRAINT "bet_groups_eventId_fkey";

-- DropForeignKey
ALTER TABLE "events" DROP CONSTRAINT "events_parentId_fkey";

-- DropForeignKey
ALTER TABLE "sport_segments" DROP CONSTRAINT "sport_segments_parentSportId_fkey";

-- DropIndex
DROP INDEX "events_parentId_idx";

-- AlterTable
ALTER TABLE "events" DROP COLUMN "isLive",
DROP COLUMN "name",
DROP COLUMN "parentId",
DROP COLUMN "parentIds",
DROP COLUMN "sportMeta",
DROP COLUMN "tournament",
ADD COLUMN     "segmentId" INTEGER;

-- AlterTable
ALTER TABLE "sports" ALTER COLUMN "alias" DROP NOT NULL;

-- DropTable
DROP TABLE "sport_segments";

-- CreateTable
CREATE TABLE "segments" (
    "id" SERIAL NOT NULL,
    "fonbetId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "parentId" INTEGER NOT NULL,
    "parentIds" INTEGER[],

    CONSTRAINT "segments_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "segments_fonbetId_key" ON "segments"("fonbetId");

-- AddForeignKey
ALTER TABLE "segments" ADD CONSTRAINT "segments_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "sports"("fonbetId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_segmentId_fkey" FOREIGN KEY ("segmentId") REFERENCES "segments"("fonbetId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_sportId_fkey" FOREIGN KEY ("sportId") REFERENCES "sports"("fonbetId") ON DELETE RESTRICT ON UPDATE CASCADE;
