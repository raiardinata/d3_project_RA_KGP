-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.13-MariaDB - mariadb.org binary distribution
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
	('73020f68-99ab-11ea-bbdc-bcee7b513d25', 'Inventory Transfer B', '2020-05-19 15:33:43', NULL, 'Transfer to Shipping Selling Item A');
INSERT INTO `inventory_transfer` (`id`, `invtrans_name`, `date_entered`, `date_modified`, `description`) VALUES
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

-- Dumping data for table powerbitable.material_inventorytransfer: ~0 rows (approximately)
/*!40000 ALTER TABLE `material_inventorytransfer` DISABLE KEYS */;
INSERT INTO `material_inventorytransfer` (`id`, `date_entered`, `date_modified`, `materialid`, `invtransferid`) VALUES
	('cc739fb7-99ad-11ea-bbdc-bcee7b513d25', '2020-05-19 15:50:32', NULL, 'b7eeca72-99aa-11ea-bbdc-bcee7b513d25', 'e0ca32f1-99aa-11ea-bbdc-bcee7b513d25');
/*!40000 ALTER TABLE `material_inventorytransfer` ENABLE KEYS */;

-- Dumping structure for table powerbitable.mstr_mapping_user
CREATE TABLE IF NOT EXISTS `mstr_mapping_user` (
  `Step_ID` int(11) NOT NULL,
  `Prod_Grp` varchar(10) NOT NULL,
  `Key` varchar(6) DEFAULT NULL,
  `User_Define` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Master Mapping User';

-- Dumping data for table powerbitable.mstr_mapping_user: ~0 rows (approximately)
/*!40000 ALTER TABLE `mstr_mapping_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `mstr_mapping_user` ENABLE KEYS */;

-- Dumping structure for table powerbitable.mstr_node
CREATE TABLE IF NOT EXISTS `mstr_node` (
  `Step_ID` int(11) NOT NULL,
  `Prod_Grp` varchar(10) NOT NULL,
  `Key` varchar(6) DEFAULT NULL,
  `Description` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Master Node';

-- Dumping data for table powerbitable.mstr_node: ~5 rows (approximately)
/*!40000 ALTER TABLE `mstr_node` DISABLE KEYS */;
INSERT INTO `mstr_node` (`Step_ID`, `Prod_Grp`, `Key`, `Description`) VALUES
	(100, 'A', 'I0100', 'Penerimaan');
INSERT INTO `mstr_node` (`Step_ID`, `Prod_Grp`, `Key`, `Description`) VALUES
	(200, 'A', NULL, 'Transfer');
INSERT INTO `mstr_node` (`Step_ID`, `Prod_Grp`, `Key`, `Description`) VALUES
	(300, 'A', 'P0100', 'Produksi step Mixing');
INSERT INTO `mstr_node` (`Step_ID`, `Prod_Grp`, `Key`, `Description`) VALUES
	(300, 'A', 'P0200', 'Produksi step Packing');
INSERT INTO `mstr_node` (`Step_ID`, `Prod_Grp`, `Key`, `Description`) VALUES
	(400, 'A', 'P0100', 'Pengiriman');
/*!40000 ALTER TABLE `mstr_node` ENABLE KEYS */;

-- Dumping structure for table powerbitable.mstr_prd_info
CREATE TABLE IF NOT EXISTS `mstr_prd_info` (
  `materialCode` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `additionalInfo` varchar(255) DEFAULT NULL,
  `imageData` mediumblob NOT NULL,
  `imageType` varchar(25) NOT NULL DEFAULT '',
  `imageId` varchar(255) NOT NULL DEFAULT uuid(),
  PRIMARY KEY (`imageId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table powerbitable.mstr_prd_info: ~0 rows (approximately)
/*!40000 ALTER TABLE `mstr_prd_info` DISABLE KEYS */;
INSERT INTO `mstr_prd_info` (`materialCode`, `description`, `additionalInfo`, `imageData`, `imageType`, `imageId`) VALUES
	('121001055', 'Garam Samudra', '20gr 2020', _binary 0x2E2E2F696D616765732F7072645F696D672F476172616D5F53616D756472612E6A7067, 'image/jpeg', '5e882fed-e757-11ea-bfdb-2089849f1c11');
INSERT INTO `mstr_prd_info` (`materialCode`, `description`, `additionalInfo`, `imageData`, `imageType`, `imageId`) VALUES
	('8994016003525', 'Kacang Emas', 'Kacang Lokal Bernutrisi', _binary 0x2E2E2F696D616765732F7072645F696D672F4B6163616E675F456D61732E6A7067, 'image/jpeg', '745c1f01-e80f-11ea-bcd7-2089849f1c11');
/*!40000 ALTER TABLE `mstr_prd_info` ENABLE KEYS */;

-- Dumping structure for table powerbitable.mstr_query
CREATE TABLE IF NOT EXISTS `mstr_query` (
  `Step_ID` int(11) DEFAULT NULL,
  `Seq_No` int(11) DEFAULT NULL,
  `Filed` varchar(50) DEFAULT NULL,
  `Alias` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Master query data component';

-- Dumping data for table powerbitable.mstr_query: ~58 rows (approximately)
/*!40000 ALTER TABLE `mstr_query` DISABLE KEYS */;
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 1, 'DocumentNo', 'Document No.');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 2, 'VendorID', 'Vendor ID');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 3, 'VendorName', 'Vendor Name');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 4, 'PONumber', 'PO No.');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 5, 'LineNo', 'Line No.');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 6, 'MaterialCode', 'Material Code');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 7, 'MaterialDescription', 'Material Name');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 8, 'Quantity', 'Quantity');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 9, 'UoM', 'Unit of Measurement');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 10, 'Batch', 'Batch');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 11, 'BatchVendor', 'Batch Vendor');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 12, 'DocumentDate', 'Document Date');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 13, 'ProductionDate', 'Production Date');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 14, 'ExpiredDate', 'Expired Date');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 15, 'Plant', 'Plant');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(100, 16, 'Warehouse', 'Warehouse');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(200, 1, 'DocumentNo', 'Document No.');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(200, 2, 'LineNo', 'Line No.');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(200, 3, 'MaterialCode', 'Material Code');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(200, 4, 'MaterialDescription', 'Material Name');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(200, 5, 'Quantity', 'Quantity');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(200, 6, 'UoM', 'Unit of Measurement');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(200, 7, 'Batch', 'Batch');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(200, 8, 'BatchVendor', 'Batch Vendor');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(200, 9, 'DocumentDate', 'Document Date');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(200, 10, 'Plant', 'Plant');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(200, 11, 'Warehouse', 'Warehouse');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(200, 12, 'ToPlant', 'To Plant');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(200, 13, 'ToWarehouse', 'To Warehouse');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 1, 'LineNo', 'Line No.');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 2, 'MaterialCode', 'Material Code');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 3, 'MaterialDescription', 'Material Name');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 4, 'Quantity', 'Quantity');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 5, 'UoM', 'Unit of Measurement');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 6, 'Batch', 'Batch');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 7, 'ProductionDate', 'Production Date');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 8, 'Plant', 'Plant');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 9, 'Warehouse', 'Warehouse');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 10, 'WorkOrder', 'Work Order');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 11, 'RM_MaterialCode', 'RM Material Code');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 12, 'RM_MaterialDescription', 'RM Material Name');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 13, 'RM_Batch', 'RM Batch');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 14, 'RM_Quantity', 'RM_Quantity');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 15, 'RM_UOM', 'RM Unit of Measurement');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(400, 1, 'DocumentNo', 'Document No.');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(400, 2, 'LineNo', 'Line No.');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(400, 3, 'MaterialCode', 'Material Code');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(400, 4, 'MaterialDescription', 'Material Name');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(400, 5, 'Quantity', 'Quantity');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(400, 6, 'UoM', 'Unit of Measurement');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(400, 7, 'Batch', 'Batch');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(400, 8, 'ProductionDate', 'Production Date');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(400, 9, 'Plant', 'Plant');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(400, 10, 'Warehouse', 'Warehouse');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(400, 11, 'SalesOrder', 'Sales Order');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(400, 12, 'Sales_LineNo', 'Sales Line No.');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(400, 13, 'CustomerID', 'CustomerID');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(400, 14, 'CustomerName', 'Customer Name');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(300, 16, '`Key`', 'Step Produksi');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(350, 1, 'LineNo', 'Line No.');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(350, 2, 'MaterialCode', 'Material Code');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(350, 3, 'MaterialDescription', 'Material Name');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(350, 4, 'Quantity', 'Quantity');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(350, 5, 'UoM', 'Unit of Measurement');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(350, 6, 'Batch', 'Batch');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(350, 7, 'ProductionDate', 'Production Date');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(350, 8, 'Plant', 'Plant');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(350, 9, 'Warehouse', 'Warehouse');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(350, 10, 'WorkOrder', 'Work Order');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(350, 11, 'RM_MaterialCode', 'RM Material Code');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(350, 12, 'RM_MaterialDescription', 'RM Material Name');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(350, 13, 'RM_Batch', 'RM Batch');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(350, 14, 'RM_Quantity', 'RM_Quantity');
INSERT INTO `mstr_query` (`Step_ID`, `Seq_No`, `Filed`, `Alias`) VALUES
	(350, 15, 'RM_UOM', 'RM Unit of Measurement');
/*!40000 ALTER TABLE `mstr_query` ENABLE KEYS */;

-- Dumping structure for table powerbitable.mstr_step
CREATE TABLE IF NOT EXISTS `mstr_step` (
  `Step_ID` int(11) NOT NULL,
  `Description` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Master Step';

-- Dumping data for table powerbitable.mstr_step: ~4 rows (approximately)
/*!40000 ALTER TABLE `mstr_step` DISABLE KEYS */;
INSERT INTO `mstr_step` (`Step_ID`, `Description`) VALUES
	(100, 'Inbound');
INSERT INTO `mstr_step` (`Step_ID`, `Description`) VALUES
	(200, 'Transfer');
INSERT INTO `mstr_step` (`Step_ID`, `Description`) VALUES
	(300, 'Produksi');
INSERT INTO `mstr_step` (`Step_ID`, `Description`) VALUES
	(400, 'Outbound');
INSERT INTO `mstr_step` (`Step_ID`, `Description`) VALUES
	(350, 'Transfer FG');
/*!40000 ALTER TABLE `mstr_step` ENABLE KEYS */;

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

-- Dumping data for table powerbitable.split_invtrans_rel: ~3 rows (approximately)
/*!40000 ALTER TABLE `split_invtrans_rel` DISABLE KEYS */;
INSERT INTO `split_invtrans_rel` (`id`, `date_entered`, `date_modified`, `splitid`, `invtransid`) VALUES
	('311b710e-99ae-11ea-bbdc-bcee7b513d25', '2020-05-19 15:53:21', NULL, 'e0ca32f1-99aa-11ea-bbdc-bcee7b513d25', '351aa2fd-99ad-11ea-bbdc-bcee7b513d25');
INSERT INTO `split_invtrans_rel` (`id`, `date_entered`, `date_modified`, `splitid`, `invtransid`) VALUES
	('3125d1ed-99ae-11ea-bbdc-bcee7b513d25', '2020-05-19 15:53:21', NULL, 'e0ca32f1-99aa-11ea-bbdc-bcee7b513d25', '352842c8-99ad-11ea-bbdc-bcee7b513d25');
INSERT INTO `split_invtrans_rel` (`id`, `date_entered`, `date_modified`, `splitid`, `invtransid`) VALUES
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

-- Dumping data for table powerbitable.split_inv_transfer: ~3 rows (approximately)
/*!40000 ALTER TABLE `split_inv_transfer` DISABLE KEYS */;
INSERT INTO `split_inv_transfer` (`id`, `split_name`, `date_entered`, `date_modified`, `split_qty`, `description`) VALUES
	('351aa2fd-99ad-11ea-bbdc-bcee7b513d25', 'Split Inv. Trans. A.1', '2020-05-19 15:46:18', NULL, 5, 'Transfer Split A.1 Material A to Production Site A');
INSERT INTO `split_inv_transfer` (`id`, `split_name`, `date_entered`, `date_modified`, `split_qty`, `description`) VALUES
	('352842c8-99ad-11ea-bbdc-bcee7b513d25', 'Split Inv. Trans. A.2', '2020-05-19 15:46:18', NULL, 5, 'Transfer Split A.2 Material A to Production Site A');
INSERT INTO `split_inv_transfer` (`id`, `split_name`, `date_entered`, `date_modified`, `split_qty`, `description`) VALUES
	('3537d3fb-99ad-11ea-bbdc-bcee7b513d25', 'Split Inv. Trans. A.3', '2020-05-19 15:46:18', NULL, 5, 'Transfer Split A.3 Material A to Production Site A');
/*!40000 ALTER TABLE `split_inv_transfer` ENABLE KEYS */;

-- Dumping structure for table powerbitable.tbl_transaksi
CREATE TABLE IF NOT EXISTS `tbl_transaksi` (
  `UUID` varchar(255) NOT NULL,
  `Step_ID` int(11) DEFAULT NULL,
  `Prod_Grp` varchar(10) DEFAULT NULL,
  `Key` varchar(6) DEFAULT NULL,
  `User_Define` varchar(50) DEFAULT NULL,
  `DocumentNo` varchar(15) DEFAULT NULL,
  `VendorID` varchar(15) DEFAULT NULL,
  `VendorName` varchar(50) DEFAULT NULL,
  `PONumber` varchar(15) DEFAULT NULL,
  `LineNo` int(11) DEFAULT NULL,
  `MaterialCode` varchar(18) DEFAULT NULL,
  `MaterialDescription` varchar(50) DEFAULT NULL,
  `Quantity` decimal(10,2) DEFAULT NULL,
  `UoM` varchar(5) DEFAULT NULL,
  `Batch` varchar(18) DEFAULT NULL,
  `BatchVendor` varchar(18) DEFAULT NULL,
  `DocumentDate` date DEFAULT NULL,
  `ProductionDate` date DEFAULT NULL,
  `ExpiredDate` date DEFAULT NULL,
  `Plant` varchar(6) DEFAULT NULL,
  `Warehouse` varchar(6) DEFAULT NULL,
  `ToPlant` varchar(6) DEFAULT NULL,
  `ToWarehouse` varchar(6) DEFAULT NULL,
  `WorkOrder` varchar(15) DEFAULT NULL,
  `RM_MaterialCode` varchar(18) DEFAULT NULL,
  `RM_MaterialDescription` varchar(50) DEFAULT NULL,
  `RM_Batch` varchar(18) DEFAULT NULL,
  `RM_Quantity` decimal(10,2) DEFAULT NULL,
  `RM_UOM` varchar(6) DEFAULT NULL,
  `SalesOrder` varchar(15) DEFAULT NULL,
  `Sales_LineNo` int(11) DEFAULT NULL,
  `CustomerID` varchar(15) DEFAULT NULL,
  `CustomerName` varchar(50) DEFAULT NULL,
  `ShiptoID` varchar(15) DEFAULT NULL,
  `ShiptoName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabel transaksi';

-- Dumping data for table powerbitable.tbl_transaksi: ~145 rows (approximately)
/*!40000 ALTER TABLE `tbl_transaksi` DISABLE KEYS */;
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('128edbc7-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000010', '1200000011', 'CAHAYA ABADI', '4500000123', 10, '121001055', 'Garam Samudra', 800.00, 'KG', '20191003', 'B190925', '2019-10-03', '2019-09-25', '2024-09-25', '2102', '2015', '', '', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('12a8445f-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000010', '1200000011', 'CAHAYA ABADI', '4500000123', 20, '121001156', 'Garlic Powder FII J-01009', 100.00, 'KG', '20191003', 'B190926', '2019-10-03', '2019-09-26', '2021-09-26', '2102', '2015', '', '', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('12b62d32-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000034', '', '', '', 10, '121001055', 'Garam Samudra', 400.00, 'KG', '20191003', 'B190925', '2019-10-09', '0000-00-00', '0000-00-00', '2102', '2015', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('12cae258-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 10, '211000010', 'SFG MSG/Masako Bulk', 1000.00, 'KG', '20191010', '', '0000-00-00', '2019-10-10', '0000-00-00', '2021', '2052', '', '', '300010', '121001055', 'Garam Samudra', '20191003', 400.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('12d7bb71-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 20, '211000010', 'SFG MSG/Masako Bulk', 1000.00, 'KG', '20191010', '', '0000-00-00', '2019-10-10', '0000-00-00', '2021', '2052', '', '', '300010', '121001156', 'Garlic Powder FII J-01009', '20190930', 200.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('13009a8b-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0200', '', '', '', '', '', 10, '124000714', '250MA C (1 x 48) 250 g', 500.00, 'PC', '20191011', '', '0000-00-00', '2019-10-11', '0000-00-00', '2021', '2052', '', '', '300012', '211000010', 'SFG MSG Bulk', '20191010', 300.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('130ca89f-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0200', '', '', '', '', '', 20, '124000714', '250MA C (1 x 48) 250 g', 500.00, 'PC', '20191011', '', '0000-00-00', '2019-10-11', '0000-00-00', '2021', '2052', '', '', '300012', '211000013', 'CHICKEN FAT - EMP', '20191010', 200.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('131689d3-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0200', '', '', '', '', '', 30, '124000714', '250MA C (1 x 48) 250 g', 500.00, 'PC', '20191011', '', '0000-00-00', '2019-10-11', '0000-00-00', '2021', '2052', '', '', '300012', '122000100', 'Packing 250 MA', '20191010', 500.00, 'PC', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('131efad9-d622-11ea-8b0a-bcee7b513d25', 400, 'A', 'O001', '', '1000000021', '', '', '', 10, '124000714', '250MA C (1 x 48) 250 g', 240.00, 'PC', '20191011', '', '0000-00-00', '2019-10-11', '0000-00-00', '2021', '2052', '', '', '', '', '', '', 0.00, '', '10000001232', 10, '2100000054', 'CAREFOUR LB', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('132affa0-d622-11ea-8b0a-bcee7b513d25', 400, 'A', 'O001', '', '1000000022', '', '', '', 10, '124000714', '250MA C (1 x 48) 250 g', 100.00, 'PC', '20191011', '', '0000-00-00', '2019-10-11', '0000-00-00', '2021', '2052', '', '', '', '', '', '', 0.00, '', '10000001233', 10, '2100000055', 'IndoMarco', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('1337272d-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000011', '1200000010', 'PT ABC', '4500000124', 10, '121000100', 'RM 121000100', 5000.00, 'KG', '20200801', 'B190927', '2020-08-01', '2020-07-01', '2025-07-01', '2102', '2015', '', '', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('1344607f-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000011', '1200000010', 'PT ABC', '4500000124', 20, '121000101', 'RM 121000101', 1000.00, 'KG', '20200801', 'B190928', '2020-08-01', '2020-07-01', '2025-07-01', '2102', '2015', '', '', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('13554aee-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000011', '1200000010', 'PT ABC', '4500000124', 30, '121000102', 'RM 121000102', 1000.00, 'KG', '20200801', 'B190929', '2020-08-01', '2020-07-01', '2025-07-01', '2102', '2015', '', '', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('135e8b49-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000035', '', '', '', 10, '121000100', 'RM 121000100', 500.00, 'KG', '20200801', 'B190927', '2020-08-02', '0000-00-00', '0000-00-00', '2102', '2015', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('1367f825-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000035', '', '', '', 20, '121001055', 'Garam Samudra', 100.00, 'KG', '20191003', 'B190925', '2020-08-02', '0000-00-00', '0000-00-00', '2102', '2015', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('1372975a-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000035', '', '', '', 30, '121000101', 'RM 121000101', 300.00, 'KG', '20200801', 'B190928', '2020-08-02', '0000-00-00', '0000-00-00', '2102', '2015', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('138a223d-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000035', '', '', '', 40, '121000102', 'RM 121000102', 300.00, 'KG', '20200801', 'B190929', '2020-08-02', '0000-00-00', '0000-00-00', '2102', '2015', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('13a57923-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000036', '', '', '', 10, '121000100', 'RM 121000100', 500.00, 'KG', '20200801', 'B190927', '2020-08-03', '0000-00-00', '0000-00-00', '2102', '2015', '2103', '2001', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('13b25d6b-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000036', '', '', '', 20, '121000101', 'RM 121000101', 400.00, 'KG', '20200801', 'B190928', '2020-08-03', '0000-00-00', '0000-00-00', '2102', '2015', '2103', '2001', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('13c0fd60-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000036', '', '', '', 30, '121000102', 'RM 121000102', 300.00, 'KG', '20200801', 'B190929', '2020-08-03', '0000-00-00', '0000-00-00', '2102', '2015', '2103', '2001', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('13cbbd99-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 10, '211000011', 'SFG 211000011', 1200.00, 'KG', '20200803', '', '0000-00-00', '2020-08-03', '0000-00-00', '2102', '2052', '', '', '300011', '121000100', 'RM 121000100', 'B190927', 500.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('13d80601-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 20, '211000011', 'SFG 211000011', 1200.00, 'KG', '20200803', '', '0000-00-00', '2020-08-03', '0000-00-00', '2102', '2052', '', '', '300011', '121000101', 'RM 121000101', 'B190928', 300.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('13e62d6d-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 30, '211000011', 'SFG 211000011', 1200.00, 'KG', '20200803', '', '0000-00-00', '2020-08-03', '0000-00-00', '2102', '2052', '', '', '300011', '121000102', 'RM 121000102', 'B190929', 300.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('13f311d3-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 40, '211000011', 'SFG 211000011', 1200.00, 'KG', '20200803', '', '0000-00-00', '2020-08-03', '0000-00-00', '2102', '2052', '', '', '300011', '121001055', 'Garam Samudra', '20191003', 100.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('13fbac75-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000001', '1200000008', 'PT XYZ', '4500000100', 10, '121000100', 'RM 121000100', 1800.00, 'KG', '20190601', 'B190800', '2019-06-01', '2019-05-28', '2022-05-28', '2102', '2014', '', '', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('14059fc5-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000001', '1200000008', 'PT XYZ', '4500000100', 20, '121000101', 'RM 121000101', 800.00, 'KG', '20190601', 'B190801', '2019-06-01', '2019-05-28', '2022-05-28', '2102', '2014', '', '', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('140dde2b-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000001', '1200000008', 'PT XYZ', '4500000100', 30, '121000103', 'RM 121000103', 1000.00, 'KG', '20190601', 'B190802', '2019-06-01', '2019-05-28', '2022-05-28', '2102', '2014', '', '', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('141f0b13-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000001', '', '', '', 10, '121000100', 'RM 121000100', 400.00, 'KG', '20190601', 'B190800', '2019-06-05', '0000-00-00', '0000-00-00', '2102', '2014', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('1433e7ba-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000001', '', '', '', 20, '121000101', 'RM 121000101', 300.00, 'KG', '20190601', 'B190801', '2019-06-05', '0000-00-00', '0000-00-00', '2102', '2014', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('1445f7e6-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000001', '', '', '', 30, '121000103', 'RM 121000103', 200.00, 'KG', '20190601', 'B190802', '2019-06-05', '0000-00-00', '0000-00-00', '2102', '2014', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('14522cb2-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 10, '211000011', 'SFG 211000011', 900.00, 'KG', '20190606', '', '0000-00-00', '2019-06-06', '0000-00-00', '2102', '2052', '', '', '300001', '121000100', 'RM 121000100', 'B190800', 400.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('1460ad04-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 20, '211000011', 'SFG 211000011', 900.00, 'KG', '20190606', '', '0000-00-00', '2019-06-06', '0000-00-00', '2102', '2052', '', '', '300001', '121000101', 'RM 121000101', 'B190801', 300.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('146d8fa5-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 30, '211000011', 'SFG 211000011', 900.00, 'KG', '20190606', '', '0000-00-00', '2019-06-06', '0000-00-00', '2102', '2052', '', '', '300001', '121000103', 'RM 121000103', 'B190802', 200.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('147ac21e-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000002', '', '', '', 10, '121000100', 'RM 121000100', 500.00, 'KG', '20190601', 'B190800', '2019-06-06', '0000-00-00', '0000-00-00', '2102', '2014', '2103', '2001', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('148e20cd-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000002', '', '', '', 20, '121000101', 'RM 121000101', 200.00, 'KG', '20190601', 'B190801', '2019-06-06', '0000-00-00', '0000-00-00', '2102', '2014', '2103', '2001', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('149849e6-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000002', '', '', '', 30, '121000103', 'RM 121000103', 300.00, 'KG', '20190601', 'B190802', '2019-06-06', '0000-00-00', '0000-00-00', '2102', '2014', '2103', '2001', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('14a3bfc0-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0200', '', '', '', '', '', 10, '124000100', 'FG 124000100', 3600.00, 'PC', '20190608', '', '0000-00-00', '2019-06-09', '0000-00-00', '2102', '2052', '', '', '300001', '211000011', 'SFG 211000011', '20190606', 900.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('14b3716a-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0200', '', '', '', '', '', 20, '124000100', 'FG 124000100', 3600.00, 'PC', '20190608', '', '0000-00-00', '2019-06-09', '0000-00-00', '2102', '2052', '', '', '300001', '122000100', 'Packing 124000100', '20190601', 3600.00, 'PC', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('14c08c82-d622-11ea-8b0a-bcee7b513d25', 400, 'A', 'O001', '', '1000000001', '', '', '', 10, '124000100', 'FG 124000100', 100.00, 'PC', '20190608', '', '0000-00-00', '2019-06-15', '0000-00-00', '2102', '2052', '', '', '', '', '', '', 0.00, '', '10000001200', 10, '2100000055', 'IndoMarco', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('14caef01-d622-11ea-8b0a-bcee7b513d25', 400, 'A', 'O001', '', '1000000002', '', '', '', 10, '124000100', 'FG 124000100', 200.00, 'PC', '20190608', '', '0000-00-00', '2019-06-15', '0000-00-00', '2102', '2052', '', '', '', '', '', '', 0.00, '', '10000001201', 10, '2100000050', 'Customer 2100000050', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('14d99739-d622-11ea-8b0a-bcee7b513d25', 400, 'A', 'O001', '', '1000000003', '', '', '', 10, '124000100', 'FG 124000100', 300.00, 'PC', '20190608', '', '0000-00-00', '2019-06-15', '0000-00-00', '2102', '2052', '', '', '', '', '', '', 0.00, '', '10000001202', 10, '2100000051', 'Customer 2100000051', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('65be6294-f266-11ea-8b1c-00155d7dcd02', 100, 'A', 'I001', '', 'RC-000001', '1200000100', 'Idaho Potatoes Plantation', '4500000200', 10, '111000011', 'Potato', 100000.00, 'KG', 'R20200801', 'POT200801', '2020-08-02', '2020-08-01', '2020-11-01', 'PLT001', 'RM001', '', '', '', '', '', '', 0.00, '', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('65ef5338-f266-11ea-8b1c-00155d7dcd02', 100, 'A', 'I001', '', 'RC-000008', '1200000101', 'Natural Flavours Corporation', '4500000201', 10, '111000013', 'Barbeque Seasoning', 100.00, 'KG', 'R20200804', 'BAR200601', '2020-08-04', '2020-06-01', '2022-06-01', 'PLT001', 'RM001', '', '', '', '', '', '', 0.00, '', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('65fc3eb9-f266-11ea-8b1c-00155d7dcd02', 100, 'A', 'I001', '', 'RC-000008', '1200000101', 'Natural Flavours Corporation', '4500000201', 20, '111000014', 'Seaweed Seasoning', 100.00, 'KG', 'R20200804', 'SEA200601', '2020-08-04', '2020-06-01', '2022-06-01', 'PLT001', 'RM001', '', '', '', '', '', '', 0.00, '', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('6604258f-f266-11ea-8b1c-00155d7dcd02', 100, 'A', 'I001', '', 'RC-000015', '1200000102', 'Salty First Pte. Ltd', '4500000202', 10, '111000012', 'Sea Salt', 1000.00, 'KG', 'R20200806', 'SS200715', '2020-08-06', '2020-07-15', '2021-07-15', 'PLT001', 'RM002', '', '', '', '', '', '', 0.00, '', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66093165-f266-11ea-8b1c-00155d7dcd02', 100, 'A', 'I001', '', 'RC-000016', '1200000103', 'Oil & Oil Brothers Co.', '4500000203', 10, '111000015', 'Canola Oil', 8000.00, 'LITRE', 'R20200806', 'CO200620', '2020-08-06', '2020-06-20', '2021-06-20', 'PLT001', 'RM001', '', '', '', '', '', '', 0.00, '', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('660e557c-f266-11ea-8b1c-00155d7dcd02', 200, '', '', '', 'MT-000001', '', '', '', 10, '111000012', 'Sea Salt', 200.00, 'KG', 'R20200806', 'SS200715', '2020-08-10', '2020-07-15', '2021-07-15', 'PLT001', 'RM002', 'PLT001', 'RM001', '', '', '', '', 0.00, '', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('661519ef-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0100', '', '', '', '', '', 10, '113000005', 'SFG Potato Slices', 10000.00, 'KG', 'P20200811', '', '0000-00-00', '2020-08-11', '2022-08-11', 'PLT001', 'RM001', '', '', 'IP-000001', '111000011', 'Potatoes', 'R20200801', 10000.00, 'KG', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('661bbcf2-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0200', '', '', '', '', '', 10, '113000006', 'SFG Fried Chips', 10000.00, 'KG', 'P20200811', '', '0000-00-00', '2020-08-11', '2022-08-11', 'PLT001', 'RM001', '', '', 'IP-000002', '113000005', 'SFG Potato Slices', 'P20200811', 10000.00, 'KG', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66261e7e-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0200', '', '', '', '', '', 20, '113000006', 'SFG Fried Chips', 10000.00, 'KG', 'P20200811', '', '0000-00-00', '2020-08-11', '2022-08-11', 'PLT001', 'RM001', '', '', 'IP-000002', '111000015', 'Canola Oil', 'R20200806', 8000.00, 'LITRE', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('662d7443-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0300', '', '', '', '', '', 10, '113000007', 'SFG Bulk Sesoned Chips', 2500.00, 'KG', 'P20200811', '', '0000-00-00', '2020-08-11', '2022-08-11', 'PLT001', 'RM001', '', '', 'IP-000003', '113000006', 'SFG Fried Chips', 'P20200811', 2500.00, 'KG', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('6638ae10-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0300', '', '', '', '', '', 20, '113000007', 'SFG Bulk Sesoned Chips', 2500.00, 'KG', 'P20200811', '', '0000-00-00', '2020-08-11', '2022-08-11', 'PLT001', 'RM001', '', '', 'IP-000003', '111000012', 'Sea Salt', 'R20200806', 50.00, 'KG', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66409400-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0900', '', '', '', '', '', 10, '114000005', 'CHIPS 100 GR ORIGINAL', 15000.00, 'PC', 'CO1200811', '', '0000-00-00', '2020-08-11', '2022-08-11', 'PLT001', 'FG001', '', '', 'IP-000004', '113000007', 'SFG Bulk Sesoned Chips', 'P20200811', 1500.00, 'KG', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('664c2713-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0900', '', '', '', '', '', 20, '114000005', 'CHIPS 100 GR ORIGINAL', 15000.00, 'PC', 'CO1200811', '', '0000-00-00', '2020-08-11', '2022-08-11', 'PLT001', 'FG001', '', '', 'IP-000004', '112000005', ' Packing CHIPS 100 GR ORIGINAL', 'R20200802', 15000.00, 'PC', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66515bd2-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0900', '', '', '', '', '', 10, '114000006', 'CHIPS 50 GR ORIGINAL', 20000.00, 'PC', 'CO2200811', '', '0000-00-00', '2020-08-11', '2022-08-11', 'PLT001', 'FG001', '', '', 'IP-000005', '113000007', 'SFG Bulk Sesoned Chips', 'P20200811', 1000.00, 'KG', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('6658eb04-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0900', '', '', '', '', '', 20, '114000006', 'CHIPS 50 GR ORIGINAL', 20000.00, 'PC', 'CO2200811', '', '0000-00-00', '2020-08-11', '2022-08-11', 'PLT001', 'FG001', '', '', 'IP-000005', '112000006', ' Packing CHIPS 50 GR ORIGINAL', 'R20200802', 20000.00, 'PC', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('665fbbd7-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0300', '', '', '', '', '', 10, '113000008', 'SFG Bulk Sesoned Chips Barbeque', 2500.00, 'KG', 'P20200812', '', '0000-00-00', '2020-08-12', '2022-08-12', 'PLT001', 'RM001', '', '', 'IP-000006', '113000006', 'SFG Fried Chips', 'P20200811', 2500.00, 'KG', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('666d9345-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0300', '', '', '', '', '', 20, '113000008', 'SFG Bulk Sesoned Chips Barbeque', 2500.00, 'KG', 'P20200812', '', '0000-00-00', '2020-08-12', '2022-08-12', 'PLT001', 'RM001', '', '', 'IP-000006', '111000012', 'Sea Salt', 'R20200806', 25.00, 'KG', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66746f78-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0300', '', '', '', '', '', 30, '113000008', 'SFG Bulk Sesoned Chips Barbeque', 2500.00, 'KG', 'P20200812', '', '0000-00-00', '2020-08-12', '2022-08-12', 'PLT001', 'RM001', '', '', 'IP-000006', '111000013', 'Barbeque Seasoning', 'R20200804', 25.00, 'KG', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66a03403-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0900', '', '', '', '', '', 10, '114000007', 'CHIPS 100 GR BARBEQUE', 25000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-12', '2022-08-12', 'PLT001', 'FG001', '', '', 'IP-000007', '113000008', 'SFG Bulk Sesoned Chips Barbeque', 'P20200812', 2500.00, 'KG', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66aa348e-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0900', '', '', '', '', '', 20, '114000007', 'CHIPS 100 GR BARBEQUE', 25000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-12', '2022-08-12', 'PLT001', 'FG001', '', '', 'IP-000007', '112000007', ' Packing CHIPS 100 GR BARBEQU', 'R20200802', 25000.00, 'PC', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66b143ae-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0300', '', '', '', '', '', 10, '113000009', ' SFG Bulk Sesoned Chips Seaweed', 2500.00, 'KG', 'P20200813', '', '0000-00-00', '2020-08-13', '2022-08-13', 'PLT001', 'RM001', '', '', 'IP-000008', '113000006', 'SFG Fried Chips', 'P20200811', 2500.00, 'KG', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66b815b9-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0300', '', '', '', '', '', 20, '113000009', ' SFG Bulk Sesoned Chips Seaweed', 2500.00, 'KG', 'P20200813', '', '0000-00-00', '2020-08-13', '2022-08-13', 'PLT001', 'RM001', '', '', 'IP-000008', '111000012', 'Sea Salt', 'R20200806', 25.00, 'KG', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66bfd2d2-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0300', '', '', '', '', '', 30, '113000009', ' SFG Bulk Sesoned Chips Seaweed', 2500.00, 'KG', 'P20200813', '', '0000-00-00', '2020-08-13', '2022-08-13', 'PLT001', 'RM001', '', '', 'IP-000008', '111000014', 'Seaweed Seasoning', 'R20200804', 100.00, 'KG', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66c8d529-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0900', '', '', '', '', '', 10, '114000008', 'CHIPS 100 GR SEAWEED', 25000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-13', '2022-08-13', 'PLT001', 'FG001', '', '', 'IP-000009', '113000009', ' SFG Bulk Sesoned Chips Seaweed', 'P20200813', 2500.00, 'KG', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66cfbb16-f266-11ea-8b1c-00155d7dcd02', 300, 'A', 'P0900', '', '', '', '', '', 20, '114000008', 'CHIPS 100 GR SEAWEED', 25000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-13', '2022-08-13', 'PLT001', 'FG001', '', '', 'IP-000009', '112000008', ' Packing CHIPS 100 GR SEAWEED', 'R20200802', 25000.00, 'PC', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66dee12a-f266-11ea-8b1c-00155d7dcd02', 350, '', '', '', 'FT-000001', '', '', '', 10, '114000005', 'CHIPS 100 GR ORIGINAL', 10000.00, 'PC', 'CO1200811', '', '0000-00-00', '2020-08-16', '0000-00-00', 'PLT001', 'FG001', 'PLT002', 'FG201', '', '', '', '', 0.00, '', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66e625fa-f266-11ea-8b1c-00155d7dcd02', 350, '', '', '', 'FT-000001', '', '', '', 20, '114000006', 'CHIPS 50 GR ORIGINAL', 10000.00, 'PC', 'CO2200811', '', '0000-00-00', '2020-08-16', '0000-00-00', 'PLT001', 'FG001', 'PLT002', 'FG201', '', '', '', '', 0.00, '', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66eb26f2-f266-11ea-8b1c-00155d7dcd02', 350, '', '', '', 'FT-000001', '', '', '', 30, '114000007', 'CHIPS 100 GR BARBEQUE', 10000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-16', '0000-00-00', 'PLT001', 'FG001', 'PLT002', 'FG201', '', '', '', '', 0.00, '', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66f1f6f1-f266-11ea-8b1c-00155d7dcd02', 350, '', '', '', 'FT-000001', '', '', '', 40, '114000008', 'CHIPS 100 GR SEAWEED', 10000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-16', '0000-00-00', 'PLT001', 'FG001', 'PLT002', 'FG201', '', '', '', '', 0.00, '', '', 0, '', '', '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('66fe457f-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000001', '', '', '', 10, '114000005', 'CHIPS 100 GR ORIGINAL', 1000.00, 'PC', 'CO1200811', '', '0000-00-00', '2020-08-21', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000001', 10, '2100000054', 'Carrefour Indonesia', '2154000001', 'Transmart Carrefour Central Park');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('67061ba4-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000001', '', '', '', 20, '114000006', 'CHIPS 50 GR ORIGINAL', 2000.00, 'PC', 'CO2200811', '', '0000-00-00', '2020-08-21', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000001', 20, '2100000054', 'Carrefour Indonesia', '2154000001', 'Transmart Carrefour Central Park');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('670c03c1-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000001', '', '', '', 30, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-21', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000001', 30, '2100000054', 'Carrefour Indonesia', '2154000001', 'Transmart Carrefour Central Park');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('671848ab-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000001', '', '', '', 40, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-21', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000001', 40, '2100000054', 'Carrefour Indonesia', '2154000001', 'Transmart Carrefour Central Park');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('671f8d0b-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000002', '', '', '', 10, '114000005', 'CHIPS 100 GR ORIGINAL', 1000.00, 'PC', 'CO1200811', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000001', 10, '2100000054', 'Carrefour Indonesia', '2154000002', 'Carrefour Puri Indah');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('6729663e-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000002', '', '', '', 20, '114000006', 'CHIPS 50 GR ORIGINAL', 2000.00, 'PC', 'CO2200811', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000001', 20, '2100000054', 'Carrefour Indonesia', '2154000002', 'Carrefour Puri Indah');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('672ffd1f-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000002', '', '', '', 30, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000001', 30, '2100000054', 'Carrefour Indonesia', '2154000002', 'Carrefour Puri Indah');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('674aa12e-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000002', '', '', '', 40, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000001', 40, '2100000054', 'Carrefour Indonesia', '2154000002', 'Carrefour Puri Indah');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('6756bc2b-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000003', '', '', '', 10, '114000005', 'CHIPS 100 GR ORIGINAL', 1000.00, 'PC', 'CO1200811', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000001', 10, '2100000054', 'Carrefour Indonesia', '2154000003', 'Carrefour Pluit Village');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('675e111f-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000003', '', '', '', 20, '114000006', 'CHIPS 50 GR ORIGINAL', 2000.00, 'PC', 'CO2200811', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000001', 20, '2100000054', 'Carrefour Indonesia', '2154000003', 'Carrefour Pluit Village');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('6764d420-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000003', '', '', '', 30, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000001', 30, '2100000054', 'Carrefour Indonesia', '2154000003', 'Carrefour Pluit Village');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('676cf3ce-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000003', '', '', '', 40, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000001', 40, '2100000054', 'Carrefour Indonesia', '2154000003', 'Carrefour Pluit Village');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('677655e0-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000004', '', '', '', 10, '114000005', 'CHIPS 100 GR ORIGINAL', 1000.00, 'PC', 'CO1200811', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000002', 10, '2100000054', 'Carrefour Indonesia', '2154000004', 'Transmart Carrefour Bogor Yasmin');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('678315cd-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000004', '', '', '', 20, '114000006', 'CHIPS 50 GR ORIGINAL', 2000.00, 'PC', 'CO2200811', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000002', 20, '2100000054', 'Carrefour Indonesia', '2154000004', 'Transmart Carrefour Bogor Yasmin');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('6791fdc7-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000004', '', '', '', 30, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000002', 30, '2100000054', 'Carrefour Indonesia', '2154000004', 'Transmart Carrefour Bogor Yasmin');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('679d758f-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000004', '', '', '', 40, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000002', 40, '2100000054', 'Carrefour Indonesia', '2154000004', 'Transmart Carrefour Bogor Yasmin');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('67a627a3-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000005', '', '', '', 10, '114000005', 'CHIPS 100 GR ORIGINAL', 1000.00, 'PC', 'CO1200811', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000002', 10, '2100000054', 'Carrefour Indonesia', '2154000005', 'Carrefour Bandung Sukajadi');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('67b16182-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000005', '', '', '', 20, '114000006', 'CHIPS 50 GR ORIGINAL', 2000.00, 'PC', 'CO2200811', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000002', 20, '2100000054', 'Carrefour Indonesia', '2154000005', 'Carrefour Bandung Sukajadi');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('67bc7ada-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000005', '', '', '', 30, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000002', 30, '2100000054', 'Carrefour Indonesia', '2154000005', 'Carrefour Bandung Sukajadi');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('67c2d5fb-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000005', '', '', '', 40, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000002', 40, '2100000054', 'Carrefour Indonesia', '2154000005', 'Carrefour Bandung Sukajadi');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('67f03eae-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000035', '', '', '', 10, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-24', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000022', 10, '2100000055', 'IndoMarco', '2155000001', 'Indomaret Jakarta DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('68055ba1-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000035', '', '', '', 20, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-24', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000022', 20, '2100000055', 'IndoMarco', '2155000001', 'Indomaret Jakarta DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('680fc8a7-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000036', '', '', '', 10, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-24', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000022', 10, '2100000055', 'IndoMarco', '2155000002', 'Indomaret Bogor DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('68221e6f-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000036', '', '', '', 20, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-24', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000022', 20, '2100000055', 'IndoMarco', '2155000002', 'Indomaret Bogor DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('68337e83-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000037', '', '', '', 10, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-24', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000022', 10, '2100000055', 'IndoMarco', '2155000003', 'Indomaret Bandung DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('6867f384-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000037', '', '', '', 20, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-24', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000022', 20, '2100000055', 'IndoMarco', '2155000003', 'Indomaret Bandung DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('68711ae0-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000055', '', '', '', 10, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-24', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000022', 10, '2100000056', 'Sumber Alfaria Trijaya', '2156000001', 'Alfamart Jakarta DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('687d0164-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000055', '', '', '', 20, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-24', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000022', 20, '2100000055', 'Sumber Alfaria Trijaya', '2156000001', 'Alfamart Jakarta DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('688629b7-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000056', '', '', '', 10, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-24', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000022', 10, '2100000056', 'Sumber Alfaria Trijaya', '2156000002', 'Alfamart Semarang DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('688c30d3-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000056', '', '', '', 20, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-24', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000022', 20, '2100000056', 'Sumber Alfaria Trijaya', '2156000002', 'Alfamart Semarang DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('68948944-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000057', '', '', '', 10, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-24', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000022', 10, '2100000056', 'Sumber Alfaria Trijaya', '2156000003', 'Alfamart Surabaya DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('68b2c006-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000057', '', '', '', 20, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-24', '0000-00-00', 'PLT001', 'FG001', '', '', '', '', '', '', 0.00, '', 'SO-000022', 20, '2100000055', 'Sumber Alfaria Trijaya', '2156000003', 'Alfamart Surabaya DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('68bb1f55-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000021', '', '', '', 10, '114000005', 'CHIPS 100 GR ORIGINAL', 2000.00, 'PC', 'CO1200811', '', '0000-00-00', '2020-08-21', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000011', 10, '2100000054', 'Carrefour Indonesia', '2154000006', 'Transmart Grand Kawanua');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('68c34402-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000021', '', '', '', 20, '114000006', 'CHIPS 50 GR ORIGINAL', 2000.00, 'PC', 'CO2200811', '', '0000-00-00', '2020-08-21', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000011', 20, '2100000054', 'Carrefour Indonesia', '2154000006', 'Transmart Grand Kawanua');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('68cd1f46-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000021', '', '', '', 30, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-21', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000011', 30, '2100000054', 'Carrefour Indonesia', '2154000006', 'Transmart Grand Kawanua');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('68e1c5b6-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000021', '', '', '', 40, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-21', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000011', 40, '2100000054', 'Carrefour Indonesia', '2154000006', 'Transmart Grand Kawanua');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('68e8d198-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000022', '', '', '', 10, '114000005', 'CHIPS 100 GR ORIGINAL', 2000.00, 'PC', 'CO1200811', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000011', 10, '2100000054', 'Carrefour Indonesia', '2154000007', 'Carrefour Makassar Karebossi');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('68f251d1-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000022', '', '', '', 20, '114000006', 'CHIPS 50 GR ORIGINAL', 2000.00, 'PC', 'CO2200811', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000011', 20, '2100000054', 'Carrefour Indonesia', '2154000007', 'Carrefour Makassar Karebossi');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('68fc8c1d-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000022', '', '', '', 30, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000011', 30, '2100000054', 'Carrefour Indonesia', '2154000007', 'Carrefour Makassar Karebossi');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('69028583-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000022', '', '', '', 40, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000011', 40, '2100000054', 'Carrefour Indonesia', '2154000007', 'Carrefour Makassar Karebossi');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('690c96a7-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000023', '', '', '', 10, '114000005', 'CHIPS 100 GR ORIGINAL', 2000.00, 'PC', 'CO1200811', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000011', 10, '2100000054', 'Carrefour Indonesia', '2154000008', 'Transmart Kupang');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('6915c4b8-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000023', '', '', '', 20, '114000006', 'CHIPS 50 GR ORIGINAL', 2000.00, 'PC', 'CO2200811', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000011', 20, '2100000054', 'Carrefour Indonesia', '2154000008', 'Transmart Kupang');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('6933a17d-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000023', '', '', '', 30, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000011', 30, '2100000054', 'Carrefour Indonesia', '2154000008', 'Transmart Kupang');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('693c6618-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000023', '', '', '', 40, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-22', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000011', 40, '2100000054', 'Carrefour Indonesia', '2154000008', 'Transmart Kupang');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('694f0594-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000024', '', '', '', 10, '114000005', 'CHIPS 100 GR ORIGINAL', 2000.00, 'PC', 'CO1200811', '', '0000-00-00', '2020-08-23', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000012', 10, '2100000054', 'Carrefour Indonesia', '2154000009', 'Transmart Carrefour Banjarmasin Duta Mall');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('695ad565-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000024', '', '', '', 20, '114000006', 'CHIPS 50 GR ORIGINAL', 2000.00, 'PC', 'CO2200811', '', '0000-00-00', '2020-08-23', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000012', 20, '2100000054', 'Carrefour Indonesia', '2154000009', 'Transmart Carrefour Banjarmasin Duta Mall');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('69617d82-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000024', '', '', '', 30, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-23', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000012', 30, '2100000054', 'Carrefour Indonesia', '2154000009', 'Transmart Carrefour Banjarmasin Duta Mall');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('69741137-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000024', '', '', '', 40, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-23', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000012', 40, '2100000054', 'Carrefour Indonesia', '2154000009', 'Transmart Carrefour Banjarmasin Duta Mall');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('6981d6df-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000025', '', '', '', 10, '114000005', 'CHIPS 100 GR ORIGINAL', 2000.00, 'PC', 'CO1200811', '', '0000-00-00', '2020-08-23', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000012', 10, '2100000054', 'Carrefour Indonesia', '2154000010', 'Carrefour Pontianak Urip Soemohardjo');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('698f40ad-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000025', '', '', '', 20, '114000006', 'CHIPS 50 GR ORIGINAL', 2000.00, 'PC', 'CO2200811', '', '0000-00-00', '2020-08-23', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000012', 20, '2100000054', 'Carrefour Indonesia', '2154000010', 'Carrefour Pontianak Urip Soemohardjo');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('6999fdd2-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000025', '', '', '', 30, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-23', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000012', 30, '2100000054', 'Carrefour Indonesia', '2154000010', 'Carrefour Pontianak Urip Soemohardjo');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('69a16c56-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000025', '', '', '', 40, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-23', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000012', 40, '2100000054', 'Carrefour Indonesia', '2154000010', 'Carrefour Pontianak Urip Soemohardjo');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('69a93e1a-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000041', '', '', '', 10, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-25', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000023', 10, '2100000055', 'IndoMarco', '2155000004', 'Indomaret Denpasar DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('69b24f93-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000041', '', '', '', 20, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-25', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000023', 20, '2100000055', 'IndoMarco', '2155000004', 'Indomaret Denpasar DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('69bb9353-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000042', '', '', '', 10, '114000007', 'CHIPS 100 GR BARBEQUE', 1000.00, 'PC', 'CB1200812', '', '0000-00-00', '2020-08-25', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000023', 10, '2100000055', 'IndoMarco', '2155000005', 'Indomaret Makassar DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('69c246af-f266-11ea-8b1c-00155d7dcd02', 400, 'A', 'O001', '', 'DN-000042', '', '', '', 20, '114000008', 'CHIPS 100 GR SEAWEED', 1000.00, 'PC', 'CS1200813', '', '0000-00-00', '2020-08-25', '0000-00-00', 'PLT002', 'FG201', '', '', '', '', '', '', 0.00, '', 'SO-000023', 20, '2100000055', 'IndoMarco', '2155000005', 'Indomaret Makassar DC');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ad8b3c51-e748-11ea-86d9-3c2c30f0266e', 100, 'A', 'I001', '', '4000000005', '1200000005', 'PT XYZ', '4500000105', 10, '121000101', 'RM 121000101', 1200.00, 'KG', '20200601', 'B200403', '2020-06-01', '2020-04-03', '2020-04-03', '2102', '2015', '', '', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ade862d9-e748-11ea-86d9-3c2c30f0266e', 100, 'A', 'I001', '', '4000000005', '1200000005', 'PT XYZ', '4500000105', 20, '121000105', 'RM 121000105', 1800.00, 'KG', '20200601', 'B200405', '2020-06-01', '2020-04-05', '2020-04-05', '2102', '2015', '', '', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('adecbd9f-e766-11ea-86d9-3c2c30f0266e', 100, 'A', 'I001', '', '4000000006', '1200000006', 'Kacang Makmur', '4500000106', 10, '121000111', 'Kacang Tanah', 300.00, 'KG', '20200513', 'K200510', '2020-05-13', '2020-05-10', '2021-05-10', '2102', '2015', '', '', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('adf80ab2-e766-11ea-86d9-3c2c30f0266e', 100, 'A', 'I001', '', '4000000007', '1200000007', 'Garam Abadi', '4500000107', 10, '121000211', 'Tepung Terigu', 200.00, 'KG', '20200621', 'TG200610', '2020-06-21', '2020-06-10', '2022-06-10', '2102', '2015', '', '', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ae049ec2-e766-11ea-86d9-3c2c30f0266e', 100, 'A', 'I001', '', '4000000007', '1200000007', 'Garam Abadi', '4500000107', 20, '121000212', 'Garam', 100.00, 'KG', '20200621', 'GR200620', '2020-06-21', '2020-06-20', '2022-06-20', '2102', '2015', '', '', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ae0520e9-e748-11ea-86d9-3c2c30f0266e', 200, '', '', '', '5000000005', '', '', '', 10, '121000101', 'RM 121000101', 1200.00, 'KG', '20200601', 'B200403', '0000-00-00', '0000-00-00', '0000-00-00', '2102', '2015', '2012', '2052', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ae0b5265-e748-11ea-86d9-3c2c30f0266e', 300, 'A', 'P0200', '', '', '', '', '', 10, '124000105', 'FG 124000105', 24000.00, 'PC', '20200605', '', '0000-00-00', '2020-06-05', '0000-00-00', '2012', '2052', '', '', '300005', '211000105', 'SFG 124000105', '20200604', 1200.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ae0fdde6-e766-11ea-86d9-3c2c30f0266e', 200, '', '', '', '5000000006', '', '', '', 10, '121000111', 'Kacang Tanah', 300.00, 'KG', '20200513', 'K200510', '0000-00-00', '0000-00-00', '0000-00-00', '2102', '2015', '2102', '2055', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ae11c5a9-e748-11ea-86d9-3c2c30f0266e', 300, 'A', 'P0200', '', '', '', '', '', 20, '124000105', 'FG 124000105', 24000.00, 'PC', '20200605', '', '0000-00-00', '2020-06-05', '0000-00-00', '2012', '2052', '', '', '300005', '121000105', 'RM 121000105', '20200601', 1800.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ae15c615-e766-11ea-86d9-3c2c30f0266e', 200, '', '', '', '5000000006', '', '', '', 20, '121000211', 'Tepung Terigu', 200.00, 'KG', '20200621', 'TG200610', '0000-00-00', '0000-00-00', '0000-00-00', '2102', '2015', '2102', '2055', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ae1b07d7-e748-11ea-86d9-3c2c30f0266e', 400, 'A', 'O001', '', '1000000005', '', '', '', 10, '124000105', 'FG 124000105', 240.00, 'PC', '20200605', '', '0000-00-00', '0000-00-00', '0000-00-00', '2012', '2052', '', '', '', '', '', '', 0.00, '', '10000001205', 10, '2100000055', 'IndoMarco', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ae1bee49-e766-11ea-86d9-3c2c30f0266e', 200, '', '', '', '5000000006', '', '', '', 30, '121000212', 'Garam', 100.00, 'KG', '20200621', 'GR200620', '0000-00-00', '0000-00-00', '0000-00-00', '2102', '2015', '2102', '2055', '', '', '', '', 0.00, '', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ae21cc59-e766-11ea-86d9-3c2c30f0266e', 300, 'A', 'P0100', '', '', '', '', '', 10, '211000212', 'Adonan Kacang', 300.00, 'KG', '20200630', '', '0000-00-00', '2020-06-30', '0000-00-00', '2102', '2055', '', '', '300006', '121000211', 'Tepung Terigu', '20200621', 200.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ae27bc8e-e766-11ea-86d9-3c2c30f0266e', 300, 'A', 'P0100', '', '', '', '', '', 20, '211000212', 'Adonan Kacang', 300.00, 'KG', '20200630', '', '0000-00-00', '2020-06-30', '0000-00-00', '2102', '2055', '', '', '300006', '121000212', 'Garam', '20200621', 100.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ae2d921b-e766-11ea-86d9-3c2c30f0266e', 300, 'A', 'P0200', '', '', '', '', '', 10, '8994016003525', 'Kacang Emas', 200.00, 'PC', '0207MC02', '', '0000-00-00', '2020-07-02', '0000-00-00', '2102', '2055', '', '', '300007', '121000111', 'Kacang Tanah', '20200513', 300.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ae33bce2-e766-11ea-86d9-3c2c30f0266e', 300, 'A', 'P0200', '', '', '', '', '', 20, '8994016003525', 'Kacang Emas', 200.00, 'PC', '0207MC02', '', '0000-00-00', '2020-07-02', '0000-00-00', '2102', '2055', '', '', '300007', '211000212', 'Adonan Kacang', '20200630', 300.00, 'KG', '', 0, '', '', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ae397721-e766-11ea-86d9-3c2c30f0266e', 400, 'A', 'O001', '', '1000000006', '', '', '', 10, '8994016003525', 'Kacang Emas', 150.00, 'PC', '0207MC02', '', '0000-00-00', '0000-00-00', '0000-00-00', '2102', '2055', '', '', '', '', '', '', 0.00, '', '10000001205', 10, '2100000055', 'Sumber Alfaria', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('ae3f6be9-e766-11ea-86d9-3c2c30f0266e', 400, 'A', 'O001', '', '1000000007', '', '', '', 10, '8994016003525', 'Kacang Emas', 50.00, 'PC', '0207MC02', '', '0000-00-00', '0000-00-00', '0000-00-00', '2102', '2055', '', '', '', '', '', '', 0.00, '', '10000001206', 10, '2100000056', 'Sumber AlfaMART', NULL, NULL);
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`, `ShiptoID`, `ShiptoName`) VALUES
	('b5c0d729-e763-11ea-86d9-3c2c30f0266e', 300, 'A', 'P0100', '', '', '', '', '', 10, '211000105', 'SFG 124000105', 30000.00, 'KG', '20200604', '', '0000-00-00', '2020-06-04', '0000-00-00', '2012', '2052', '', '', '300004', '121000101', 'RM 121000101', '20200601', 1200.00, 'KG', '', 0, '', '', NULL, NULL);
/*!40000 ALTER TABLE `tbl_transaksi` ENABLE KEYS */;

-- Dumping structure for table powerbitable.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table powerbitable.users: ~0 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `password`) VALUES
	('1', 'admin', 'admin');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for view powerbitable.view_relationship
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_relationship` (
	`UUID()` VARCHAR(36) NOT NULL COLLATE 'utf8_general_ci',
	`UUID` VARCHAR(255) NOT NULL COLLATE 'latin1_swedish_ci',
	`UUID2` VARCHAR(255) NULL COLLATE 'latin1_swedish_ci'
) ENGINE=MyISAM;

-- Dumping structure for view powerbitable.view_relationship
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_relationship`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_relationship` AS SELECT
	UUID(), a.UUID,
	(
		SELECT
			UUID
		FROM 
			tbl_transaksi b
		WHERE
			b.MaterialCode = a.MaterialCode
			AND b.Batch = a.Batch
			AND b.Step_ID = 200
	) AS UUID2
FROM
	tbl_transaksi a ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
