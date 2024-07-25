-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 23, 2024 at 06:15 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `petshop`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SemuaTransaksi` ()   BEGIN
    DECLARE total_transaksi INT;
    
    SELECT COUNT(*) INTO total_transaksi 
    FROM detail_transaksi;
    
    IF total_transaksi > 0 THEN
        SELECT * FROM detail_transaksi;
    ELSE
        SELECT 'Tidak ada transaksi yang ditemukan' AS message;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Transaksi_ProdukDanJumla` (IN `ID_Produk` INT, IN `Jumlah` INT)   BEGIN
    DECLARE total_transaksi INT;
    
    SELECT COUNT(*) INTO total_transaksi
    FROM detail_transaksi
    WHERE ID_Produk = p_ID_Produk AND Jumlah = p_Jumlah;
    
    IF total_transaksi > 0 THEN
        SELECT * 
        FROM detail_transaksi
        WHERE ID_Produk = p_ID_Produk AND Jumlah = p_Jumlah;
    ELSE
        SELECT CONCAT('Tidak ada transaksi dengan ID Produk ', p_ID_Produk, ' dan Jumlah ', p_Jumlah) AS message;
    END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `HitungTransaksi` () RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE total_transaksi INT;
    SELECT COUNT(*) INTO total_transaksi FROM detail_transaksi;
    RETURN total_transaksi;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `JumlahTransaksi` (`id_pelanggan` INT, `id_produk` INT) RETURNS INT(11)  BEGIN
    DECLARE jumlah_transaksi INT;
    SELECT COUNT(*)
    INTO jumlah_transaksi
    FROM transaksi t
    JOIN detail_transaksi dt ON t.ID_Transaksi = dt.ID_Transaksi
    WHERE t.ID_Pelanggan = id_pelanggan AND dt.ID_Produk = id_produk;
    RETURN jumlah_transaksi;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `base_view`
