-- CreateTable
CREATE TABLE "Company" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,


CONSTRAINT "Company_pkey" PRIMARY KEY ("id") );

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "companyId" INTEGER NOT NULL DEFAULT (current_setting('app.current_tenant_id'::text))::int,


CONSTRAINT "User_pkey" PRIMARY KEY ("id") );

-- AddForeignKey
ALTER TABLE "User"
ADD CONSTRAINT "User_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;

--- Enable RLS on the User table
ALTER TABLE "User" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "User" FORCE ROW LEVEL SECURITY;

--- Create a policy for tenant isolation
CREATE POLICY tenant_isolation_policy ON "User" USING (
    "companyId" = current_setting('app.current_tenant_id')::int
);