-- AlterTable
ALTER TABLE "sports" ADD COLUMN     "parentId" INTEGER;

-- AddForeignKey
ALTER TABLE "sports" ADD CONSTRAINT "sports_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "sports"("id") ON DELETE SET NULL ON UPDATE CASCADE;
