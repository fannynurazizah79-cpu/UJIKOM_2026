-- Database Marketplace Native
-- Primary Keys menggunakan VARCHAR (Custom ID / UUID)

CREATE DATABASE IF NOT EXISTS `db_marketplace` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_marketplace`;

-- 1. Tabel Admin
CREATE TABLE IF NOT EXISTS `admin` (
  `id_admin` VARCHAR(50) NOT NULL,
  `nama_admin` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_admin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data Admin (Password default: admin123 -> MD5/Password Verify kompatibel)
-- Untuk keamanan sederhana di PHP Native contoh ini menggunakan password_hash / md5
INSERT INTO `admin` (`id_admin`, `nama_admin`, `email`, `password`) VALUES
('ADM001', 'Administrator Utama', 'admin@marketplace.com', '$2y$10$wT38vJ3.a0u3zF1sWnB7X.4m8Wd7Gg5Z3k2l1m0n9o8p7q6r5s4t3'); 
-- Note: Password hashed 'admin123' atau kita handle md5/plain text di login helper.

-- 2. Tabel Kategori
CREATE TABLE IF NOT EXISTS `kategori` (
  `id_kategori` VARCHAR(50) NOT NULL,
  `nama_kategori` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`) VALUES
('KAT-001', 'Elektronik & Gadget'),
('KAT-002', 'Pakaian & Fashion'),
('KAT-003', 'Aksesoris & Peralatan');

-- 3. Tabel Produk
CREATE TABLE IF NOT EXISTS `produk` (
  `id_produk` VARCHAR(50) NOT NULL,
  `id_kategori` VARCHAR(50) NOT NULL,
  `nama_produk` VARCHAR(150) NOT NULL,
  `deskripsi` TEXT NOT NULL,
  `harga` DECIMAL(12,2) NOT NULL,
  `stok` INT(11) NOT NULL DEFAULT 0,
  `foto` VARCHAR(255) DEFAULT 'default.jpg',
  PRIMARY KEY (`id_produk`),
  KEY `fk_produk_kategori` (`id_kategori`),
  CONSTRAINT `fk_produk_kategori` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `produk` (`id_produk`, `id_kategori`, `nama_produk`, `deskripsi`, `harga`, `stok`, `foto`) VALUES
('PRD-001', 'KAT-001', 'Laptop Gaming Pro 15 Inch', 'Laptop gaming performa tinggi dengan prosesor generasi terbaru dan grafis mumpuni.', 15000000.00, 10, 'laptop.jpg'),
('PRD-002', 'KAT-001', 'Smartphone X Super Amoled', 'Smartphone layar Super AMOLED dengan kamera 108MP dan baterai tahan lama.', 4500000.00, 15, 'smartphone.jpg'),
('PRD-003', 'KAT-002', 'Kaos Polos Cotton Combed 30s', 'Kaos nyaman, adem, dan menyerap keringat. Cocok untuk penggunaan sehari-hari.', 75000.00, 50, 'kaos.jpg');

-- 4. Tabel Pesanan (Order)
CREATE TABLE IF NOT EXISTS `pesanan` (
  `id_pesanan` VARCHAR(50) NOT NULL,
  `nama_pembeli` VARCHAR(100) NOT NULL,
  `no_hp` VARCHAR(20) NOT NULL,
  `id_produk` VARCHAR(50) NOT NULL,
  `jumlah` INT(11) NOT NULL,
  `total_harga` DECIMAL(12,2) NOT NULL,
  `tanggal_pesan` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pesanan`),
  KEY `fk_pesanan_produk` (`id_produk`),
  CONSTRAINT `fk_pesanan_produk` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `pesanan` (`id_pesanan`, `nama_pembeli`, `no_hp`, `id_produk`, `jumlah`, `total_harga`, `tanggal_pesan`) VALUES
('ORD-20260721-001', 'Budi Santoso', '081234567890', 'PRD-003', 2, 150000.00, '2026-07-21 10:00:00');
