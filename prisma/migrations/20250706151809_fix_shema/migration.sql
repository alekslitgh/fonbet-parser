/*
  Warnings:

  - Changed the type of `groupType` on the `BetGroup` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `outcomeType` on the `Outcome` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "BetGroup" DROP COLUMN "groupType",
ADD COLUMN     "groupType" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Outcome" DROP COLUMN "outcomeType",
ADD COLUMN     "outcomeType" TEXT NOT NULL;

-- DropEnum
DROP TYPE "BetGroupType";

-- DropEnum
DROP TYPE "OutcomeType";

-- CreateIndex
CREATE INDEX "BetGroup_groupType_idx" ON "BetGroup"("groupType");

-- CreateIndex
CREATE INDEX "Outcome_outcomeType_idx" ON "Outcome"("outcomeType");
