/*
  Warnings:

  - You are about to drop the column `tournamentId` on the `events` table. All the data in the column will be lost.
  - You are about to drop the `tournaments` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "events" DROP CONSTRAINT "events_tournamentId_fkey";

-- DropForeignKey
ALTER TABLE "tournaments" DROP CONSTRAINT "tournaments_sportId_fkey";

-- AlterTable
ALTER TABLE "events" DROP COLUMN "tournamentId",
ADD COLUMN     "parentId" INTEGER;

-- DropTable
DROP TABLE "tournaments";

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "events"("fonbetId") ON DELETE SET NULL ON UPDATE CASCADE;
