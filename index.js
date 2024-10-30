import prisma, { forTenant } from "./db.js";

async function createCompany(name) {
  return prisma.company.create({ data: { name } });
}

async function createUser(name, tenantId) {
  const tenantDb1 = prisma.$extends(forTenant(tenantId));

  return tenantDb1.user.create({ data: { name } });
}

async function getUsers(tenantId) {
  const tenantDb1 = prisma.$extends(forTenant(tenantId));

  return tenantDb1.user.findMany();
}

async function main() {
  const [company1, company2] = await Promise.all([
    createCompany("Company 1"),
    createCompany("Company 2"),
  ]);

  await Promise.all([
    createUser("Yavuz Sultan Selim", company1.id),
    createUser("Fatih Sultan Mehmet", company1.id),
    createUser("Kanuni Sultan Süleyman", company2.id),
  ]);

  const [user1, user2] = await Promise.all([
    getUsers(company1.id),
    getUsers(company2.id),
  ]);

  console.log(`Tenant Id: ${company1.id}`, user1);
  console.log(`Tenant Id: ${company2.id}`, user2);
}

main();