-- (See below for the actual view)
--
CREATE TABLE `base_view` (
`ID_Produk` int(11)
,`Nama_Produk` varchar(50)
,`Kategori` varchar(30)
,`Harga` decimal(10,2)
,`Stok` int(11)
,`ID_Supplier` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `detail_transaksi`
--

CREATE TABLE `detail_transaksi` (
  `ID_Detail` int(11) NOT NULL,
  `ID_Transaksi` int(11) DEFAULT NULL,
  `ID_Produk` int(11) DEFAULT NULL,
  `Jumlah` int(11) DEFAULT NULL,
  `Harga_Satuan` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_transaksi`
--

INSERT INTO `detail_transaksi` (`ID_Detail`, `ID_Transaksi`, `ID_Produk`, `Jumlah`, `Harga_Satuan`) VALUES
(8, 1, 1, 2, 50000.00),
(9, 2, 1, 1, 50000.00),
(10, 2, 2, 3, 25000.00),
(11, 3, 3, 1, 50000.00),
(12, 4, 5, 1, 35000.00),
(13, 5, 2, 1, 25000.00),
(14, 6, 9, 2, 20000.00),
(15, 7, 3, 1, 30000.00),
(16, 8, 5, 1, 35000.00),
(17, 9, 4, 2, 75000.00),
(18, 10, 6, 1, 40000.00),
(19, 11, 7, 1, 60000.00),
(20, 12, 8, 1, 45000.00),
(21, 13, 10, 1, 15000.00),
(22, 14, 9, 2, 20000.00),
(23, 15, 10, 2, 15000.00),
(24, 16, 8, 2, 45000.00);

-- --------------------------------------------------------

--
-- Stand-in structure for view `horizontal_view`
-- (See below for the actual view)
--
CREATE TABLE `horizontal_view` (
`ID_Produk` int(11)
,`Nama_Produk` varchar(50)
,`Harga` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `inside_view`
-- (See below for the actual view)
--
CREATE TABLE `inside_view` (
`ID_Produk` int(11)
,`Nama_Produk` varchar(50)
,`Kategori` varchar(30)
,`Harga` decimal(10,2)
,`Stok` int(11)
,`ID_Supplier` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `jadwal`
--

CREATE TABLE `jadwal` (
  `ID_Jadwal` int(11) NOT NULL,
  `ID_Karyawan` int(11) DEFAULT NULL,
  `Hari` varchar(10) DEFAULT NULL,
  `Jam_Mulai` time DEFAULT NULL,
  `Jam_Selesai` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jadwal`
--

INSERT INTO `jadwal` (`ID_Jadwal`, `ID_Karyawan`, `Hari`, `Jam_Mulai`, `Jam_Selesai`) VALUES
(1, 1, 'Senin', '09:00:00', '17:00:00'),
(2, 1, 'Selasa', '09:00:00', '17:00:00'),
(3, 1, 'Rabu', '09:00:00', '17:00:00'),
(4, 1, 'Kamis', '09:00:00', '17:00:00'),
(5, 1, 'Jumat', '09:00:00', '17:00:00'),
(6, 2, 'Senin', '09:00:00', '17:00:00'),
(7, 2, 'Selasa', '09:00:00', '17:00:00'),
(8, 2, 'Jumat', '09:00:00', '17:00:00'),
(9, 3, 'Senin', '09:00:00', '17:00:00'),
(10, 3, 'Selasa', '09:00:00', '17:00:00'),
(11, 3, 'Rabu', '09:00:00', '17:00:00'),
(12, 3, 'Kamis', '09:00:00', '17:00:00'),
(13, 3, 'Jumat', '09:00:00', '17:00:00'),
(14, 4, 'Senin', '09:00:00', '17:00:00'),
(15, 4, 'Selasa', '09:00:00', '17:00:00'),
(16, 4, 'Rabu', '09:00:00', '17:00:00'),
(17, 4, 'Kamis', '09:00:00', '17:00:00'),
(18, 4, 'Jumat', '09:00:00', '17:00:00'),
(19, 5, 'Rabu', '09:00:00', '17:00:00'),
(20, 5, 'Kamis', '09:00:00', '17:00:00'),
(21, 6, 'Senin', '09:00:00', '17:00:00'),
(22, 6, 'Selasa', '09:00:00', '17:00:00'),
(23, 6, 'Rabu', '09:00:00', '17:00:00'),
(24, 6, 'Kamis', '09:00:00', '17:00:00'),
(25, 6, 'Jumat', '09:00:00', '17:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `ID_Karyawan` int(11) NOT NULL,
  `Nama` varchar(50) DEFAULT NULL,
  `Jabatan` varchar(30) DEFAULT NULL,
  `Alamat` varchar(100) DEFAULT NULL,
  `No_Telepon` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `karyawan`
--

INSERT INTO `karyawan` (`ID_Karyawan`, `Nama`, `Jabatan`, `Alamat`, `No_Telepon`) VALUES
(1, 'Andi Wijaya', 'Groomer', 'Depok, Yogyakarta', '081234567890'),
(2, 'Dina Rahmawati', 'Kasir', 'Kota Yogyakarta, Yogyakarta', '082345678901'),
(3, 'Budiono Siregar', 'Manajer Toko', 'Depok, Yogyakarta', '083456789012'),
(4, 'Hamdika Putra', 'Dokter Hewan', 'Godean, Yogyakarta', '084567890123'),
(5, 'Wahyu Tri Nurahman', 'Kasir', 'Kalasan, Yogyakarta', '085678901234'),
(6, 'Satria Mahatir', 'Admin', 'Depok, Yogyakarta', '083123456789'),
(7, 'Ahmad Santoso', 'Asisten Manager', 'Jl. Melati No. 10, Jakarta', '081234567890'),
(8, 'Budi Setiawan', 'Admin2', 'Jl. Mawar No. 5, Bandung', '082345678901'),
(9, 'Cindy Wijaya', 'Groomer', 'Jl. Anggrek No. 8, Surabaya', '083456789012'),
(10, 'Dewi Sartika', 'Dokter', 'Jl. Kenanga No. 15, Yogyakarta', '084567890123');

-- --------------------------------------------------------

--
-- Table structure for table `membership`
--

CREATE TABLE `membership` (
  `ID_Membership` int(11) NOT NULL,
  `ID_Pelanggan` int(11) DEFAULT NULL,
  `Tipe_Membership` varchar(20) DEFAULT NULL,
  `Tanggal_Bergabung` date DEFAULT NULL,
  `Tanggal_Berakhir` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `membership`
--

INSERT INTO `membership` (`ID_Membership`, `ID_Pelanggan`, `Tipe_Membership`, `Tanggal_Bergabung`, `Tanggal_Berakhir`) VALUES
(1, 1, 'Gold', '2024-01-01', '2025-12-31'),
(2, 2, 'Silver', '2024-03-15', '2025-03-14'),
(3, 3, 'Platinum', '2024-03-01', '2025-03-29'),
(4, 4, 'Silver', '2024-05-01', '2025-05-31'),
(5, 5, 'Gold', '2024-06-01', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `ID_Pelanggan` int(11) NOT NULL,
  `Nama` varchar(50) DEFAULT NULL,
  `Alamat` varchar(100) DEFAULT NULL,
  `No_Telepon` varchar(20) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`ID_Pelanggan`, `Nama`, `Alamat`, `No_Telepon`, `Email`) VALUES
(1, 'Fiola Utri Aulya', 'Sleman, Yogyakarta', '081233334444', 'fiolautri@gmail.com'),
(2, 'Eliezer Victor Wowiling', 'Gamping, Yogyakarta', '082122223333', 'ezerwowiling@gmail.com'),
(3, 'Muhamad Hidayatul Fadillah', 'Depok, Yogyakarta', '085788889999', 'mhidayatulf@gmail.com'),
(4, 'Royan Ristu Prayoga', 'Kalasan, Yogyakarta', '083122223333', 'royanristup@gmail.com'),
(5, 'Nofia', 'Berbah, Yogyakarta', '082344445555', 'nofiarahma@gmail.com'),
(6, 'Zara', 'Jln.2 CondongCatur', '81457001998', 'zara123@gmail.com'),
(7, 'Josua', 'Jln.Pagerkukuh', '081234567890', 'Josua99@gmail.com'),
(8, 'Maura', 'Jln.Mawar No.10', '081234567891', 'Maura.44@gmail.com'),
(9, 'Asep', 'Sleman', '081234567892', 'Asep_55@gmail.com'),
(10, 'Jojo', 'Jln.Budiman', '081234567893', 'J0J0@gmail.com');

--
-- Triggers `pelanggan`
--
DELIMITER $$
CREATE TRIGGER `new_pelanggan` BEFORE INSERT ON `pelanggan` FOR EACH ROW BEGIN
    DECLARE id_pelanggan INT;
    -- Cek apakah ID_Pelanggan sudah ada
    SELECT ID_Pelanggan INTO id_pelanggan
    FROM pelanggan
    WHERE ID_Pelanggan = NEW.ID_Pelanggan;
    END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_pelanggan` BEFORE UPDATE ON `pelanggan` FOR EACH ROW BEGIN
    DECLARE id_pelanggan INT;
    SELECT ID_Pelanggan INTO id_pelanggan
    FROM pelanggan
    WHERE ID_Pelanggan = NEW.ID_Pelanggan AND ID_Pelanggan != OLD.ID_Pelanggan;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pelayanan`
--

CREATE TABLE `pelayanan` (
  `ID_Pelayanan` int(11) NOT NULL,
  `jenis_pelayanan` varchar(50) NOT NULL,
  `hewan` varchar(50) NOT NULL,
  `harga` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `ID_Produk` int(11) NOT NULL,
  `Nama_Produk` varchar(50) DEFAULT NULL,
  `Kategori` varchar(30) DEFAULT NULL,
  `Harga` decimal(10,2) DEFAULT NULL,
  `Stok` int(11) DEFAULT NULL,
  `ID_Supplier` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`ID_Produk`, `Nama_Produk`, `Kategori`, `Harga`, `Stok`, `ID_Supplier`) VALUES
(1, 'Makanan Kucing', 'Makanan', 50000.00, 80, 1),
(2, 'Mainan Kucing', 'Aksesoris', 25000.00, 20, 2),
(3, 'Pasir Kucing', 'Aksesoris', 30000.00, 50, 4),
(4, 'Makanan Anjing', 'Makanan', 75000.00, 80, 1),
(5, 'Kalung Anjing', 'Aksesoris', 35000.00, 20, 2),
(6, 'Shampoo Anjing', 'Obat', 40000.00, 50, 5),
(7, 'Vitamin Hewan', 'Obat', 60000.00, 100, 3),
(8, 'Obat Cacing', 'Obat', 45000.00, 20, 3),
(9, 'Tempat Makan Kucing', 'Aksesoris', 20000.00, 30, 4),
(10, 'Sisir Anjing', 'Aksesoris', 15000.00, 45, 4),
(11, 'Makanan Ikan', 'Makanan', 10000.00, 50, 4),
(12, 'Makanan Hamster', 'Makanan', 15000.00, 50, 2);

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `ID_Supplier` int(11) NOT NULL,
  `Nama_Supplier` varchar(50) DEFAULT NULL,
  `Alamat` varchar(100) DEFAULT NULL,
  `No_Telepon` varchar(20) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`ID_Supplier`, `Nama_Supplier`, `Alamat`, `No_Telepon`, `Email`) VALUES
(1, 'Jogja Pet Supplies', 'Jl. Malioboro No. 111, Yogyakarta', '0274-1234567', 'info@jogjasupp.com'),
(2, 'Jogja Furry Friends', 'Jl. Affandi No. 222, Yogyakarta', '0274-2345678', 'orders@jogjafurfriends.com'),
(3, 'Jogja Paws for Health', 'Jl. Pandanaran No. 333, Yogyakarta', '0274-3456789', 'support@jogjapaws.com'),
(4, 'Jogja Animalia Solutions', 'Jl. Gejayan No. 444, Yogyakarta', '0274-4567890', 'contact@jogjaanimaliasolns.com'),
(5, 'Jogja Petcare Essentials', 'Jl. Laksda Adisucipto No. 555, Yogyakarta', '0274-5678901', 'info@jogjapetcare.com');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `ID_Transaksi` int(11) NOT NULL,
  `ID_Pelanggan` int(11) DEFAULT NULL,
  `ID_Karyawan` int(11) DEFAULT NULL,
  `Tanggal_Transaksi` datetime DEFAULT NULL,
  `Total_Harga` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`ID_Transaksi`, `ID_Pelanggan`, `ID_Karyawan`, `Tanggal_Transaksi`, `Total_Harga`) VALUES
(1, 1, 2, '2024-02-18 10:30:00', 100000.00),
(2, 2, 2, '2024-04-15 14:00:00', 175000.00),
(3, 3, 4, '2024-04-27 16:45:00', 50000.00),
(4, 4, 4, '2024-06-10 14:20:00', 35000.00),
(5, 1, 2, '2024-06-20 16:30:00', 25000.00),
(6, 5, 4, '2024-06-27 11:00:00', 40000.00),
(7, 3, 7, '2024-07-01 00:00:00', 30000.00),
(8, 5, 1, '2024-07-02 00:00:00', 35000.00),
(9, 2, 4, '2024-07-03 00:00:00', 150000.00),
(10, 8, 3, '2024-07-04 00:00:00', 40000.00),
(11, 1, 10, '2024-07-05 00:00:00', 60000.00),
(12, 7, 6, '2024-07-06 00:00:00', 45000.00),
(13, 9, 2, '2024-07-07 00:00:00', 15000.00),
(14, 10, 9, '2024-07-08 00:00:00', 40000.00),
(15, 4, 8, '2024-07-09 00:00:00', 30000.00),
(16, 6, 5, '2024-07-10 00:00:00', 90000.00);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vertical_view`
-- (See below for the actual view)
--
CREATE TABLE `vertical_view` (
`ID_Produk` int(11)
,`Nama_Produk` varchar(50)
,`Kategori` varchar(30)
,`Harga` decimal(10,2)
,`Stok` int(11)
,`ID_Supplier` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `base_view`
--
DROP TABLE IF EXISTS `base_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `base_view`  AS SELECT `produk`.`ID_Produk` AS `ID_Produk`, `produk`.`Nama_Produk` AS `Nama_Produk`, `produk`.`Kategori` AS `Kategori`, `produk`.`Harga` AS `Harga`, `produk`.`Stok` AS `Stok`, `produk`.`ID_Supplier` AS `ID_Supplier` FROM `produk` WHERE `produk`.`Kategori` = 'Makanan' ;

-- --------------------------------------------------------

--
-- Structure for view `horizontal_view`
--
DROP TABLE IF EXISTS `horizontal_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `horizontal_view`  AS SELECT `produk`.`ID_Produk` AS `ID_Produk`, `produk`.`Nama_Produk` AS `Nama_Produk`, `produk`.`Harga` AS `Harga` FROM `produk` ;

-- --------------------------------------------------------

--
-- Structure for view `inside_view`
--
DROP TABLE IF EXISTS `inside_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `inside_view`  AS SELECT `base_view`.`ID_Produk` AS `ID_Produk`, `base_view`.`Nama_Produk` AS `Nama_Produk`, `base_view`.`Kategori` AS `Kategori`, `base_view`.`Harga` AS `Harga`, `base_view`.`Stok` AS `Stok`, `base_view`.`ID_Supplier` AS `ID_Supplier` FROM `base_view`WITH LOCAL CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `vertical_view`
--
DROP TABLE IF EXISTS `vertical_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vertical_view`  AS SELECT `produk`.`ID_Produk` AS `ID_Produk`, `produk`.`Nama_Produk` AS `Nama_Produk`, `produk`.`Kategori` AS `Kategori`, `produk`.`Harga` AS `Harga`, `produk`.`Stok` AS `Stok`, `produk`.`ID_Supplier` AS `ID_Supplier` FROM `produk` WHERE `produk`.`Harga` > 50000 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD PRIMARY KEY (`ID_Detail`),
  ADD KEY `ID_Transaksi` (`ID_Transaksi`),
  ADD KEY `ID_Produk` (`ID_Produk`);

--
-- Indexes for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD PRIMARY KEY (`ID_Jadwal`),
  ADD KEY `ID_Karyawan` (`ID_Karyawan`);

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`ID_Karyawan`);

--
-- Indexes for table `membership`
--
ALTER TABLE `membership`
  ADD PRIMARY KEY (`ID_Membership`),
  ADD KEY `ID_Pelanggan` (`ID_Pelanggan`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`ID_Pelanggan`);

--
-- Indexes for table `pelayanan`
--
ALTER TABLE `pelayanan`
  ADD PRIMARY KEY (`ID_Pelayanan`),
  ADD UNIQUE KEY `idx_hewan` (`hewan`),
  ADD UNIQUE KEY `idx_harga` (`harga`),
  ADD KEY `jenis_pelayanan` (`jenis_pelayanan`),
  ADD KEY `hewan` (`hewan`,`harga`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`ID_Produk`),
  ADD KEY `ID_Supplier` (`ID_Supplier`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`ID_Supplier`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`ID_Transaksi`),
  ADD KEY `ID_Pelanggan` (`ID_Pelanggan`),
  ADD KEY `ID_Karyawan` (`ID_Karyawan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  MODIFY `ID_Detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `jadwal`
--
ALTER TABLE `jadwal`
  MODIFY `ID_Jadwal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `karyawan`
--
ALTER TABLE `karyawan`
  MODIFY `ID_Karyawan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `membership`
--
ALTER TABLE `membership`
  MODIFY `ID_Membership` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `ID_Pelanggan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `pelayanan`
--
ALTER TABLE `pelayanan`
  MODIFY `ID_Pelayanan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `ID_Produk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `ID_Supplier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `ID_Transaksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD CONSTRAINT `detail_transaksi_ibfk_1` FOREIGN KEY (`ID_Transaksi`) REFERENCES `transaksi` (`ID_Transaksi`),
  ADD CONSTRAINT `detail_transaksi_ibfk_2` FOREIGN KEY (`ID_Produk`) REFERENCES `produk` (`ID_Produk`);

--
-- Constraints for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD CONSTRAINT `jadwal_ibfk_1` FOREIGN KEY (`ID_Karyawan`) REFERENCES `karyawan` (`ID_Karyawan`);

--
-- Constraints for table `membership`
--
ALTER TABLE `membership`
  ADD CONSTRAINT `membership_ibfk_1` FOREIGN KEY (`ID_Pelanggan`) REFERENCES `pelanggan` (`ID_Pelanggan`);

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `produk_ibfk_1` FOREIGN KEY (`ID_Supplier`) REFERENCES `supplier` (`ID_Supplier`);

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`ID_Pelanggan`) REFERENCES `pelanggan` (`ID_Pelanggan`),
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`ID_Karyawan`) REFERENCES `karyawan` (`ID_Karyawan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
