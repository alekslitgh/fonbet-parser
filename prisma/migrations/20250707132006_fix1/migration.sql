/*
  Warnings:

  - You are about to drop the `_SportToEvents` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_SportToEvents" DROP CONSTRAINT "_SportToEvents_A_fkey";

-- DropForeignKey
ALTER TABLE "_SportToEvents" DROP CONSTRAINT "_SportToEvents_B_fkey";

-- AlterTable
ALTER TABLE "events" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "tournamentId" INTEGER,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- DropTable
DROP TABLE "_SportToEvents";

-- CreateTable
CREATE TABLE "tournaments" (
    "id" SERIAL NOT NULL,
    "fonbetId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "sportId" INTEGER NOT NULL,
    "childIds" INTEGER[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tournaments_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "tournaments_fonbetId_key" ON "tournaments"("fonbetId");

-- CreateIndex
CREATE INDEX "events_sportId_idx" ON "events"("sportId");

-- CreateIndex
CREATE INDEX "events_tournamentId_idx" ON "events"("tournamentId");

-- CreateIndex
CREATE INDEX "events_startTime_idx" ON "events"("startTime");

-- AddForeignKey
ALTER TABLE "tournaments" ADD CONSTRAINT "tournaments_sportId_fkey" FOREIGN KEY ("sportId") REFERENCES "sports"("fonbetId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_sportId_fkey" FOREIGN KEY ("sportId") REFERENCES "sports"("fonbetId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_tournamentId_fkey" FOREIGN KEY ("tournamentId") REFERENCES "tournaments"("fonbetId") ON DELETE SET NULL ON UPDATE CASCADE;
