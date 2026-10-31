-- 1. Buat Skema SALAM
CREATE SCHEMA IF NOT EXISTS "SALAM";

-- 2. Buat Tabel mahasiswas dengan Constraint (PK, Unique, Check)
CREATE TABLE "SALAM".mahasiswas (
    id SERIAL PRIMARY KEY,                          -- Primary Key Constraint
    nim VARCHAR(10) NOT NULL UNIQUE,                -- Unique Constraint 1
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,             -- Unique Constraint 2
    umur INT CHECK (umur >= 17 AND umur <= 60),     -- Check Constraint 1
    ipk NUMERIC(3,2) CHECK (ipk >= 0.00 AND ipk <= 4.00), -- Check Constraint 2
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- A. Uji Data Valid (Harus Berhasil)
INSERT INTO "SALAM".mahasiswas (nim, nama, email, umur, ipk) 
VALUES ('2026036', 'Yulqi Aulia', 'yulqi@mail.com', 20, 3.85);

-- B. Uji Unique Constraint (Gagal karena NIM '2026036' Sudah Ada)
INSERT INTO "SALAM".mahasiswas (nim, nama, email, umur, ipk) 
VALUES ('2026036', 'Budi Santoso', 'budi@mail.com', 21, 3.50);

-- C. Uji Check Constraint Umur (Gagal karena Umur 15 < 17)
INSERT INTO "SALAM".mahasiswas (nim, nama, email, umur, ipk) 
VALUES ('2026037', 'Siti Aminah', 'siti@mail.com', 15, 3.80);

-- D. Uji Check Constraint IPK (Gagal karena IPK 4.50 > 4.00)
INSERT INTO "SALAM".mahasiswas (nim, nama, email, umur, ipk) 
VALUES ('2026038', 'Rudi Hermawan', 'rudi@mail.com', 22, 4.50);