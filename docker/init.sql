-- init.sql

-- CREATE DATABASE yetkisi için bir rol oluşturun
CREATE ROLE normal_user CREATEDB LOGIN PASSWORD 'normal_user_123';

-- Veritabanına erişim izinlerini tanımlayın
GRANT CONNECT ON DATABASE prisma_db TO normal_user;

GRANT USAGE ON SCHEMA public TO normal_user;

-- GRANT
-- SELECT, INSERT,
-- UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO normal_user;

GRANT ALL ON SCHEMA public TO normal_user;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT
SELECT, INSERT,
UPDATE, DELETE ON TABLES TO normal_user;