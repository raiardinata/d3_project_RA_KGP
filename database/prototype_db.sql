-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.11-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for powerbitable
CREATE DATABASE IF NOT EXISTS `powerbitable` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `powerbitable`;

-- Dumping structure for view powerbitable.force_layout
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `force_layout` (
	`source` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for table powerbitable.inventory_transfer
CREATE TABLE IF NOT EXISTS `inventory_transfer` (
  `id` char(36) NOT NULL,
  `invtrans_name` varchar(255) NOT NULL,
  `date_entered` datetime NOT NULL DEFAULT current_timestamp(),
  `date_modified` datetime DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table powerbitable.inventory_transfer: ~2 rows (approximately)
/*!40000 ALTER TABLE `inventory_transfer` DISABLE KEYS */;
INSERT INTO `inventory_transfer` (`id`, `invtrans_name`, `date_entered`, `date_modified`, `description`) VALUES
	('73020f68-99ab-11ea-bbdc-bcee7b513d25', 'Inventory Transfer B', '2020-05-19 15:33:43', NULL, 'Transfer to Shipping Selling Item A'),
	('e0ca32f1-99aa-11ea-bbdc-bcee7b513d25', 'Inventory Transfer A', '2020-05-19 15:29:38', NULL, 'Transfer to Production Site A');
/*!40000 ALTER TABLE `inventory_transfer` ENABLE KEYS */;

-- Dumping structure for table powerbitable.material
CREATE TABLE IF NOT EXISTS `material` (
  `id` char(36) NOT NULL,
  `mat_name` varchar(255) NOT NULL,
  `date_entered` datetime NOT NULL DEFAULT current_timestamp(),
  `date_modified` datetime DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table powerbitable.material: ~0 rows (approximately)
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` (`id`, `mat_name`, `date_entered`, `date_modified`, `description`) VALUES
	('b7eeca72-99aa-11ea-bbdc-bcee7b513d25', 'Material A', '2020-05-19 15:28:29', NULL, 'Kecap Bango 1 ton');
/*!40000 ALTER TABLE `material` ENABLE KEYS */;

-- Dumping structure for table powerbitable.material_inventorytransfer
CREATE TABLE IF NOT EXISTS `material_inventorytransfer` (
  `id` char(36) NOT NULL,
  `date_entered` datetime NOT NULL DEFAULT current_timestamp(),
  `date_modified` datetime DEFAULT NULL,
  `materialid` char(36) NOT NULL,
  `invtransferid` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table powerbitable.material_inventorytransfer: ~1 rows (approximately)
/*!40000 ALTER TABLE `material_inventorytransfer` DISABLE KEYS */;
INSERT INTO `material_inventorytransfer` (`id`, `date_entered`, `date_modified`, `materialid`, `invtransferid`) VALUES
	('cc739fb7-99ad-11ea-bbdc-bcee7b513d25', '2020-05-19 15:50:32', NULL, 'b7eeca72-99aa-11ea-bbdc-bcee7b513d25', 'e0ca32f1-99aa-11ea-bbdc-bcee7b513d25');
/*!40000 ALTER TABLE `material_inventorytransfer` ENABLE KEYS */;

-- Dumping structure for table powerbitable.production
CREATE TABLE IF NOT EXISTS `production` (
  `id` char(36) NOT NULL,
  `prod_name` varchar(255) NOT NULL,
  `date_entered` datetime NOT NULL DEFAULT current_timestamp(),
  `date_modified` datetime DEFAULT current_timestamp(),
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table powerbitable.production: ~0 rows (approximately)
/*!40000 ALTER TABLE `production` DISABLE KEYS */;
INSERT INTO `production` (`id`, `prod_name`, `date_entered`, `date_modified`, `description`) VALUES
	('2623808a-99ab-11ea-bbdc-bcee7b513d25', 'Production A', '2020-05-19 15:31:34', '2020-05-19 15:31:34', 'Producing Selling Item A with Material A(Kecap Bango 1 ton)');
/*!40000 ALTER TABLE `production` ENABLE KEYS */;

-- Dumping structure for table powerbitable.production_invtransfer
CREATE TABLE IF NOT EXISTS `production_invtransfer` (
  `id` char(36) NOT NULL,
  `date_entered` datetime NOT NULL DEFAULT current_timestamp(),
  `date_modified` datetime DEFAULT NULL,
  `prodid` char(36) NOT NULL,
  `invtransid` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table powerbitable.production_invtransfer: ~0 rows (approximately)
/*!40000 ALTER TABLE `production_invtransfer` DISABLE KEYS */;
INSERT INTO `production_invtransfer` (`id`, `date_entered`, `date_modified`, `prodid`, `invtransid`) VALUES
	('668eaac0-99ae-11ea-bbdc-bcee7b513d25', '2020-05-19 15:54:51', NULL, '2623808a-99ab-11ea-bbdc-bcee7b513d25', 'e0ca32f1-99aa-11ea-bbdc-bcee7b513d25');
/*!40000 ALTER TABLE `production_invtransfer` ENABLE KEYS */;

-- Dumping structure for table powerbitable.shipping
CREATE TABLE IF NOT EXISTS `shipping` (
  `id` char(36) NOT NULL,
  `shipping_name` varchar(255) NOT NULL,
  `date_entered` datetime NOT NULL DEFAULT current_timestamp(),
  `date_modified` datetime DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table powerbitable.shipping: ~0 rows (approximately)
/*!40000 ALTER TABLE `shipping` DISABLE KEYS */;
INSERT INTO `shipping` (`id`, `shipping_name`, `date_entered`, `date_modified`, `description`) VALUES
	('8136a4af-99ab-11ea-bbdc-bcee7b513d25', 'Shipping', '2020-05-19 15:34:07', NULL, 'Shipping Selling Item A');
/*!40000 ALTER TABLE `shipping` ENABLE KEYS */;

-- Dumping structure for table powerbitable.shipping_invtransfer
CREATE TABLE IF NOT EXISTS `shipping_invtransfer` (
  `id` char(36) NOT NULL,
  `date_entered` datetime NOT NULL DEFAULT current_timestamp(),
  `date_modified` datetime DEFAULT NULL,
  `shippingid` char(36) NOT NULL,
  `invtransid` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table powerbitable.shipping_invtransfer: ~0 rows (approximately)
/*!40000 ALTER TABLE `shipping_invtransfer` DISABLE KEYS */;
INSERT INTO `shipping_invtransfer` (`id`, `date_entered`, `date_modified`, `shippingid`, `invtransid`) VALUES
	('9f9e3cd4-99ae-11ea-bbdc-bcee7b513d25', '2020-05-19 15:56:26', NULL, '8136a4af-99ab-11ea-bbdc-bcee7b513d25', '73020f68-99ab-11ea-bbdc-bcee7b513d25');
/*!40000 ALTER TABLE `shipping_invtransfer` ENABLE KEYS */;

-- Dumping structure for table powerbitable.split_invtrans_rel
CREATE TABLE IF NOT EXISTS `split_invtrans_rel` (
  `id` char(36) NOT NULL,
  `date_entered` datetime NOT NULL DEFAULT current_timestamp(),
  `date_modified` datetime DEFAULT NULL,
  `splitid` char(36) NOT NULL,
  `invtransid` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table powerbitable.split_invtrans_rel: ~2 rows (approximately)
/*!40000 ALTER TABLE `split_invtrans_rel` DISABLE KEYS */;
INSERT INTO `split_invtrans_rel` (`id`, `date_entered`, `date_modified`, `splitid`, `invtransid`) VALUES
	('311b710e-99ae-11ea-bbdc-bcee7b513d25', '2020-05-19 15:53:21', NULL, 'e0ca32f1-99aa-11ea-bbdc-bcee7b513d25', '351aa2fd-99ad-11ea-bbdc-bcee7b513d25'),
	('3125d1ed-99ae-11ea-bbdc-bcee7b513d25', '2020-05-19 15:53:21', NULL, 'e0ca32f1-99aa-11ea-bbdc-bcee7b513d25', '352842c8-99ad-11ea-bbdc-bcee7b513d25'),
	('3131d570-99ae-11ea-bbdc-bcee7b513d25', '2020-05-19 15:53:21', NULL, 'e0ca32f1-99aa-11ea-bbdc-bcee7b513d25', '3537d3fb-99ad-11ea-bbdc-bcee7b513d25');
/*!40000 ALTER TABLE `split_invtrans_rel` ENABLE KEYS */;

-- Dumping structure for table powerbitable.split_inv_transfer
CREATE TABLE IF NOT EXISTS `split_inv_transfer` (
  `id` char(36) NOT NULL,
  `split_name` varchar(255) NOT NULL,
  `date_entered` datetime NOT NULL DEFAULT current_timestamp(),
  `date_modified` datetime DEFAULT NULL,
  `split_qty` int(11) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table powerbitable.split_inv_transfer: ~4 rows (approximately)
/*!40000 ALTER TABLE `split_inv_transfer` DISABLE KEYS */;
INSERT INTO `split_inv_transfer` (`id`, `split_name`, `date_entered`, `date_modified`, `split_qty`, `description`) VALUES
	('351aa2fd-99ad-11ea-bbdc-bcee7b513d25', 'Split Inv. Trans. A.1', '2020-05-19 15:46:18', NULL, 5, 'Transfer Split A.1 Material A to Production Site A'),
	('352842c8-99ad-11ea-bbdc-bcee7b513d25', 'Split Inv. Trans. A.2', '2020-05-19 15:46:18', NULL, 5, 'Transfer Split A.2 Material A to Production Site A'),
	('3537d3fb-99ad-11ea-bbdc-bcee7b513d25', 'Split Inv. Trans. A.3', '2020-05-19 15:46:18', NULL, 5, 'Transfer Split A.3 Material A to Production Site A');
/*!40000 ALTER TABLE `split_inv_transfer` ENABLE KEYS */;

-- Dumping structure for table powerbitable.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table powerbitable.users: ~1 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `password`) VALUES
	('1', 'admin', 'admin');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for view powerbitable.force_layout
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `force_layout`;
CREATE ALGORITHM=TEMPTABLE SQL SECURITY DEFINER VIEW `force_layout` AS SELECT
	a.mat_name AS source
FROM
	material a
	INNER JOIN material_inventorytransfer b ON b.materialid = a.id
	INNER JOIN inventory_transfer c ON c.id = b.invtransferid
	INNER JOIN split_invtrans_rel d ON d.invtransid = c.id
	INNER JOIN split_inv_transfer e ON e.id = d.splitid
	INNER JOIN production_invtransfer f ON f.invtransid = c.id
	INNER JOIN production g ON g.id = f.prodid ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
