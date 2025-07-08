/*
  Warnings:

  - You are about to drop the column `parentId` on the `events` table. All the data in the column will be lost.
  - You are about to drop the column `substituteRootEvent` on the `events` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "events" DROP CONSTRAINT "events_parentId_fkey";

-- AlterTable
ALTER TABLE "events" DROP COLUMN "parentId",
DROP COLUMN "substituteRootEvent";
