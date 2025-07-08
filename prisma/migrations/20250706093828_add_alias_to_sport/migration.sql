/*
  Warnings:

  - A unique constraint covering the columns `[name,alias]` on the table `sports` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "sports" ADD COLUMN     "alias" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "sports_name_alias_key" ON "sports"("name", "alias");
