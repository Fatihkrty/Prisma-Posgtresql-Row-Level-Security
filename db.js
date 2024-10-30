import { PrismaClient, Prisma } from "@prisma/client";

export function forTenant(tenantId) {
  return Prisma.defineExtension((prisma) =>
    prisma.$extends({
      query: {
        $allModels: {
          async $allOperations({ args, query }) {
            const [, result] = await prisma.$transaction([
              prisma.$executeRaw`SELECT set_config('app.current_tenant_id', ${tenantId}::text, TRUE)`,
              query(args),
            ]);
            console.log("Current Tenant ID:", tenantId);
            return result;
          },
        },
      },
    })
  );
}

const prisma = new PrismaClient({ log: ["query", "info", "warn", "error"] });

export default prisma;
