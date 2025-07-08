-- AlterTable
ALTER TABLE "events" ADD COLUMN     "tournamentId" INTEGER;

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

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_tournamentId_fkey" FOREIGN KEY ("tournamentId") REFERENCES "tournaments"("fonbetId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tournaments" ADD CONSTRAINT "tournaments_sportId_fkey" FOREIGN KEY ("sportId") REFERENCES "sports"("fonbetId") ON DELETE RESTRICT ON UPDATE CASCADE;
