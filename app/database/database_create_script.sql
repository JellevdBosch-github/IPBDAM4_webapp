/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Databasestructuur van staging wordt geschreven
CREATE DATABASE IF NOT EXISTS `staging` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `staging`;

-- Structuur van  tabel staging.audittrail wordt geschreven
CREATE TABLE IF NOT EXISTS `audittrail` (
  `audittrail_id` int(11) NOT NULL AUTO_INCREMENT,
  `load_start` char(13) NOT NULL,
  `load_end` char(13) NOT NULL,
  `etl_component` varchar(50) NOT NULL,
  `source` varchar(50) NOT NULL,
  `destination` varchar(50) NOT NULL,
  `nr_records_processed` int(11) DEFAULT NULL,
  `nr_records_ok` int(11) DEFAULT NULL,
  `nr_records_error` int(11) DEFAULT NULL,
  `action` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`audittrail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- Dumpen data van tabel staging.audittrail: ~8 rows (ongeveer)
/*!40000 ALTER TABLE `audittrail` DISABLE KEYS */;
INSERT INTO `audittrail` (`audittrail_id`, `load_start`, `load_end`, `etl_component`, `source`, `destination`, `nr_records_processed`, `nr_records_ok`, `nr_records_error`, `action`) VALUES
	(1, '1617890763403', '1617890763860', 'currency_to_staging', 'binance api: ticker', 'database: staging | table: currency', 1, 1, 0, 'INSERT'),
	(2, '1617890763912', '1617890764307', 'kline_to_staging', 'binance api: kline', 'database: staging | table: candlestick', 1, 1, 0, 'INSERT'),
	(3, '1617890789152', '1617890789718', 'currency_to_staging', 'binance api: ticker', 'database: staging | table: currency', 1, 1, 0, 'UPDATE'),
	(4, '1617890789810', '1617890790221', 'kline_to_staging', 'binance api: kline', 'database: staging | table: candlestick', 1, 1, 0, 'INSERT'),
	(5, '1617890873008', '1617890873555', 'kline_to_staging', 'binance api: kline', 'database: staging | table: candlestick', 1, 1, 0, 'INSERT'),
	(6, '1617892771404', '1617892771921', 'kline_to_staging', 'binance api: kline', 'database: staging | table: candlestick', 1, 1, 0, 'INSERT'),
	(7, '1617895260716', '1617895261191', 'kline_to_staging', 'binance api: kline', 'database: staging | table: candlestick', 1, 1, 0, 'INSERT'),
	(8, '1617903155746', '1617903156227', 'kline_to_staging', 'binance api: kline', 'database: staging | table: candlestick', 1, 1, 0, 'INSERT'),
	(9, '1617905448024', '1617905449186', 'kline_to_staging', 'binance api: kline', 'database: staging | table: candlestick', 1, 1, 0, 'INSERT');
/*!40000 ALTER TABLE `audittrail` ENABLE KEYS */;

-- Structuur van  tabel staging.currency wordt geschreven
CREATE TABLE IF NOT EXISTS `currency` (
  `currency_id` varchar(8) NOT NULL,
  `name` varchar(25) DEFAULT NULL,
  `price_change` decimal(20,10) DEFAULT NULL,
  `percent_change` decimal(6,2) DEFAULT NULL,
  `previous_close_price` decimal(20,10) DEFAULT NULL,
  `last_price` decimal(20,10) DEFAULT NULL,
  PRIMARY KEY (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumpen data van tabel staging.currency: ~1 rows (ongeveer)
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` (`currency_id`, `name`, `price_change`, `percent_change`, `previous_close_price`, `last_price`) VALUES
	('DOGEEUR', 'Dogecoin', 0.0007800000, 1.54, 0.0505800000, 0.0514200000);
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;

-- Structuur van  tabel staging.wallet wordt geschreven
CREATE TABLE IF NOT EXISTS `wallet` (
  `wallet_id` char(36) NOT NULL,
  `eur_value` decimal(10,2) DEFAULT NULL,
  `usd_value` decimal(10,2) DEFAULT NULL,
  `doge_value` decimal(20,10) DEFAULT NULL,
  PRIMARY KEY (`wallet_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumpen data van tabel staging.wallet: ~1 rows (ongeveer)
/*!40000 ALTER TABLE `wallet` DISABLE KEYS */;
INSERT INTO `wallet` (`wallet_id`, `eur_value`, `usd_value`, `doge_value`) VALUES
	('\r\n5bbd0152-1799-43a8-8193-08ee6807dc', 10000.00, 11889.50, 194040.6996000000);
/*!40000 ALTER TABLE `wallet` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

-- Structuur van  tabel staging.candlestick wordt geschreven
CREATE TABLE IF NOT EXISTS `candlestick` (
  `candlestick_id` char(36) NOT NULL,
  `currency_id` varchar(8) NOT NULL,
  `open_timestamp` char(13) NOT NULL,
  `close_timestamp` char(13) NOT NULL,
  `open` decimal(20,10) NOT NULL,
  `close` decimal(20,10) NOT NULL,
  `high` decimal(20,10) NOT NULL,
  `low` decimal(20,10) NOT NULL,
  PRIMARY KEY (`candlestick_id`),
  KEY `currency_id` (`currency_id`),
  CONSTRAINT `currency_candlestick` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumpen data van tabel staging.candlestick: ~6 rows (ongeveer)
/*!40000 ALTER TABLE `candlestick` DISABLE KEYS */;
INSERT INTO `candlestick` (`candlestick_id`, `currency_id`, `open_timestamp`, `close_timestamp`, `open`, `close`, `high`, `low`) VALUES
	('07c2e8ab-95ea-44f5-975d-f6a82df973e3', 'DOGEEUR', '1617890400000', '1617893999999', 0.0513300000, 0.0514700000, 0.0514700000, 0.0513100000),
	('0e2f9bbc-6e32-4c7d-8fa8-74544ecb376a', 'DOGEEUR', '1617890400000', '1617893999999', 0.0513300000, 0.0514200000, 0.0514300000, 0.0513100000),
	('5e4dd1aa-0f9c-4375-883b-4ec161922726', 'DOGEEUR', '1617901200000', '1617904799999', 0.0513100000, 0.0512500000, 0.0515400000, 0.0512400000),
	('6884b91c-9b23-4d59-97cd-b2d4b38fa810', 'DOGEEUR', '1617904800000', '1617908399999', 0.0511600000, 0.0513200000, 0.0513700000, 0.0511600000),
	('6ea76d9b-d0c3-468d-9224-d629bc805484', 'DOGEEUR', '1617894000000', '1617897599999', 0.0515500000, 0.0514100000, 0.0515700000, 0.0514100000),
	('d9e77f40-b135-486b-9981-685f95b045a8', 'DOGEEUR', '1617890400000', '1617893999999', 0.0513300000, 0.0514900000, 0.0516000000, 0.0513100000),
	('e86d01c3-a077-4d1d-8ee5-a92907df0cf8', 'DOGEEUR', '1617890400000', '1617893999999', 0.0513300000, 0.0514200000, 0.0514300000, 0.0513100000);
/*!40000 ALTER TABLE `candlestick` ENABLE KEYS */;



-- Structuur van  tabel staging.trade wordt geschreven
CREATE TABLE IF NOT EXISTS `trade` (
  `trade_id` char(36) NOT NULL,
  `wallet_id` char(36) NOT NULL,
  `currency_id` varchar(8) NOT NULL,
  `original_id` char(36) DEFAULT NULL,
  `original` int(1) NOT NULL DEFAULT 0,
  `price` decimal(20,10) NOT NULL,
  `quantity` int(9) NOT NULL,
  `eur_value` decimal(20,10) NOT NULL,
  `usd_value` decimal(20,10) NOT NULL,
  `doge_value` decimal(20,10) NOT NULL,
  `status` varchar(25) DEFAULT NULL,
  `success` int(1) NOT NULL,
  `error_code` int(3) DEFAULT NULL,
  `error_message` varchar(255) DEFAULT NULL,
  `timestamp` char(13) NOT NULL DEFAULT '',
  `taker_side` int(1) NOT NULL,
  `wallet_eur_value` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`trade_id`),
  KEY `wallet_id` (`wallet_id`),
  KEY `currency_id` (`currency_id`),
  KEY `original_id` (`original_id`),
  CONSTRAINT `currency_trade` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `trade_trade` FOREIGN KEY (`original_id`) REFERENCES `trade` (`trade_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `wallet_trade` FOREIGN KEY (`wallet_id`) REFERENCES `wallet` (`wallet_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumpen data van tabel staging.trade: ~0 rows (ongeveer)
/*!40000 ALTER TABLE `trade` DISABLE KEYS */;
/*!40000 ALTER TABLE `trade` ENABLE KEYS */;


