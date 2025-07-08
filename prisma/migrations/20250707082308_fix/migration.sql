/*
  Warnings:

  - You are about to drop the `bet_groups` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `outcomes` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "outcomes" DROP CONSTRAINT "outcomes_betGroupId_fkey";

-- DropTable
DROP TABLE "bet_groups";

-- DropTable
DROP TABLE "outcomes";
