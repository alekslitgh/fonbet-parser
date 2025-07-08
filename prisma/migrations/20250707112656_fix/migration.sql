/*
  Warnings:

  - You are about to drop the `events` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `segments` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "events" DROP CONSTRAINT "events_segmentId_fkey";

-- DropForeignKey
ALTER TABLE "events" DROP CONSTRAINT "events_sportId_fkey";

-- DropForeignKey
ALTER TABLE "segments" DROP CONSTRAINT "segments_parentId_fkey";

-- DropIndex
DROP INDEX "sports_fonbetId_idx";

-- AlterTable
ALTER TABLE "sports" ADD COLUMN     "childIds" INTEGER[];

-- DropTable
DROP TABLE "events";

-- DropTable
DROP TABLE "segments";
