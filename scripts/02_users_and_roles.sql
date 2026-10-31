-- 1. Buat User Baru 
CREATE USER backend_dev WITH PASSWORD 'BackendPass123!';
CREATE USER bi_dev WITH PASSWORD 'BIPass123!';
CREATE USER data_engineer WITH PASSWORD 'DEPass123!';

-- 2. Berikan Akses Menggunakan Skema SALAM
GRANT USAGE ON SCHEMA "SALAM" TO backend_dev, bi_dev, data_engineer;

-- -------------------------------------------------------------
-- 4.a User: backend_dev (Role: CRUD Semua Tabel)
-- -------------------------------------------------------------
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA "SALAM" TO backend_dev;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA "SALAM" TO backend_dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA "SALAM" GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO backend_dev;

-- -------------------------------------------------------------
-- 4.b User: bi_dev (Role: Hanya READ/SELECT Semua Tabel & View)
-- -------------------------------------------------------------
GRANT SELECT ON ALL TABLES IN SCHEMA "SALAM" TO bi_dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA "SALAM" GRANT SELECT ON TABLES TO bi_dev;

-- -------------------------------------------------------------
-- 4.c User: data_engineer (Role: CREATE, MODIFY, DROP Objects + CRUD Tabel)
-- -------------------------------------------------------------
GRANT ALL PRIVILEGES ON SCHEMA "SALAM" TO data_engineer;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA "SALAM" TO data_engineer;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA "SALAM" TO data_engineer;
ALTER DEFAULT PRIVILEGES IN SCHEMA "SALAM" GRANT ALL ON TABLES TO data_engineer;

-- Pengujian A: bi_dev (Hanya SELECT, Gagal saat INSERT)
SET ROLE bi_dev;
SELECT * FROM "SALAM".mahasiswas;
INSERT INTO "SALAM".mahasiswas (nim, nama, email, umur, ipk) 
VALUES ('2026099', 'Uji BI', 'bi@mail.com', 20, 3.50);
RESET ROLE;

-- Pengujian B: backend_dev (CRUD Berhasil, Gagal saat CREATE TABLE)
SET ROLE backend_dev;
INSERT INTO "SALAM".mahasiswas (nim, nama, email, umur, ipk) 
VALUES ('2026040', 'Backend Tester', 'backend@mail.com', 22, 3.60);
CREATE TABLE "SALAM".tabel_dummy (id INT);
RESET ROLE;

-- Pengujian C: data_engineer (CREATE & DROP TABLE Berhasil)
SET ROLE data_engineer;
CREATE TABLE "SALAM".logs_audit (id SERIAL PRIMARY KEY, aktivitas VARCHAR(100));
DROP TABLE "SALAM".logs_audit;
RESET ROLE;