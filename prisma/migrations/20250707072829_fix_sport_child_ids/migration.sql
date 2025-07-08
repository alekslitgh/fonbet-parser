/*
  Warnings:

  - You are about to drop the column `parentId` on the `sports` table. All the data in the column will be lost.
  - Made the column `alias` on table `sports` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "sports" DROP CONSTRAINT "sports_parentId_fkey";

-- AlterTable
ALTER TABLE "sports" DROP COLUMN "parentId",
ADD COLUMN     "childIds" INTEGER[],
ALTER COLUMN "alias" SET NOT NULL;
