/*
  Warnings:

  - You are about to drop the column `fonbetId` on the `events` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "events_fonbetId_idx";

-- DropIndex
DROP INDEX "events_fonbetId_key";

-- AlterTable
ALTER TABLE "events" DROP COLUMN "fonbetId";
