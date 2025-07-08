/*
  Warnings:

  - You are about to drop the column `parentIds` on the `segments` table. All the data in the column will be lost.
  - You are about to drop the column `childIds` on the `sports` table. All the data in the column will be lost.
  - Made the column `segmentId` on table `events` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "events" DROP CONSTRAINT "events_segmentId_fkey";

-- AlterTable
ALTER TABLE "events" ALTER COLUMN "segmentId" SET NOT NULL;

-- AlterTable
ALTER TABLE "segments" DROP COLUMN "parentIds";

-- AlterTable
ALTER TABLE "sports" DROP COLUMN "childIds";

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_segmentId_fkey" FOREIGN KEY ("segmentId") REFERENCES "segments"("fonbetId") ON DELETE RESTRICT ON UPDATE CASCADE;
