-- DropForeignKey
ALTER TABLE "events" DROP CONSTRAINT "events_sportId_fkey";

-- CreateTable
CREATE TABLE "sport_segments" (
    "id" SERIAL NOT NULL,
    "fonbetId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "parentSportId" INTEGER NOT NULL,

    CONSTRAINT "sport_segments_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "sport_segments_fonbetId_key" ON "sport_segments"("fonbetId");

-- AddForeignKey
ALTER TABLE "sport_segments" ADD CONSTRAINT "sport_segments_parentSportId_fkey" FOREIGN KEY ("parentSportId") REFERENCES "sports"("fonbetId") ON DELETE RESTRICT ON UPDATE CASCADE;
