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

-- Dumping data for table powerbitable.material_inventorytransfer: ~1 rows (approximately)
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
	(300, 2, 'MaterialCode', 'MaterialCode');
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

-- Dumping data for table powerbitable.split_invtrans_rel: ~2 rows (approximately)
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

-- Dumping data for table powerbitable.split_inv_transfer: ~4 rows (approximately)
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
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabel transaksi';

-- Dumping data for table powerbitable.tbl_transaksi: ~41 rows (approximately)
/*!40000 ALTER TABLE `tbl_transaksi` DISABLE KEYS */;
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('128edbc7-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000010', '1200000011', 'CAHAYA ABADI', '4500000123', 10, '121001055', 'Garam Samudra', 800.00, 'KG', '20191003', 'B190925', '2019-10-03', '2019-09-25', '2024-09-25', '2102', '2015', '', '', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('12a8445f-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000010', '1200000011', 'CAHAYA ABADI', '4500000123', 20, '121001156', 'Garlic Powder FII J-01009', 100.00, 'KG', '20191003', 'B190926', '2019-10-03', '2019-09-26', '2021-09-26', '2102', '2015', '', '', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('12b62d32-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000034', '', '', '', 10, '121001055', 'Garam Samudra', 400.00, 'KG', '20191003', 'B190925', '2019-10-09', '0000-00-00', '0000-00-00', '2102', '2015', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('12cae258-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 10, '211000010', 'SFG MSG/Masako Bulk', 1000.00, 'KG', '20191010', '', '0000-00-00', '2019-10-10', '0000-00-00', '2021', '2052', '', '', '300010', '121001055', 'Garam Samudra', '20191003', 400.00, 'KG', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('12d7bb71-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 20, '211000010', 'SFG MSG/Masako Bulk', 1000.00, 'KG', '20191010', '', '0000-00-00', '2019-10-10', '0000-00-00', '2021', '2052', '', '', '300010', '121001156', 'Garlic Powder FII J-01009', '20190930', 200.00, 'KG', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('13009a8b-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0200', '', '', '', '', '', 10, '124000714', '250MA C (1 x 48) 250 g', 500.00, 'PC', '20191011', '', '0000-00-00', '2019-10-11', '0000-00-00', '2021', '2052', '', '', '300012', '211000010', 'SFG MSG Bulk', '20191010', 300.00, 'KG', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('130ca89f-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0200', '', '', '', '', '', 20, '124000714', '250MA C (1 x 48) 250 g', 500.00, 'PC', '20191011', '', '0000-00-00', '2019-10-11', '0000-00-00', '2021', '2052', '', '', '300012', '211000013', 'CHICKEN FAT - EMP', '20191010', 200.00, 'KG', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('131689d3-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0200', '', '', '', '', '', 30, '124000714', '250MA C (1 x 48) 250 g', 500.00, 'PC', '20191011', '', '0000-00-00', '2019-10-11', '0000-00-00', '2021', '2052', '', '', '300012', '122000100', 'Packing 250 MA', '20191010', 500.00, 'PC', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('131efad9-d622-11ea-8b0a-bcee7b513d25', 400, 'A', 'O001', '', '1000000021', '', '', '', 10, '124000714', '250MA C (1 x 48) 250 g', 240.00, 'PC', '20191011', '', '0000-00-00', '2019-10-11', '0000-00-00', '2021', '2052', '', '', '', '', '', '', 0.00, '', '10000001232', 10, '2100000054', 'CAREFOUR LB');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('132affa0-d622-11ea-8b0a-bcee7b513d25', 400, 'A', 'O001', '', '1000000022', '', '', '', 10, '124000714', '250MA C (1 x 48) 250 g', 100.00, 'PC', '20191011', '', '0000-00-00', '2019-10-11', '0000-00-00', '2021', '2052', '', '', '', '', '', '', 0.00, '', '10000001233', 10, '2100000055', 'IndoMarco');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('1337272d-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000011', '1200000010', 'PT ABC', '4500000124', 10, '121000100', 'RM 121000100', 5000.00, 'KG', '20200801', 'B190927', '2020-08-01', '2020-07-01', '2025-07-01', '2102', '2015', '', '', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('1344607f-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000011', '1200000010', 'PT ABC', '4500000124', 20, '121000101', 'RM 121000101', 1000.00, 'KG', '20200801', 'B190928', '2020-08-01', '2020-07-01', '2025-07-01', '2102', '2015', '', '', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('13554aee-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000011', '1200000010', 'PT ABC', '4500000124', 30, '121000102', 'RM 121000102', 1000.00, 'KG', '20200801', 'B190929', '2020-08-01', '2020-07-01', '2025-07-01', '2102', '2015', '', '', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('135e8b49-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000035', '', '', '', 10, '121000100', 'RM 121000100', 500.00, 'KG', '20200801', 'B190927', '2020-08-02', '0000-00-00', '0000-00-00', '2102', '2015', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('1367f825-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000035', '', '', '', 20, '121001055', 'Garam Samudra', 100.00, 'KG', '20191003', 'B190925', '2020-08-02', '0000-00-00', '0000-00-00', '2102', '2015', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('1372975a-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000035', '', '', '', 30, '121000101', 'RM 121000101', 300.00, 'KG', '20200801', 'B190928', '2020-08-02', '0000-00-00', '0000-00-00', '2102', '2015', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('138a223d-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000035', '', '', '', 40, '121000102', 'RM 121000102', 300.00, 'KG', '20200801', 'B190929', '2020-08-02', '0000-00-00', '0000-00-00', '2102', '2015', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('13a57923-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000036', '', '', '', 10, '121000100', 'RM 121000100', 500.00, 'KG', '20200801', 'B190927', '2020-08-03', '0000-00-00', '0000-00-00', '2102', '2015', '2103', '2001', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('13b25d6b-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000036', '', '', '', 20, '121000101', 'RM 121000101', 400.00, 'KG', '20200801', 'B190928', '2020-08-03', '0000-00-00', '0000-00-00', '2102', '2015', '2103', '2001', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('13c0fd60-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000036', '', '', '', 30, '121000102', 'RM 121000102', 300.00, 'KG', '20200801', 'B190929', '2020-08-03', '0000-00-00', '0000-00-00', '2102', '2015', '2103', '2001', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('13cbbd99-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 10, '211000011', 'SFG 211000011', 1200.00, 'KG', '20200803', '', '0000-00-00', '2020-08-03', '0000-00-00', '2102', '2052', '', '', '300011', '121000100', 'RM 121000100', 'B190927', 500.00, 'KG', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('13d80601-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 20, '211000011', 'SFG 211000011', 1200.00, 'KG', '20200803', '', '0000-00-00', '2020-08-03', '0000-00-00', '2102', '2052', '', '', '300011', '121000101', 'RM 121000101', 'B190928', 300.00, 'KG', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('13e62d6d-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 30, '211000011', 'SFG 211000011', 1200.00, 'KG', '20200803', '', '0000-00-00', '2020-08-03', '0000-00-00', '2102', '2052', '', '', '300011', '121000102', 'RM 121000102', 'B190929', 300.00, 'KG', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('13f311d3-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 40, '211000011', 'SFG 211000011', 1200.00, 'KG', '20200803', '', '0000-00-00', '2020-08-03', '0000-00-00', '2102', '2052', '', '', '300011', '121001055', 'Garam Samudra', '20191003', 100.00, 'KG', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('13fbac75-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000001', '1200000008', 'PT XYZ', '4500000100', 10, '121000100', 'RM 121000100', 1800.00, 'KG', '20190601', 'B190800', '2019-06-01', '2019-05-28', '2022-05-28', '2102', '2014', '', '', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('14059fc5-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000001', '1200000008', 'PT XYZ', '4500000100', 20, '121000101', 'RM 121000101', 800.00, 'KG', '20190601', 'B190801', '2019-06-01', '2019-05-28', '2022-05-28', '2102', '2014', '', '', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('140dde2b-d622-11ea-8b0a-bcee7b513d25', 100, 'A', 'I001', '', '4000000001', '1200000008', 'PT XYZ', '4500000100', 30, '121000103', 'RM 121000103', 1000.00, 'KG', '20190601', 'B190802', '2019-06-01', '2019-05-28', '2022-05-28', '2102', '2014', '', '', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('141f0b13-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000001', '', '', '', 10, '121000100', 'RM 121000100', 400.00, 'KG', '20190601', 'B190800', '2019-06-05', '0000-00-00', '0000-00-00', '2102', '2014', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('1433e7ba-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000001', '', '', '', 20, '121000101', 'RM 121000101', 300.00, 'KG', '20190601', 'B190801', '2019-06-05', '0000-00-00', '0000-00-00', '2102', '2014', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('1445f7e6-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000001', '', '', '', 30, '121000103', 'RM 121000103', 200.00, 'KG', '20190601', 'B190802', '2019-06-05', '0000-00-00', '0000-00-00', '2102', '2014', '2102', '2052', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('14522cb2-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 10, '211000011', 'SFG 211000011', 900.00, 'KG', '20190606', '', '0000-00-00', '2019-06-06', '0000-00-00', '2102', '2052', '', '', '300001', '121000100', 'RM 121000100', 'B190800', 400.00, 'KG', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('1460ad04-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 20, '211000011', 'SFG 211000011', 900.00, 'KG', '20190606', '', '0000-00-00', '2019-06-06', '0000-00-00', '2102', '2052', '', '', '300001', '121000101', 'RM 121000101', 'B190801', 300.00, 'KG', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('146d8fa5-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0100', '', '', '', '', '', 30, '211000011', 'SFG 211000011', 900.00, 'KG', '20190606', '', '0000-00-00', '2019-06-06', '0000-00-00', '2102', '2052', '', '', '300001', '121000103', 'RM 121000103', 'B190802', 200.00, 'KG', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('147ac21e-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000002', '', '', '', 10, '121000100', 'RM 121000100', 500.00, 'KG', '20190601', 'B190800', '2019-06-06', '0000-00-00', '0000-00-00', '2102', '2014', '2103', '2001', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('148e20cd-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000002', '', '', '', 20, '121000101', 'RM 121000101', 200.00, 'KG', '20190601', 'B190801', '2019-06-06', '0000-00-00', '0000-00-00', '2102', '2014', '2103', '2001', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('149849e6-d622-11ea-8b0a-bcee7b513d25', 200, '', '', '', '5000000002', '', '', '', 30, '121000103', 'RM 121000103', 300.00, 'KG', '20190601', 'B190802', '2019-06-06', '0000-00-00', '0000-00-00', '2102', '2014', '2103', '2001', '', '', '', '', 0.00, '', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('14a3bfc0-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0200', '', '', '', '', '', 10, '124000100', 'FG 124000100', 3600.00, 'PC', '20190608', '', '0000-00-00', '2019-06-09', '0000-00-00', '2102', '2052', '', '', '300001', '211000011', 'SFG 211000011', '20190606', 900.00, 'KG', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('14b3716a-d622-11ea-8b0a-bcee7b513d25', 300, 'A', 'P0200', '', '', '', '', '', 20, '124000100', 'FG 124000100', 3600.00, 'PC', '20190608', '', '0000-00-00', '2019-06-09', '0000-00-00', '2102', '2052', '', '', '300001', '122000100', 'Packing 124000100', '20190601', 3600.00, 'PC', '', 0, '', '');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('14c08c82-d622-11ea-8b0a-bcee7b513d25', 400, 'A', 'O001', '', '1000000001', '', '', '', 10, '124000100', 'FG 124000100', 100.00, 'PC', '20190608', '', '0000-00-00', '2019-06-15', '0000-00-00', '2102', '2052', '', '', '', '', '', '', 0.00, '', '10000001200', 10, '2100000055', 'IndoMarco');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('14caef01-d622-11ea-8b0a-bcee7b513d25', 400, 'A', 'O001', '', '1000000002', '', '', '', 10, '124000100', 'FG 124000100', 200.00, 'PC', '20190608', '', '0000-00-00', '2019-06-15', '0000-00-00', '2102', '2052', '', '', '', '', '', '', 0.00, '', '10000001201', 10, '2100000050', 'Customer 2100000050');
INSERT INTO `tbl_transaksi` (`UUID`, `Step_ID`, `Prod_Grp`, `Key`, `User_Define`, `DocumentNo`, `VendorID`, `VendorName`, `PONumber`, `LineNo`, `MaterialCode`, `MaterialDescription`, `Quantity`, `UoM`, `Batch`, `BatchVendor`, `DocumentDate`, `ProductionDate`, `ExpiredDate`, `Plant`, `Warehouse`, `ToPlant`, `ToWarehouse`, `WorkOrder`, `RM_MaterialCode`, `RM_MaterialDescription`, `RM_Batch`, `RM_Quantity`, `RM_UOM`, `SalesOrder`, `Sales_LineNo`, `CustomerID`, `CustomerName`) VALUES
	('14d99739-d622-11ea-8b0a-bcee7b513d25', 400, 'A', 'O001', '', '1000000003', '', '', '', 10, '124000100', 'FG 124000100', 300.00, 'PC', '20190608', '', '0000-00-00', '2019-06-15', '0000-00-00', '2102', '2052', '', '', '', '', '', '', 0.00, '', '10000001202', 10, '2100000051', 'Customer 2100000051');
/*!40000 ALTER TABLE `tbl_transaksi` ENABLE KEYS */;

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
