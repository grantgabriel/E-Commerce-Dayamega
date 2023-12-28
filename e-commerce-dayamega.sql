-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 28 Des 2023 pada 03.38
-- Versi server: 8.0.30
-- Versi PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `e-commerce-dayamega`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addCategory` (IN `category_id` CHAR(2), IN `category` VARCHAR(255))   BEGIN
    INSERT INTO categories VALUES (category_id, category);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addItems` (IN `product_id` CHAR(9), IN `product_name` TEXT, IN `stock` INT, IN `category_id` CHAR(2), IN `photo` VARCHAR(255), IN `user_prices` DECIMAL(10,0), IN `dealer_prices` DECIMAL(10,0), IN `spec_display` VARCHAR(255), IN `spec_ram` VARCHAR(255), IN `spec_proc` VARCHAR(255), IN `spec_gpu` VARCHAR(255), IN `spec_storage` VARCHAR(255), IN `spec_audio` VARCHAR(255), IN `spec_battery` VARCHAR(255), IN `spec_weight` VARCHAR(255), IN `spec_connectivity` VARCHAR(255), IN `spec_camera` VARCHAR(255), IN `spec_extandable_ram` VARCHAR(255), IN `spec_extandable_ssd` VARCHAR(255), IN `spec_dimension` VARCHAR(255), IN `description` TEXT(255), IN `operating_system` VARCHAR(255), IN `antivirus` VARCHAR(255))   BEGIN
    INSERT INTO products VALUES (
        product_id,
        product_name,
        stock,
        category_id,
        photo,
        user_prices,
        dealer_prices,
        spec_display,
        spec_ram,
        spec_proc,
        spec_gpu,
        spec_storage,
        spec_audio,
        spec_battery,
        spec_weight,
        spec_connectivity,
        spec_camera,
        spec_extandable_ram,
        spec_extandable_ssd,
        spec_dimension,
        description,
        operating_system,
        antivirus
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `appendCouriers` (IN `user_id` CHAR(9), IN `name` VARCHAR(255), IN `email` VARCHAR(255), IN `phone_number` VARCHAR(14), IN `password` VARCHAR(255), IN `hourly_fee` DECIMAL(10,0), IN `vehicle` VARCHAR(255))   BEGIN
    DECLARE level_user CHAR(9);
    SET level_user = 'Courier';

    INSERT INTO users VALUES(user_id, name, level_user, NOW(), NULL, email, phone_number, password);
    INSERT INTO couriers VALUES(user_id, hourly_fee, vehicle);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `appendCustomers` (IN `user_id` CHAR(9), IN `name` VARCHAR(255), IN `email` VARCHAR(255), IN `phone_number` VARCHAR(14), IN `password` VARCHAR(255), IN `address` TEXT)   BEGIN
    DECLARE level_user CHAR(9);
    SET level_user = 'Users';

    INSERT INTO users VALUES(user_id, name, level_user, NOW(), NULL, email, phone_number, password);
    INSERT INTO customers VALUES(user_id, NULL, address, NULL);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `appendSales` (IN `user_id` CHAR(9), IN `name` VARCHAR(255), IN `email` VARCHAR(255), IN `phone_number` VARCHAR(14), IN `password` VARCHAR(255), IN `position` VARCHAR(255), IN `salary` VARCHAR(30), IN `gender` VARCHAR(10), IN `background_ed` VARCHAR(255), IN `employment_type` VARCHAR(255))   BEGIN
    DECLARE level_user CHAR(9);
    SET level_user = 'Sales';

    INSERT INTO users VALUES(user_id, name, level_user, NOW(), NULL, email, phone_number, password);
    INSERT INTO salesman VALUES(user_id, position, salary, gender, background_ed, employment_type);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCategory` (IN `category_id` CHAR(2))   BEGIN
    DELETE FROM categories WHERE category_id = category_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCouriers` (IN `user_id_param` CHAR(9))   BEGIN
    DECLARE user_level VARCHAR(9);

    SELECT level_user INTO user_level FROM users WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci LIMIT 1;

    IF (user_level = 'Courier') THEN
        DELETE FROM users WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci;
        DELETE FROM couriers WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCustomers` (IN `user_id_param` CHAR(9))   BEGIN
    DECLARE user_level VARCHAR(9);

    SELECT level_user INTO user_level FROM users WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci LIMIT 1;

    IF (user_level = 'Users') THEN
        DELETE FROM users WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci;
        DELETE FROM customers WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteItems` (IN `product_id_param` CHAR(9))   BEGIN
    DECLARE converted_id CHAR(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
    SET converted_id = CONVERT(product_id_param USING utf8mb4);
    DELETE FROM products WHERE product_id = converted_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePurchase` (IN `order_id_param` CHAR(10))   BEGIN
    DECLARE converted_order_id CHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
    SET converted_order_id = CONVERT(order_id_param USING utf8mb4);
    DELETE FROM orders WHERE order_id = converted_order_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteSales` (IN `user_id_param` CHAR(9))   BEGIN
    DECLARE user_level VARCHAR(9);

    SELECT level_user INTO user_level FROM users WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci LIMIT 1;

    IF (user_level = 'Sales') THEN
        DELETE FROM users WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci;
        DELETE FROM salesman WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getSalesReport` (`month` INT)   BEGIN
    DECLARE startDate DATETIME;
    DECLARE endDate DATETIME;

    SET startDate = CONCAT(YEAR(CURDATE()), '-', LPAD(month, 2, '0'), '-01 00:00:00');
    SET endDate = LAST_DAY(startDate) + INTERVAL 1 DAY - INTERVAL 1 SECOND;

    SELECT
        order_id,
        u.name AS user_name,
        p.product_name,
        total,
        order_date
    FROM
        orders o
        JOIN products p ON p.product_id = o.product_id
        JOIN users u ON u.user_id = o.user_id
    WHERE
        order_date >= startDate AND order_date <= endDate
    ORDER BY
        order_date DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `reportsIssue` (IN `user_id` CHAR(9), IN `description` TEXT)   BEGIN
    INSERT INTO reports VALUES (
        generateUniqueID(5),
        user_id, 
        description,
        'Unresolved',
        NOW()
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateItemPrices` (IN `product_id_param` CHAR(9), IN `dealer_prices_param` DECIMAL(10,0))   BEGIN
    DECLARE converted_product_id CHAR(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
    SET converted_product_id = CONVERT(product_id_param USING utf8mb4);
    UPDATE products SET dealer_prices = dealer_prices_param WHERE product_id = converted_product_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateItemStocks` (IN `product_id_param` CHAR(9), IN `stock_param` INT)   BEGIN
    DECLARE converted_product_id CHAR(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
    SET converted_product_id = CONVERT(product_id_param USING utf8mb4);
    UPDATE products SET stock = stock_param WHERE product_id = converted_product_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateOrderStatus` (IN `order_id_param` CHAR(10), IN `status_param` VARCHAR(255), IN `message_param` VARCHAR(255))   BEGIN
    DECLARE order_id_temp CHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
    DECLARE message_temp VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

    SET order_id_temp = order_id_param;
    SET message_temp = message_param;

    UPDATE orders SET status = status_param WHERE order_id COLLATE utf8mb4_general_ci = order_id_temp;
    UPDATE orders SET message = message_param WHERE order_id COLLATE utf8mb4_general_ci = order_id_temp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateReport` (`report_id_param` CHAR(5))   BEGIN
    DECLARE report_id_cv CHAR(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
    SET report_id_cv = CONVERT(report_id_param USING utf8mb4);
    UPDATE reports SET status = 'Resolved' WHERE report_id = report_id_cv;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `countConfirmedPackages` () RETURNS INT DETERMINISTIC BEGIN
    DECLARE fConfirmedPackages INT;
    
    SELECT COUNT(*) INTO fConfirmedPackages FROM orders 
    WHERE status = 'Confirmed';

    RETURN fConfirmedPackages;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countCouriers` () RETURNS INT DETERMINISTIC BEGIN
    DECLARE fCourier INT;
    SELECT COUNT(*) INTO fCourier FROM users WHERE level_user = 'Courier';
    RETURN fCourier;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countCustomer` () RETURNS INT DETERMINISTIC BEGIN
    DECLARE fUser INT;
    SELECT COUNT(*) INTO fUser FROM users WHERE level_user = 'Users';
    RETURN fUser;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countDeliveredPackages` (`courier_id_param` CHAR(9)) RETURNS INT DETERMINISTIC BEGIN
    DECLARE fDeliveredPackages INT;
    
    SELECT COUNT(*) INTO fDeliveredPackages FROM orders 
    WHERE courier_id COLLATE utf8mb4_general_ci = courier_id_param COLLATE utf8mb4_general_ci 
    AND status = 'Received';

    RETURN fDeliveredPackages;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countMonthlyDeliveredPackages` (`month` INT) RETURNS INT DETERMINISTIC BEGIN
    DECLARE fDeliveredPackages INT;
    
    SELECT COUNT(*) INTO fDeliveredPackages FROM orders 
    WHERE status = 'Received' AND 
    MONTH(order_date) = month;

    RETURN fDeliveredPackages;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countMonthlyResolvedReports` (`input_month` INT) RETURNS INT DETERMINISTIC BEGIN
    DECLARE fResolvedReports INT;

    SELECT COUNT(*) INTO fResolvedReports 
    FROM reports 
    WHERE status = 'Resolved' 
    AND MONTH(time) = input_month;

    RETURN fResolvedReports;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countMonthlySoldProducts` (`input_month` INT) RETURNS INT DETERMINISTIC BEGIN
    DECLARE fSold INT;

    SELECT COUNT(*) INTO fSold 
    FROM orders 
    WHERE MONTH(order_date) = input_month
    AND status = 'Received';

    RETURN fSold;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countMonthlyUnresolvedReports` (`input_month` INT) RETURNS INT DETERMINISTIC BEGIN
    DECLARE fUnresolvedReports INT;

    SELECT COUNT(*) INTO fUnresolvedReports 
    FROM reports 
    WHERE status = 'Unresolved' 
    AND MONTH(time) = input_month;

    RETURN fUnresolvedReports;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countOutOfStocks` () RETURNS INT DETERMINISTIC BEGIN
    DECLARE fOutOfStocks INT;

    SELECT COUNT(*) INTO fOutOfStocks FROM empty_stock;

    RETURN fOutOfStocks;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countResolvedReports` () RETURNS INT DETERMINISTIC BEGIN
    DECLARE fResolvedReports INT;
    SELECT COUNT(*) INTO fResolvedReports FROM reports WHERE status = 'Resolved';
    RETURN fResolvedReports;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countSales` () RETURNS INT DETERMINISTIC BEGIN
    DECLARE fSales INT;
    SELECT COUNT(*) INTO fSales FROM users WHERE level_user = 'Sales';
    RETURN fSales;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countTotalDeliveredPackages` () RETURNS INT DETERMINISTIC BEGIN
    DECLARE fDeliveredPackages INT;
    
    SELECT COUNT(*) INTO fDeliveredPackages FROM orders 
    WHERE status = 'Received';

    RETURN fDeliveredPackages;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countTresholdStocks` () RETURNS INT DETERMINISTIC BEGIN
    DECLARE fTresholdStocks INT;

    SELECT COUNT(*) INTO fTresholdStocks FROM treshold_stock;

    RETURN fTresholdStocks;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countUnconfirmedPackages` () RETURNS INT DETERMINISTIC BEGIN
    DECLARE fUnconfirmedPackages INT;
    
    SELECT COUNT(*) INTO fUnconfirmedPackages FROM orders 
    WHERE status = 'Unconfirmed';

    RETURN fUnconfirmedPackages;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countUndeliveredPackages` (`courier_id_param` CHAR(9)) RETURNS INT DETERMINISTIC BEGIN
    DECLARE fDeliveredPackages INT;
    
    SELECT COUNT(*) INTO fDeliveredPackages FROM orders 
    WHERE courier_id COLLATE utf8mb4_general_ci = courier_id_param COLLATE utf8mb4_general_ci 
    AND status = 'Confirmed';

    RETURN fDeliveredPackages;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countUnresolvedReports` () RETURNS INT DETERMINISTIC BEGIN
    DECLARE fUnresolvedReports INT;
    SELECT COUNT(*) INTO fUnresolvedReports FROM reports WHERE status = 'Unresolved';
    RETURN fUnresolvedReports;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `courierSalary` (`courier_id` CHAR(9)) RETURNS DECIMAL(10,2) DETERMINISTIC BEGIN
    DECLARE fee DECIMAL(10, 2);
    SELECT hourly_fee INTO fee FROM couriers WHERE BINARY user_id = BINARY courier_id;
    RETURN fee * 8; 
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `generateUniqueID` (`limitLength` INT) RETURNS VARCHAR(255) CHARSET utf8mb4 DETERMINISTIC BEGIN
    DECLARE characters VARCHAR(36);
    DECLARE uniqueID VARCHAR(255);
    DECLARE i INT;

    SET characters = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    SET uniqueID = '';
    SET i = 0;

    WHILE i < limitLength DO
        SET uniqueID = CONCAT(uniqueID, SUBSTRING(characters, FLOOR(1 + RAND() * 36), 1));
        SET i = i + 1;
    END WHILE;

    RETURN uniqueID;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `getDealerPrices` (`product_id_param` CHAR(9)) RETURNS DECIMAL(10,2) DETERMINISTIC BEGIN
    DECLARE p_dealer_price DECIMAL(10, 2);

    SELECT dealer_prices INTO p_dealer_price FROM products WHERE BINARY product_id = BINARY product_id_param;

    RETURN p_dealer_price;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `getRandomCourierUserId` () RETURNS CHAR(9) CHARSET utf8mb4 DETERMINISTIC BEGIN
    DECLARE courier_id CHAR(9);

    SELECT user_id INTO courier_id
    FROM users
    WHERE level_user = 'Courier'
    ORDER BY RAND()
    LIMIT 1;

    RETURN courier_id;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `monthlyTotal` (`month_param` INT) RETURNS DECIMAL(10,2) DETERMINISTIC BEGIN
    DECLARE profit DECIMAL(10, 2);

    SELECT COALESCE(SUM(total), 0.00) INTO profit FROM orders WHERE MONTH(order_date) = month_param;

    RETURN profit;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `totalMonthlySales` (`input_month` INT) RETURNS DECIMAL(18,2) DETERMINISTIC BEGIN
    DECLARE total_sales DECIMAL(18, 2);

    SELECT SUM(total) INTO total_sales
    FROM sales_report WHERE MONTH(order_date) = input_month;

    RETURN total_sales;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `totalProducts` () RETURNS INT DETERMINISTIC BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM products;

    RETURN total;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `totalSales` () RETURNS DECIMAL(18,2) DETERMINISTIC BEGIN
    DECLARE total_sales DECIMAL(18, 2);

    SELECT SUM(total) INTO total_sales
    FROM sales_report;

    RETURN total_sales;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `totalStocks` () RETURNS INT DETERMINISTIC BEGIN
    DECLARE totalStocks INT;
    SELECT SUM(stock) INTO totalStocks
    FROM products;

    RETURN totalStocks;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `all_orders_data`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `all_orders_data` (
`contact` char(13)
,`courier_id` char(9)
,`courier_name` varchar(255)
,`dealer_prices` decimal(10,0)
,`delivery_address` text
,`message` varchar(255)
,`order_date` timestamp
,`order_id` char(10)
,`photo` varchar(255)
,`product_id` char(9)
,`product_name` text
,`status` enum('Unconfirmed','Confirmed','Received')
,`struct` varchar(255)
,`total` decimal(10,2)
,`user_id` char(9)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `all_products`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `all_products` (
`category` varchar(255)
,`dealer_prices` decimal(10,0)
,`photo` varchar(255)
,`product_id` char(9)
,`product_name` text
,`stock` int
,`user_prices` decimal(10,0)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `all_product_data`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `all_product_data` (
`antivirus` varchar(255)
,`category` varchar(255)
,`category_id` char(2)
,`dealer_prices` decimal(10,0)
,`description` text
,`operating_system` varchar(255)
,`photo` varchar(255)
,`product_id` char(9)
,`product_name` text
,`sold_products` bigint
,`spec_audio` varchar(255)
,`spec_battery` varchar(255)
,`spec_camera` varchar(255)
,`spec_connectivity` varchar(255)
,`spec_dimension` varchar(255)
,`spec_display` varchar(255)
,`spec_extandable_ram` varchar(255)
,`spec_extandable_ssd` varchar(255)
,`spec_gpu` varchar(255)
,`spec_proc` varchar(255)
,`spec_ram` varchar(255)
,`spec_storage` varchar(255)
,`spec_weight` varchar(255)
,`stock` int
,`user_prices` decimal(10,0)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `categories`
--

CREATE TABLE `categories` (
  `category_id` char(2) COLLATE utf8mb4_general_ci NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `categories`
--

INSERT INTO `categories` (`category_id`, `category`) VALUES
('IP', 'IdeaPad'),
('LG', 'Legion'),
('LQ', 'LOQ'),
('TP', 'ThinkPad'),
('VT', 'TUF'),
('YG', 'YOGA');

--
-- Trigger `categories`
--
DELIMITER $$
CREATE TRIGGER `append_category` AFTER INSERT ON `categories` FOR EACH ROW BEGIN
	INSERT INTO log_category VALUES (NEW.category_id, NEW.category, 'CREATED', NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `pop_category` BEFORE DELETE ON `categories` FOR EACH ROW BEGIN
	INSERT INTO log_category VALUES (OLD.category_id, OLD.category, 'DELETED', NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `confirmed_order_delivery`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `confirmed_order_delivery` (
`delivery_address` text
,`email` varchar(255)
,`name` varchar(255)
,`order_date` timestamp
,`order_id` char(10)
,`product_name` text
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `couriers`
--

CREATE TABLE `couriers` (
  `user_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `hourly_fee` decimal(10,0) NOT NULL,
  `vehicle` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `couriers`
--

INSERT INTO `couriers` (`user_id`, `hourly_fee`, `vehicle`) VALUES
('HSAD032FA', 15000, 'Vario 155 2015'),
('KHDA102YI', 20000, 'Beat Regular 2021'),
('M4UR3N999', 99999, 'Beat Karbu 2009 dah mau meninggal'),
('4TTDVC54B', 12000, 'Beat Regular 2014');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `couriers_account`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `couriers_account` (
`created_at` timestamp
,`email` varchar(255)
,`hourly_fee` decimal(10,0)
,`name` varchar(255)
,`phone_number` varchar(14)
,`user_id` char(9)
,`vehicle` varchar(255)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `customers`
--

CREATE TABLE `customers` (
  `user_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `last_purchase` date DEFAULT NULL,
  `address` text COLLATE utf8mb4_general_ci NOT NULL,
  `second_contact` varchar(14) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `customers`
--

INSERT INTO `customers` (`user_id`, `last_purchase`, `address`, `second_contact`) VALUES
('RMW6F2U33', NULL, 'Jalan Dwikora Baru No 19', NULL),
('UJ23SYDHT', NULL, 'Jalan Binje Belok Kiri Kanan Sikit', NULL),
('CBMPZ3KG4', NULL, 'Jalan Neraka Sebelahnya', NULL),
('OK0VLQXX0', NULL, 'Jalan Dekat Gang Gajah Mada', NULL),
('2UDAYNYWA', NULL, 'Jalan ganteng', NULL),
('TGEEDVQNU', NULL, 'Jalan dwikora baru no 19', NULL);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `customers_account`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `customers_account` (
`address` text
,`created_at` timestamp
,`email` varchar(255)
,`last_purchase` date
,`name` varchar(255)
,`phone_number` varchar(14)
,`user_id` char(9)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `empty_stock`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `empty_stock` (
`product_id` char(9)
,`product_name` text
,`stock` int
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `log_account`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `log_account` (
`action` varchar(7)
,`name` varchar(255)
,`time` timestamp
,`user_id` char(9)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_category`
--

CREATE TABLE `log_category` (
  `category_id` char(2) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `action` enum('CREATED','UPDATED','DELETED','') COLLATE utf8mb4_general_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_category`
--

INSERT INTO `log_category` (`category_id`, `name`, `action`, `time`) VALUES
('IP', 'Ideapad', 'DELETED', '2023-11-25 00:43:19'),
('IP', 'IdeaPad', 'CREATED', '2023-11-25 00:43:35'),
('YG', 'YOGA', 'CREATED', '2023-11-26 15:35:59'),
('VT', 'TUF', 'CREATED', '2023-12-02 15:39:28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_couriers_account`
--

CREATE TABLE `log_couriers_account` (
  `user_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `action` enum('CREATED','UPDATED','DELETED','') COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_couriers_account`
--

INSERT INTO `log_couriers_account` (`user_id`, `name`, `time`, `action`) VALUES
('CIAMONR07', 'Ciamon Rollssss', '2023-11-26 01:17:40', 'CREATED'),
('CIAMONR07', 'Ciamon Rollssss', '2023-11-26 01:20:12', 'DELETED'),
('4M3714KTL', 'Amelia Johana Romaito Panjaitan', '2023-11-26 02:58:49', 'CREATED'),
('4M3714KTL', 'Amelia Johana Romaito Panjaitan', '2023-11-26 03:00:49', 'DELETED'),
('4M3714KTL', 'Amelia Johana Romaito Panjaitan', '2023-11-26 03:01:19', 'CREATED'),
('4M3714KTL', 'Amelia Johana Romaito Panjaitan', '2023-11-26 03:12:32', 'DELETED'),
('4M3714KTL', 'Amelia Johana Romaito Panjaitan', '2023-11-26 03:12:35', 'CREATED'),
('4M3714KTL', 'Amelia Johana Romaito Panjaitan', '2023-11-26 03:15:19', 'DELETED'),
('4M3714KTL', 'Amelia Johana Romaito Panjaitan', '2023-11-26 03:15:37', 'CREATED'),
('4M3714KTL', 'Amelia Johana Romaito Panjaitan', '2023-11-26 03:16:01', 'DELETED'),
('COURIER01', 'Ethanzera', '2023-11-27 16:08:51', 'CREATED'),
('COURIER01', 'Ethanzera', '2023-11-27 16:09:42', 'DELETED'),
('COURIER01', 'Ethanzera', '2023-11-27 16:11:41', 'CREATED'),
('COURIER01', 'Ethanzera', '2023-11-27 16:11:57', 'DELETED'),
('I13R41234', 'Ibra Rizqy Siregar', '2023-12-01 03:06:59', 'CREATED'),
('M4UR3N999', 'Maureen Lovynka Trunstiatica Zalukhu', '2023-12-01 03:06:59', 'CREATED'),
('I13R41234', 'Ibra Rizqy Siregar', '2023-12-01 03:09:36', 'DELETED'),
('4TTDVC54B', 'Said Muhammad Mazaya', '2023-12-01 08:59:56', 'CREATED');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_customers_account`
--

CREATE TABLE `log_customers_account` (
  `user_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `action` enum('CREATED','UPDATED','DELETED','') COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_customers_account`
--

INSERT INTO `log_customers_account` (`user_id`, `name`, `time`, `action`) VALUES
('UJ23SYDHT', 'Pelangi Sanrilla Sinurat', '2023-11-25 00:07:19', 'CREATED'),
('AIEUD7359', 'Thoriq Al Asyjari', '2023-11-25 00:10:09', 'CREATED'),
('EOS1H3EWT', 'Semkris', '2023-11-25 00:19:47', 'DELETED'),
('N6O5O1LFM', 'Khalil Ramzy Nasution', '2023-11-25 00:24:04', 'CREATED'),
('C14M0NR07', 'Camonroll', '2023-11-26 01:33:04', 'CREATED'),
('J4N1T4T0N', 'Janita Rakshanda Ingayla', '2023-11-26 02:02:38', 'CREATED'),
('YGVJJZKYG', 'Ufy Ananda Yatna', '2023-11-26 02:04:53', 'CREATED'),
('N6O5O1LFM', 'Khalil Ramzy Nasution', '2023-11-26 02:37:35', 'DELETED'),
('J4N1T4T0N', 'Janita Rakshanda Ingayla', '2023-11-26 02:38:21', 'DELETED'),
('4ZM1LUB15', 'M. Naufal Azmi Lubis', '2023-11-26 02:47:53', 'CREATED'),
('4ZM1LUB15', 'M. Naufal Azmi Lubis', '2023-11-26 02:48:18', 'DELETED'),
('YGVJJZKYG', 'Ufy Ananda Yatna', '2023-11-26 16:51:23', 'DELETED'),
('V74BJ87U8', 'Paskal Irvaldi Manik', '2023-11-26 18:55:26', 'CREATED'),
('C14M0NR07', 'Camonroll', '2023-11-27 05:16:27', 'DELETED'),
('PZR1J2U5F', 'Ibra Rizqy', '2023-11-28 05:56:28', 'CREATED'),
('OL21FLPAB', 'Ibra Rizqy', '2023-11-28 05:57:09', 'CREATED'),
('CBMPZ3KG4', 'Muhammad Raihan Abidllah Lubis', '2023-11-28 07:56:49', 'CREATED'),
('KW2CTTPNX', 'Ijat UMKM', '2023-12-01 01:42:57', 'DELETED'),
('V74BJ87U8', 'Paskal Irvaldi Manik', '2023-12-01 01:44:38', 'DELETED'),
('PZR1J2U5F', 'Ibra Rizqy', '2023-12-01 03:09:55', 'DELETED'),
('OL21FLPAB', 'Ibra Rizqy', '2023-12-01 03:09:59', 'DELETED'),
('7X81V981A', 'Amelia Johana Romaito Panjaitan', '2023-12-04 03:16:12', 'CREATED'),
('PNT9QGSUW', 'Oswin Sitompul', '2023-12-04 20:49:41', 'CREATED'),
('PNT9QGSUW', 'Oswin Sitompul', '2023-12-04 20:50:56', 'DELETED'),
('BVV30GKM0', 'Paskal Irvaldi Manik', '2023-12-04 20:52:29', 'CREATED'),
('BVV30GKM0', 'Paskal Irvaldi Manik', '2023-12-04 20:52:45', 'DELETED'),
('YZ71YBGIG', 'Lucas Hamonangan', '2023-12-04 20:53:54', 'CREATED'),
('YZ71YBGIG', 'Lucas Hamonangan', '2023-12-04 20:54:03', 'DELETED'),
('TXN1VGDUY', 'Halim Godfa Sinaga', '2023-12-04 20:54:27', 'CREATED'),
('TXN1VGDUY', 'Halim Godfa Sinaga', '2023-12-04 20:54:39', 'DELETED'),
('LFSIZ89DE', 'Halim Godfa Sinaga', '2023-12-04 20:55:14', 'CREATED'),
('OK0VLQXX0', 'Paskal Irvaldi Manik', '2023-12-04 20:55:40', 'CREATED'),
('7X81V981A', 'Amelia Johana Romaito Panjaitan', '2023-12-05 06:37:55', 'DELETED'),
('2UDAYNYWA', 'Ikhwan Prananta', '2023-12-06 02:11:16', 'CREATED'),
('LFSIZ89DE', 'Halim Godfa Sinaga', '2023-12-06 02:19:27', 'DELETED'),
('OVY7LQTMJ', 'Retep Grang Sitanggang', '2023-12-24 03:10:20', 'CREATED'),
('OVY7LQTMJ', 'Retep Grang Sitanggang', '2023-12-24 03:10:41', 'DELETED'),
('8TJ3RIUQ3', 'Retep Grang Sitanggang', '2023-12-24 04:23:36', 'CREATED'),
('8TJ3RIUQ3', 'Retep Grang Sitanggang', '2023-12-24 04:49:41', 'DELETED'),
('TGEEDVQNU', 'Retep Grang Sitanggang', '2023-12-24 07:49:55', 'CREATED');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_order_status`
--

CREATE TABLE `log_order_status` (
  `order_id` char(10) COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `actioner` enum('Seller','Courier','') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_order_status`
--

INSERT INTO `log_order_status` (`order_id`, `status`, `time`, `actioner`) VALUES
('SAUDGHA123', 'Updated By', '2023-11-25 14:30:09', 'Seller'),
('SAUDGHA123', 'Updated By', '2023-11-25 14:30:14', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-26 15:45:20', 'Seller'),
('C14M0NR077', 'Updated By', '2023-11-26 15:48:58', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-26 15:48:58', 'Courier'),
('AYSDG12345', 'Updated By', '2023-11-27 08:10:16', 'Seller'),
('C14M0NR077', 'Updated By', '2023-11-27 12:21:42', 'Courier'),
('AYSDG12345', 'Updated By', '2023-11-27 12:22:15', 'Seller'),
('C14M0NR077', 'Updated By', '2023-11-27 12:22:20', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 12:22:25', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 12:27:47', 'Seller'),
('C14M0NR077', 'Updated By', '2023-11-27 12:27:52', 'Seller'),
('C14M0NR077', 'Updated By', '2023-11-27 12:32:42', 'Courier'),
('AYSDG12345', 'Updated By', '2023-11-27 12:57:12', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 12:59:33', 'Seller'),
('C14M0NR077', 'Updated By', '2023-11-27 14:27:09', 'Seller'),
('C14M0NR077', 'Updated By', '2023-11-27 14:46:21', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 14:47:00', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 14:47:00', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:02', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:02', 'Courier'),
('AYSDG12345', 'Updated By', '2023-11-27 14:47:16', 'Seller'),
('C14M0NR077', 'Updated By', '2023-11-27 14:47:19', 'Seller'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:21', 'Seller'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:24', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:24', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:24', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:24', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:24', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:24', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:28', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:28', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:28', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:28', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:35', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:45', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:45', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:45', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-27 14:47:45', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:26:37', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:26:37', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:26:37', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:26:37', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:26:40', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:26:40', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:26:57', 'Seller'),
('OAUSDHA123', 'Updated By', '2023-11-27 15:27:01', 'Seller'),
('C14M0NR077', 'Updated By', '2023-11-27 15:27:04', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:27:04', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:27:04', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:27:04', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:27:04', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:27:04', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:27:07', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:27:07', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:27:07', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:27:07', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:32:40', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:32:40', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:32:40', 'Courier'),
('C14M0NR077', 'Updated By', '2023-11-27 15:32:40', 'Courier'),
('AYSDG12345', 'Updated By', '2023-11-27 15:32:41', 'Courier'),
('AYSDG12345', 'Updated By', '2023-11-27 15:32:41', 'Courier'),
('AYSDG12345', 'Updated By', '2023-11-27 15:32:41', 'Courier'),
('AYSDG12345', 'Updated By', '2023-11-27 15:32:41', 'Courier'),
('AYSDG12345', 'Updated By', '2023-11-27 15:32:42', 'Courier'),
('AYSDG12345', 'Updated By', '2023-11-27 15:32:42', 'Courier'),
('J0K0W1KRN1', 'Updated By', '2023-11-28 01:50:44', 'Seller'),
('OAUSDHA123', 'Updated By', '2023-11-28 05:53:03', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-28 05:53:03', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-28 05:53:03', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-28 05:53:03', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-28 05:53:03', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-28 05:53:03', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-28 05:53:04', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-28 05:53:04', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-28 05:53:04', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-11-28 05:53:04', 'Courier'),
('J0K0W1KRN1', 'Updated By', '2023-11-29 00:49:18', 'Courier'),
('J0K0W1KRN1', 'Updated By', '2023-11-29 00:49:18', 'Courier'),
('J0K0W1KRN1', 'Updated By', '2023-11-29 00:49:18', 'Courier'),
('J0K0W1KRN1', 'Updated By', '2023-11-29 00:49:18', 'Courier'),
('J0K0W1KRN1', 'Updated By', '2023-11-29 00:49:19', 'Courier'),
('J0K0W1KRN1', 'Updated By', '2023-11-29 00:49:19', 'Courier'),
('JDGUY12375', 'Updated By', '2023-12-02 04:59:08', 'Seller'),
('AYSDG12345', 'Updated By', '2023-12-02 04:59:17', 'Seller'),
('JDGUY12375', 'Updated By', '2023-12-02 04:59:52', 'Seller'),
('IUDHF01232', 'Updated By', '2023-12-02 05:01:48', 'Seller'),
('AYSDG12345', 'Updated By', '2023-12-02 07:32:50', 'Seller'),
('JDGUY12375', 'Updated By', '2023-12-02 07:33:08', 'Seller'),
('ADGAD07437', 'Updated By', '2023-12-02 07:33:16', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-12-02 07:33:24', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-12-02 07:33:39', 'Courier'),
('ADGAD07437', 'Updated By', '2023-12-02 07:33:50', 'Courier'),
('JDGUY12375', 'Updated By', '2023-12-02 07:33:55', 'Seller'),
('AAGHH07437', 'Updated By', '2023-12-02 18:45:17', 'Courier'),
('AAGHH07437', 'Updated By', '2023-12-02 18:45:39', 'Courier'),
('ADGAD07437', 'Updated By', '2023-12-02 18:45:41', 'Courier'),
('AGADUH313H', 'Updated By', '2023-12-02 18:45:44', 'Courier'),
('AOSUIST123', 'Updated By', '2023-12-02 18:45:45', 'Seller'),
('AOUDH78153', 'Updated By', '2023-12-02 18:45:47', 'Courier'),
('C14M0NR077', 'Updated By', '2023-12-02 18:45:49', 'Courier'),
('J0K0W1KRN1', 'Updated By', '2023-12-02 18:45:50', 'Courier'),
('JDGUY12375', 'Updated By', '2023-12-02 18:45:51', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 18:45:53', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-12-02 18:45:55', 'Courier'),
('SD831IAF45', 'Updated By', '2023-12-02 18:45:56', 'Courier'),
('AAGHH07437', 'Updated By', '2023-12-02 18:53:04', 'Courier'),
('ADGAD07437', 'Updated By', '2023-12-02 18:53:09', 'Courier'),
('AGADUH313H', 'Updated By', '2023-12-02 18:53:14', 'Courier'),
('AOSUIST123', 'Updated By', '2023-12-02 18:53:20', 'Seller'),
('AOUDH78153', 'Updated By', '2023-12-02 18:53:26', 'Courier'),
('C14M0NR077', 'Updated By', '2023-12-02 18:53:33', 'Courier'),
('J0K0W1KRN1', 'Updated By', '2023-12-02 18:53:38', 'Courier'),
('JDGUY12375', 'Updated By', '2023-12-02 18:53:44', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 18:53:50', 'Courier'),
('OAUSDHA123', 'Updated By', '2023-12-02 18:53:56', 'Courier'),
('SD831IAF45', 'Updated By', '2023-12-02 18:54:00', 'Courier'),
('AAGHH07437', 'Updated By', '2023-12-02 18:54:50', 'Courier'),
('AGADUH313H', 'Updated By', '2023-12-02 18:54:55', 'Courier'),
('C14M0NR077', 'Updated By', '2023-12-02 18:54:58', 'Courier'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 18:55:01', 'Courier'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:07:01', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:07:01', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:07:01', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:07:01', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:07:01', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:07:01', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:07:01', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:07:01', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:07:04', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:07:04', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:07:04', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:07:04', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:07:04', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:07:04', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:08:32', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:08:32', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:08:32', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:08:32', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:08:32', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:08:32', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-02 19:09:06', 'Courier'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:27', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:27', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:27', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:27', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:27', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:27', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:28', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:28', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:28', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:28', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:36', 'Courier'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:41', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:41', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:41', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:41', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:41', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:41:41', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-03 02:45:24', 'Courier'),
('AGADUH313H', 'Updated By', '2023-12-04 05:19:45', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-04 05:19:45', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-04 05:19:45', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-04 05:19:45', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-04 05:19:45', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-04 05:19:45', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-04 05:19:46', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-04 05:19:46', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-04 05:19:46', 'Seller'),
('AGADUH313H', 'Updated By', '2023-12-04 05:19:46', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-04 05:21:26', 'Seller'),
('AOSUIST123', 'Updated By', '2023-12-04 08:49:47', 'Seller'),
('LOPC1AM0NS', 'Updated By', '2023-12-04 17:12:48', 'Courier'),
('LOPC1AM0NS', 'Updated By', '2023-12-04 17:12:48', 'Courier'),
('LOPC1AM0NS', 'Updated By', '2023-12-04 17:12:48', 'Courier'),
('LOPC1AM0NS', 'Updated By', '2023-12-04 17:12:48', 'Courier'),
('LOPC1AM0NS', 'Updated By', '2023-12-04 17:12:48', 'Courier'),
('LOPC1AM0NS', 'Updated By', '2023-12-04 17:12:48', 'Courier'),
('LOPC1AM0NS', 'Updated By', '2023-12-04 17:12:48', 'Courier'),
('LOPC1AM0NS', 'Updated By', '2023-12-04 17:12:48', 'Courier'),
('LOPC1AM0NS', 'Updated By', '2023-12-04 17:12:49', 'Courier'),
('LOPC1AM0NS', 'Updated By', '2023-12-04 17:12:49', 'Courier'),
('LOPC1AM0NS', 'Updated By', '2023-12-04 17:12:49', 'Courier'),
('LOPC1AM0NS', 'Updated By', '2023-12-04 17:12:49', 'Courier'),
('LOPC1AM0NS', 'Updated By', '2023-12-04 17:12:49', 'Courier'),
('LOPC1AM0NS', 'Updated By', '2023-12-04 17:12:49', 'Courier'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:10', 'Seller'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:10', 'Seller'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:10', 'Seller'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:10', 'Seller'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:10', 'Seller'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:10', 'Seller'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:11', 'Seller'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:11', 'Seller'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:11', 'Seller'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:11', 'Seller'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:39', 'Courier'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:39', 'Courier'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:39', 'Courier'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:39', 'Courier'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:39', 'Courier'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:39', 'Courier'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:39', 'Courier'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:39', 'Courier'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:40', 'Courier'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:40', 'Courier'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:40', 'Courier'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:40', 'Courier'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:40', 'Courier'),
('DUG5L18VDR', 'Updated By', '2023-12-04 17:14:40', 'Courier'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:32:21', 'Seller'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:32:21', 'Seller'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:32:21', 'Seller'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:32:21', 'Seller'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:32:21', 'Seller'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:32:21', 'Seller'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:32:22', 'Seller'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:32:22', 'Seller'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:32:22', 'Seller'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:32:22', 'Seller'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:32:22', 'Seller'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:32:22', 'Seller'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:32:22', 'Seller'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:32:22', 'Seller'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:35:19', 'Courier'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:35:19', 'Courier'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:35:19', 'Courier'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:35:19', 'Courier'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:35:19', 'Courier'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:35:19', 'Courier'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:35:19', 'Courier'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:35:19', 'Courier'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:35:20', 'Courier'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:35:20', 'Courier'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:35:20', 'Courier'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:35:20', 'Courier'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:35:20', 'Courier'),
('54JJ4ZSN7S', 'Updated By', '2023-12-05 06:35:20', 'Courier'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:15:37', 'Seller'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:15:37', 'Seller'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:15:37', 'Seller'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:15:37', 'Seller'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:15:37', 'Seller'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:15:37', 'Seller'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:15:37', 'Seller'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:15:37', 'Seller'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:15:38', 'Seller'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:15:38', 'Seller'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:15:38', 'Seller'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:15:38', 'Seller'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:15:38', 'Seller'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:15:38', 'Seller'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:17:34', 'Courier'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:17:34', 'Courier'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:17:34', 'Courier'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:17:34', 'Courier'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:17:34', 'Courier'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:17:34', 'Courier'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:17:34', 'Courier'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:17:34', 'Courier'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:17:36', 'Courier'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:17:36', 'Courier'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:17:36', 'Courier'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:17:36', 'Courier'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:17:36', 'Courier'),
('JU015U35Q6', 'Updated By', '2023-12-06 02:17:36', 'Courier');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_product`
--

CREATE TABLE `log_product` (
  `product_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `action` enum('CREATED','DELETED','UPDATED','') COLLATE utf8mb4_general_ci NOT NULL,
  `time` timestamp NULL DEFAULT NULL,
  `price` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_product`
--

INSERT INTO `log_product` (`product_id`, `action`, `time`, `price`) VALUES
('LEGION001', 'CREATED', '2023-11-25 05:17:18', 12000000),
('IDEAPAD01', 'CREATED', '2023-11-25 05:17:18', 7000000),
('LEGION001', 'UPDATED', '2023-11-25 05:17:35', 12000000),
('IDEAPAD01', 'UPDATED', '2023-11-26 01:31:54', 7000000),
('TP123KTLP', 'CREATED', '2023-11-26 12:43:30', 7000000),
('TP123KTLP', 'UPDATED', '2023-11-26 12:43:49', 7000000),
('TP123KTLP', 'DELETED', '2023-11-26 13:33:52', 7000000),
('IDEAPAD01', 'UPDATED', '2023-11-26 15:33:16', 8000000),
('LEGION001', 'UPDATED', '2023-11-27 05:54:26', 12000000),
('IDEAPAD01', 'UPDATED', '2023-11-27 06:00:49', 8000000),
('LEGION001', 'UPDATED', '2023-11-28 01:43:06', 12000000),
('LEGION001', 'UPDATED', '2023-11-28 01:43:06', 12000000),
('IDEAPAD01', 'UPDATED', '2023-11-28 01:45:25', 8000000),
('LEGION001', 'UPDATED', '2023-11-28 01:45:25', 12000000),
('IDEAPAD01', 'UPDATED', '2023-11-28 01:47:28', 8000000),
('LEGION001', 'UPDATED', '2023-11-28 01:47:28', 12000000),
('IDEAPAD01', 'UPDATED', '2023-11-28 01:49:01', 8000000),
('LEGION001', 'UPDATED', '2023-11-28 01:50:29', 12000000),
('LEGION001', 'UPDATED', '2023-11-28 01:50:29', 12000000),
('IDEAPAD01', 'UPDATED', '2023-12-02 05:01:39', 8000000),
('TESTING02', 'CREATED', '2023-12-02 14:52:40', 12000000),
('TESTING03', 'CREATED', '2023-12-02 14:52:40', 7000000),
('TESTING03', 'UPDATED', '2023-12-02 14:52:54', 7000000),
('TESTING03', 'UPDATED', '2023-12-02 14:53:18', 7000000),
('TESTING02', 'DELETED', '2023-12-02 14:56:54', 12000000),
('TESTING03', 'UPDATED', '2023-12-02 15:09:17', 7000000),
('TESTING03', 'UPDATED', '2023-12-02 15:22:48', 8000000),
('TESTING03', 'UPDATED', '2023-12-02 15:22:48', 8000000),
('TESTING03', 'UPDATED', '2023-12-02 15:23:55', 1000000),
('TESTING03', 'UPDATED', '2023-12-02 15:23:55', 1000000),
('TESTING03', 'UPDATED', '2023-12-02 15:23:57', 8000000),
('TESTING03', 'UPDATED', '2023-12-02 15:23:57', 8000000),
('TESTING03', 'UPDATED', '2023-12-02 15:24:31', 6000000),
('TESTING03', 'UPDATED', '2023-12-02 15:24:31', 6000000),
('TESTING03', 'UPDATED', '2023-12-02 15:26:37', 10000000),
('TESTING03', 'UPDATED', '2023-12-02 15:26:37', 10000000),
('TESTING03', 'UPDATED', '2023-12-02 15:28:40', 10000000),
('TESTING03', 'UPDATED', '2023-12-02 15:28:40', 10000000),
('TESTING03', 'UPDATED', '2023-12-02 15:28:51', 7000000),
('TESTING03', 'UPDATED', '2023-12-02 15:28:51', 7000000),
('TESTING03', 'UPDATED', '2023-12-02 15:29:01', 8000000),
('TESTING03', 'UPDATED', '2023-12-02 15:29:01', 8000000),
('TESTING03', 'DELETED', '2023-12-02 15:29:10', 8000000),
('IDEAPAD01', 'UPDATED', '2023-12-03 01:17:03', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-03 01:33:38', 7000000),
('LEGION001', 'UPDATED', '2023-12-03 01:33:52', 12000000),
('LEGION001', 'UPDATED', '2023-12-03 02:04:22', 12000000),
('LEGION001', 'UPDATED', '2023-12-03 02:06:11', 12000000),
('LEGION001', 'UPDATED', '2023-12-03 02:06:54', 12000000),
('LEGION001', 'UPDATED', '2023-12-03 02:10:03', 12000000),
('LEGION001', 'UPDATED', '2023-12-03 02:10:21', 12000000),
('IDEAPAD01', 'UPDATED', '2023-12-03 02:10:40', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-03 02:11:32', 7000000),
('LEGION001', 'UPDATED', '2023-12-03 02:11:41', 12000000),
('LEGION001', 'UPDATED', '2023-12-03 02:27:58', 12000000),
('LEGION001', 'UPDATED', '2023-12-03 02:28:28', 12000000),
('LEGION001', 'UPDATED', '2023-12-03 02:28:38', 12000000),
('LEGION001', 'UPDATED', '2023-12-03 02:28:40', 12000000),
('LEGION001', 'UPDATED', '2023-12-03 02:29:07', 12000000),
('LEGION001', 'UPDATED', '2023-12-03 02:30:03', 12000000),
('LEGION001', 'UPDATED', '2023-12-03 02:30:05', 12000000),
('LEGION001', 'UPDATED', '2023-12-03 02:30:23', 12000000),
('IDEAPAD01', 'UPDATED', '2023-12-03 02:31:53', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-03 02:38:34', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-03 02:38:34', 7000000),
('LEGION001', 'UPDATED', '2023-12-03 03:25:10', 12000000),
('7FG3NSQF3', 'CREATED', '2023-12-03 03:52:42', 8000000),
('X26FGJ701', 'CREATED', '2023-12-03 03:54:50', 8000000),
('7FG3NSQF3', 'DELETED', '2023-12-03 03:55:11', 8000000),
('LEGION001', 'UPDATED', '2023-12-04 07:05:31', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 07:05:31', 12000000),
('AIVOWFC8Y', 'CREATED', '2023-12-04 07:50:15', 14000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 07:53:07', 7000000),
('LEGION001', 'UPDATED', '2023-12-04 07:53:10', 12000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 07:56:19', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 07:57:46', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 07:58:18', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 07:58:34', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 07:58:45', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 07:58:51', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 07:59:01', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 07:59:11', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 07:59:22', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 07:59:31', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 07:59:42', 7000000),
('LEGION001', 'UPDATED', '2023-12-04 07:59:47', 12000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 08:00:19', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 08:00:26', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 08:00:28', 7000000),
('LEGION001', 'UPDATED', '2023-12-04 08:00:32', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 08:00:34', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 08:00:53', 12000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 08:00:57', 7000000),
('IDEAPAD01', 'UPDATED', '2023-12-04 08:01:11', 7000000),
('LEGION001', 'UPDATED', '2023-12-04 08:03:19', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 08:03:40', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 08:04:27', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 08:05:09', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 08:05:25', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 08:05:34', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 08:05:40', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 08:05:51', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 08:06:10', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 08:06:27', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 08:07:21', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 08:07:35', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 08:07:44', 12000000),
('LEGION001', 'UPDATED', '2023-12-04 08:08:09', 12000000),
('FIJ75X4PT', 'CREATED', '2023-12-04 08:18:21', 17000000),
('Q8UN3VN67', 'CREATED', '2023-12-04 08:23:38', 13000000),
('Q8UN3VN67', 'UPDATED', '2023-12-04 08:25:43', 13000000),
('665ZOHHWN', 'CREATED', '2023-12-04 08:30:28', 19000000),
('TLQPDOADQ', 'CREATED', '2023-12-04 08:35:14', 11000000),
('G7L83EQRL', 'CREATED', '2023-12-04 08:40:04', 16000000),
('4KKEK7HDZ', 'CREATED', '2023-12-04 08:47:33', 18000000),
('665ZOHHWN', 'UPDATED', '2023-12-04 08:48:44', 19000000),
('665ZOHHWN', 'UPDATED', '2023-12-04 08:48:44', 19000000),
('TLQPDOADQ', 'UPDATED', '2023-12-04 17:01:39', 11000000),
('4KKEK7HDZ', 'UPDATED', '2023-12-04 17:03:36', 18000000),
('4KKEK7HDZ', 'UPDATED', '2023-12-04 18:36:43', 18000000),
('AIVOWFC8Y', 'UPDATED', '2023-12-04 18:43:14', 14000000),
('G7L83EQRL', 'UPDATED', '2023-12-05 06:29:44', 16000000),
('665ZOHHWN', 'UPDATED', '2023-12-05 06:33:00', 19000000),
('665ZOHHWN', 'UPDATED', '2023-12-05 06:33:00', 19000000),
('665ZOHHWN', 'UPDATED', '2023-12-05 06:33:15', 19000000),
('665ZOHHWN', 'UPDATED', '2023-12-05 06:33:15', 19000000),
('665ZOHHWN', 'UPDATED', '2023-12-05 06:33:36', 19000000),
('665ZOHHWN', 'UPDATED', '2023-12-05 06:33:36', 19000000),
('4KKEK7HDZ', 'UPDATED', '2023-12-05 08:01:50', 18000000),
('TLQPDOADQ', 'UPDATED', '2023-12-06 02:12:46', 11000000),
('665ZOHHWN', 'UPDATED', '2023-12-06 02:14:41', 19000000),
('665ZOHHWN', 'UPDATED', '2023-12-06 02:14:41', 19000000);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `log_product_v`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `log_product_v` (
`action` enum('CREATED','DELETED','UPDATED','')
,`price` decimal(10,0)
,`product_id` char(9)
,`product_name` text
,`time` timestamp
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_purchase`
--

CREATE TABLE `log_purchase` (
  `order_id` char(10) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `product_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `total` decimal(10,0) DEFAULT NULL,
  `time` datetime NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_purchase`
--

INSERT INTO `log_purchase` (`order_id`, `user_id`, `product_id`, `total`, `time`, `action`) VALUES
('AOSUIDH123', 'RMW6F2U33', 'IDEAPAD01', 7000000, '2023-11-25 19:44:12', 'PURCHASED'),
('AOSUIDH123', 'RMW6F2U33', 'IDEAPAD01', NULL, '2023-11-25 20:17:02', 'DELETED'),
('SAUDGHA123', 'RMW6F2U33', 'LEGION001', 12000000, '2023-11-25 21:30:00', 'PURCHASED'),
('C14M0NR077', 'UJ23SYDHT', 'IDEAPAD01', 7000000, '2023-11-26 08:31:54', 'PURCHASED'),
('SAUDGHA123', 'RMW6F2U33', 'LEGION001', NULL, '2023-11-26 21:47:43', 'DELETED'),
('AYSDG12345', 'V74BJ87U8', 'LEGION001', 12000000, '2023-11-27 12:54:26', 'PURCHASED'),
('OAUSDHA123', 'V74BJ87U8', 'IDEAPAD01', 8000000, '2023-11-27 13:00:49', 'PURCHASED'),
('SD831IAF45', 'RMW6F2U33', 'LEGION001', 12000000, '2023-11-28 08:43:06', 'PURCHASED'),
('ADGAD07437', 'V74BJ87U8', 'LEGION001', 12000000, '2023-11-28 08:43:06', 'PURCHASED'),
('AOUDH78153', 'UJ23SYDHT', 'IDEAPAD01', 8000000, '2023-11-28 08:45:25', 'PURCHASED'),
('AAGHH07437', 'UJ23SYDHT', 'LEGION001', 12000000, '2023-11-28 08:45:25', 'PURCHASED'),
('JDGUY12375', 'KW2CTTPNX', 'IDEAPAD01', 8000000, '2023-11-28 08:47:28', 'PURCHASED'),
('AGADUH313H', 'RMW6F2U33', 'LEGION001', 12000000, '2023-11-28 08:47:28', 'PURCHASED'),
('LOPC1AM0NS', 'RMW6F2U33', 'IDEAPAD01', 8000000, '2023-11-28 08:49:01', 'PURCHASED'),
('AOSUIST123', 'RMW6F2U33', 'LEGION001', 12000000, '2023-11-28 08:50:29', 'PURCHASED'),
('J0K0W1KRN1', 'UJ23SYDHT', 'LEGION001', 12000000, '2023-11-28 08:50:29', 'PURCHASED'),
('IUDHF01232', 'CBMPZ3KG4', 'IDEAPAD01', 8000000, '2023-12-02 12:01:39', 'PURCHASED'),
('IUDHF01232', 'CBMPZ3KG4', 'IDEAPAD01', NULL, '2023-12-02 14:32:31', 'DELETED'),
('AYSDG12345', 'CHRISTY06', 'LEGION001', NULL, '2023-12-02 14:32:52', 'DELETED'),
('AAGHH07437', 'UJ23SYDHT', 'LEGION001', NULL, '2023-12-03 02:08:36', 'DELETED'),
('REGXY9SI6L', 'TH0R10912', 'IDEAPAD01', 7000000, '2023-12-03 08:33:38', 'PURCHASED'),
('UULHMA29Y9', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 08:33:52', 'PURCHASED'),
('3TNYIXFTNO', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 09:04:22', 'PURCHASED'),
('9U69369FVP', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 09:06:11', 'PURCHASED'),
('0AWQ6EDENK', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 09:06:54', 'PURCHASED'),
('BKRKP1EP1C', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 09:10:03', 'PURCHASED'),
('S0W2BAPCKK', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 09:10:21', 'PURCHASED'),
('S0W2BAPCKK', 'TH0R10912', 'LEGION001', NULL, '2023-12-03 09:10:32', 'DELETED'),
('7LUQOXUK5R', 'TH0R10912', 'IDEAPAD01', 7000000, '2023-12-03 09:10:40', 'PURCHASED'),
('U69AHYQF09', 'TH0R10912', 'IDEAPAD01', 7000000, '2023-12-03 09:11:32', 'PURCHASED'),
('FAH237D6PN', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 09:11:41', 'PURCHASED'),
('FAH237D6PN', 'TH0R10912', 'LEGION001', NULL, '2023-12-03 09:12:05', 'DELETED'),
('U69AHYQF09', 'TH0R10912', 'IDEAPAD01', NULL, '2023-12-03 09:12:05', 'DELETED'),
('7LUQOXUK5R', 'TH0R10912', 'IDEAPAD01', NULL, '2023-12-03 09:12:05', 'DELETED'),
('BKRKP1EP1C', 'TH0R10912', 'LEGION001', NULL, '2023-12-03 09:12:05', 'DELETED'),
('0AWQ6EDENK', 'TH0R10912', 'LEGION001', NULL, '2023-12-03 09:12:05', 'DELETED'),
('9U69369FVP', 'TH0R10912', 'LEGION001', NULL, '2023-12-03 09:12:05', 'DELETED'),
('3TNYIXFTNO', 'TH0R10912', 'LEGION001', NULL, '2023-12-03 09:12:05', 'DELETED'),
('UULHMA29Y9', 'TH0R10912', 'LEGION001', NULL, '2023-12-03 09:12:05', 'DELETED'),
('W8OL07SAQJ', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 09:27:58', 'PURCHASED'),
('DNLWHDW5X0', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 09:28:28', 'PURCHASED'),
('KF2E65JXTE', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 09:28:38', 'PURCHASED'),
('8FO9UHZFHV', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 09:28:40', 'PURCHASED'),
('33DSECI0ZP', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 09:29:07', 'PURCHASED'),
('8GHLWX0W83', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 09:30:03', 'PURCHASED'),
('PSY0WAGO6X', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 09:30:05', 'PURCHASED'),
('TF301A0FEV', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 09:30:23', 'PURCHASED'),
('YKCKZL7KH0', 'TH0R10912', 'IDEAPAD01', 7000000, '2023-12-03 09:31:53', 'PURCHASED'),
('YKCKZL7KH0', 'TH0R10912', 'IDEAPAD01', NULL, '2023-12-03 09:37:16', 'DELETED'),
('TF301A0FEV', 'TH0R10912', 'LEGION001', NULL, '2023-12-03 09:37:16', 'DELETED'),
('PSY0WAGO6X', 'TH0R10912', 'LEGION001', NULL, '2023-12-03 09:37:16', 'DELETED'),
('8GHLWX0W83', 'TH0R10912', 'LEGION001', NULL, '2023-12-03 09:37:16', 'DELETED'),
('33DSECI0ZP', 'TH0R10912', 'LEGION001', NULL, '2023-12-03 09:37:16', 'DELETED'),
('8FO9UHZFHV', 'TH0R10912', 'LEGION001', NULL, '2023-12-03 09:37:16', 'DELETED'),
('KF2E65JXTE', 'TH0R10912', 'LEGION001', NULL, '2023-12-03 09:37:16', 'DELETED'),
('DNLWHDW5X0', 'TH0R10912', 'LEGION001', NULL, '2023-12-03 09:37:16', 'DELETED'),
('W8OL07SAQJ', 'TH0R10912', 'LEGION001', NULL, '2023-12-03 09:37:16', 'DELETED'),
('REGXY9SI6L', 'TH0R10912', 'IDEAPAD01', NULL, '2023-12-03 09:37:16', 'DELETED'),
('W6J0NAG879', 'TH0R10912', 'LEGION001', 12000000, '2023-12-03 10:25:10', 'PURCHASED'),
('54JJ4ZSN7S', 'RMW6F2U33', 'TLQPDOADQ', 11000000, '2023-12-05 00:01:39', 'PURCHASED'),
('DUG5L18VDR', 'RMW6F2U33', '4KKEK7HDZ', 18000000, '2023-12-05 00:03:36', 'PURCHASED'),
('W6J0NAG879', 'TH0R10912', 'LEGION001', NULL, '2023-12-05 00:04:27', 'DELETED'),
('ARKV4I6V8O', 'UJ23SYDHT', '4KKEK7HDZ', 18000000, '2023-12-05 01:36:43', 'PURCHASED'),
('NNA60PC1PP', 'RMW6F2U33', 'AIVOWFC8Y', 14000000, '2023-12-05 01:43:14', 'PURCHASED'),
('YA79HT2N5X', 'RMW6F2U33', 'G7L83EQRL', 16000000, '2023-12-05 13:29:44', 'PURCHASED'),
('YA79HT2N5X', 'RMW6F2U33', 'G7L83EQRL', NULL, '2023-12-05 13:32:13', 'DELETED'),
('HUJGJ7C2UY', 'RMW6F2U33', '4KKEK7HDZ', 18000000, '2023-12-05 15:01:50', 'PURCHASED'),
('HUJGJ7C2UY', 'RMW6F2U33', '4KKEK7HDZ', NULL, '2023-12-05 15:07:45', 'DELETED'),
('JU015U35Q6', '2UDAYNYWA', 'TLQPDOADQ', 11000000, '2023-12-06 09:12:46', 'PURCHASED'),
('ARKV4I6V8O', 'UJ23SYDHT', '4KKEK7HDZ', NULL, '2023-12-06 09:15:53', 'DELETED');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `log_purchase_v`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `log_purchase_v` (
`action` varchar(255)
,`name` varchar(255)
,`order_id` char(10)
,`product_name` text
,`time` datetime
,`total` decimal(10,0)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_sales_account`
--

CREATE TABLE `log_sales_account` (
  `user_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `action` enum('CREATED','UPDATED','DELETED','') COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_sales_account`
--

INSERT INTO `log_sales_account` (`user_id`, `name`, `time`, `action`) VALUES
('AIEUD7359', 'Thoriq Al Asyjari', '2023-11-25 00:10:09', 'CREATED'),
('AIEUD7359', 'Thoriq Al Asyjari', '2023-11-25 00:57:34', 'DELETED'),
('4ZM1LUB15', 'M. Naufal Azmi Lubis', '2023-11-26 02:49:46', 'CREATED'),
('4ZM1LUB15', 'M. Naufal Azmi Lubis', '2023-11-26 02:50:20', 'DELETED'),
('4ZM1LUB15', 'M. Naufal Azmi Lubis', '2023-11-26 02:50:46', 'CREATED'),
('4ZM1LUB15', 'M. Naufal Azmi Lubis', '2023-11-26 02:53:31', 'DELETED'),
('TH0R10912', 'Muhammad Thoriq Al Asy-Jari', '2023-12-01 02:54:26', 'CREATED'),
('R4F331E23', 'Muhammad Rafi Devari Hasibuan', '2023-12-01 02:54:26', 'CREATED'),
('R4F331E23', 'Muhammad Rafi Devari Hasibuan', '2023-12-01 02:57:34', 'DELETED'),
('HLD6HPP6Q', 'Fildza Rasyika', '2023-12-01 05:43:14', 'CREATED'),
('480HLCXNZ', 'Fildza Rasyika', '2023-12-01 05:43:57', 'CREATED'),
('VZ0TVL8FA', 'Fildza Rasyika', '2023-12-01 05:47:38', 'CREATED'),
('X7LD3XYMX', 'Fildza Rasyika', '2023-12-01 05:48:08', 'CREATED'),
('7EGXNA9LY', 'Fildza Rasyika', '2023-12-01 05:49:04', 'CREATED'),
('HLD6HPP6Q', 'Fildza Rasyika', '2023-12-01 05:50:02', 'DELETED'),
('480HLCXNZ', 'Fildza Rasyika', '2023-12-01 05:50:07', 'DELETED'),
('VZ0TVL8FA', 'Fildza Rasyika', '2023-12-01 05:50:16', 'DELETED'),
('X7LD3XYMX', 'Fildza Rasyika', '2023-12-01 05:50:21', 'DELETED'),
('7EGXNA9LY', 'Fildza Rasyika', '2023-12-01 05:50:28', 'DELETED');

-- --------------------------------------------------------

--
-- Struktur dari tabel `orders`
--

CREATE TABLE `orders` (
  `order_id` char(10) COLLATE utf8mb4_general_ci NOT NULL,
  `product_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` char(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `delivery_address` text COLLATE utf8mb4_general_ci NOT NULL,
  `contact` char(13) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `order_date` timestamp NOT NULL,
  `courier_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('Unconfirmed','Confirmed','Received') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `struct` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `orders`
--

INSERT INTO `orders` (`order_id`, `product_id`, `user_id`, `total`, `delivery_address`, `contact`, `order_date`, `courier_id`, `status`, `message`, `struct`) VALUES
('54JJ4ZSN7S', 'TLQPDOADQ', 'RMW6F2U33', 11000000.00, 'Jalan Dwikora Baru No 19', '081298764697', '2023-12-04 17:01:39', 'M4UR3N999', 'Received', NULL, '2023-12-04-656e05f3ab27a.jpg'),
('ADGAD07437', 'LEGION001', 'CBMPZ3KG4', 10000000.00, 'Jalan Gajah Mada dekat Rakasih', NULL, '2023-11-02 18:45:41', 'KHDA102YI', 'Received', NULL, 'testing.jpg'),
('AGADUH313H', 'LEGION001', 'RMW6F2U33', 10000000.00, 'Komplek Marelan Nippon Permai, No 18C', NULL, '2023-11-02 18:45:44', 'KHDA102YI', 'Confirmed', 'Muhammad Thoriq Al Asy-Jari has confirmed your orders!', 'testing.jpg'),
('AOSUIST123', 'LEGION001', 'RMW6F2U33', 10000000.00, 'Jalan Rumah Grant No.123', NULL, '2023-11-02 18:45:45', 'KHDA102YI', 'Confirmed', NULL, 'testing.jpg'),
('AOUDH78153', 'IDEAPAD01', 'UJ23SYDHT', 7000000.00, 'Jalan Binje dekat KAI', NULL, '2023-09-02 18:45:47', 'KHDA102YI', 'Received', NULL, 'testing.jpg'),
('C14M0NR077', 'IDEAPAD01', 'UJ23SYDHT', 7000000.00, 'Jalan Jauh Banget Dekat Tokyo', '+821579471', '2023-09-02 18:45:49', 'KHDA102YI', 'Unconfirmed', NULL, 'testing.jpg'),
('DUG5L18VDR', '4KKEK7HDZ', 'RMW6F2U33', 18000000.00, 'Jalan Dwikora Baru No 19', '081298764697', '2023-12-04 17:03:36', 'HSAD032FA', 'Received', NULL, '2023-12-04-656e0668b4b40.jpg'),
('J0K0W1KRN1', 'LEGION001', 'UJ23SYDHT', 10000000.00, 'Jalan Binjai Dekat SMAN 1', NULL, '2023-08-02 18:45:50', 'KHDA102YI', 'Received', NULL, 'testing.jpg'),
('JDGUY12375', 'IDEAPAD01', 'RMW6F2U33', 7000000.00, 'Jalan Pancing Sebelah Rumah Dira', NULL, '2023-07-02 18:45:51', 'KHDA102YI', 'Confirmed', NULL, 'testing.jpg'),
('JU015U35Q6', 'TLQPDOADQ', '2UDAYNYWA', 11000000.00, 'Jalan ganteng', '092138912783', '2023-12-06 02:12:46', 'KHDA102YI', 'Received', NULL, '2023-12-06-656fd89e9d54f.jpg'),
('LOPC1AM0NS', 'IDEAPAD01', 'RMW6F2U33', 7000000.00, 'Jalan Cinta Diantara Kita No.21', NULL, '2023-06-02 18:45:53', 'KHDA102YI', 'Received', NULL, 'testing.jpg'),
('NNA60PC1PP', 'AIVOWFC8Y', 'RMW6F2U33', 14000000.00, 'Jalan Dwikora Baru No 19', '081298764697', '2023-12-04 18:43:14', 'HSAD032FA', 'Unconfirmed', 'Please send in with a bunch of accessories please uwu', '2023-12-04-656e1dc2ce963.png'),
('OAUSDHA123', 'IDEAPAD01', 'UJ23SYDHT', 7000000.00, 'Jalan wow keren banget', NULL, '2023-06-02 18:45:55', 'KHDA102YI', 'Received', NULL, 'testing.jpg'),
('SD831IAF45', 'LEGION001', 'RMW6F2U33', 10000000.00, 'Jalan jalan ke Tamasya', NULL, '2023-11-02 18:45:56', 'KHDA102YI', 'Received', NULL, 'testing.jpg');

--
-- Trigger `orders`
--
DELIMITER $$
CREATE TRIGGER `auto_check_stock` BEFORE INSERT ON `orders` FOR EACH ROW BEGIN
	DECLARE current_stock INT;

    SELECT stock INTO current_stock FROM products WHERE product_id = NEW.product_id;

	IF current_stock <= 0 THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Stocks are empty!';
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `auto_update_stock` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
    DECLARE before_stock INT;
    DECLARE after_stock INT;

    SELECT stock INTO before_stock FROM products WHERE product_id = NEW.product_id;

    SET after_stock = before_stock - 1;

    UPDATE products SET stock = after_stock WHERE product_id = NEW.product_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cust_purchase` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
	DECLARE total DECIMAL(10, 2);
	DECLARE name VARCHAR(255);
	DECLARE product_name VARCHAR(255);

	SELECT name INTO name FROM users WHERE NEW.user_id = user_id;
	SELECT dealer_prices, product_name INTO total, product_name FROM products WHERE NEW.product_id = product_id;


	INSERT INTO log_purchase VALUES(NEW.order_id, NEW.user_id, NEW.product_id, total, NOW(), 'PURCHASED');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delete_purchase` BEFORE DELETE ON `orders` FOR EACH ROW BEGIN
	DECLARE total DECIMAL(10, 2);

	SELECT dealer_prices INTO total FROM products WHERE OLD.product_id = product_id;

	INSERT INTO log_purchase VALUES(OLD.order_id, OLD.user_id, OLD.product_id, NULL, NOW(), 'DELETED');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_purchase_status` BEFORE UPDATE ON `orders` FOR EACH ROW BEGIN
	DECLARE actioner VARCHAR(255);
	
	IF NEW.status = 'Confirmed' THEN
		SET actioner = 'Seller';
	ELSE
		SET actioner = 'Courier';
	END IF;

	INSERT INTO log_order_status VALUES(NEW.order_id, 'Updated By', NOW(), actioner);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `products`
--

CREATE TABLE `products` (
  `product_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `product_name` text COLLATE utf8mb4_general_ci NOT NULL,
  `stock` int DEFAULT NULL,
  `category_id` char(2) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_prices` decimal(10,0) NOT NULL,
  `dealer_prices` decimal(10,0) NOT NULL,
  `spec_display` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `spec_ram` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `spec_proc` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `spec_gpu` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `spec_storage` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `spec_audio` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `spec_battery` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `spec_weight` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `spec_connectivity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `spec_camera` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `spec_extandable_ram` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `spec_extandable_ssd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `spec_dimension` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci NOT NULL,
  `operating_system` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `antivirus` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `stock`, `category_id`, `photo`, `user_prices`, `dealer_prices`, `spec_display`, `spec_ram`, `spec_proc`, `spec_gpu`, `spec_storage`, `spec_audio`, `spec_battery`, `spec_weight`, `spec_connectivity`, `spec_camera`, `spec_extandable_ram`, `spec_extandable_ssd`, `spec_dimension`, `description`, `operating_system`, `antivirus`) VALUES
('4KKEK7HDZ', 'YOGA DUET 7I (13 inch, GEN 5)', 0, 'YG', '2023-12-04-656d9225785c1.png', 16000000, 18000000, '13 inch 2K (2160 x 1350), IPS, 100% sRGB Lenovo E-Color Pen dan Lenovo Digital Pen', '16GB DDR4-2666MHz', 'Up to 10th Gen Intel® Core™ i7-10510U processor', 'Intel®Grafis UHD', '512GB SSD NVMe', '2 x Dolby Audio™ Speakers Smart amp™ speakers', 'Up to 10,8 jam (MobileMark 2014)', '0,8Kg / 1,76lbs', 'WiFi 6 (802.11 ax 2x2)', '1MP HD 720p', '-', '-', '297,4mm x 205,5mm x 9,19mm / 11,7 inch x 8,1 inch x 0,4 inch', 'YOGA DUET 7I is the one that brings out your best', 'Windows 11', 'McAvee'),
('665ZOHHWN', 'IDEAPAD FLEX 5 (14 inch, GEN 8)', 20, 'IP', '2023-12-04-656d8e24cc833.png', 17000000, 19000000, '14 inch 2.2K (2240 x 1400) touch, IPS, 16 10, 300 nits, 100% sRGB, TUV low blue light certification', 'Up to 16GB LPDDR4x', 'Up to AMD Ryzen™ 7 7730U processor', 'AMD Radeon™', 'Up to 1TB SSD M.2 PCIe', 'Dolby Audio™', 'For systems with 2.2K display ', 'Starting at 1.55kg / 3.42lbs', 'WLAN  WiFi 6 Up to Bluetooth® 5.1', 'Up to FHD webcam with privacy shutter', '-', '-', 'As thin as 17.8mm x 313.1mm x 224.9mm / 0.70 inch x 8.85 inch x 12.32 inch', 'This laptop is good', 'Windows 11', 'McAvee'),
('AIVOWFC8Y', 'YOGA 7I (16 inch, GEN 8)', 11, 'YG', '2023-12-04-656d84b717aca.png', 12000000, 14000000, '16 inch WUXGA (1920 x 1200) IPS, 16 10, 300 nits, 45% NTSC, Glossy, 10-point multi-touch glass', 'Up to 16GB DDR5', 'Up to 13th Gen Intel® Core™ i7', 'Intel® Iris® Xe', 'Up to 1TB PCIe SSD Gen 4', '2 x 2W speakers Dolby Atmos® Audio', '71Wh battery WUXGA IPS models  ', 'WUXGA models Starting at 2.04kg / 4.49lbs', 'WiFi Ports/Slots', '1080p FHD + IR RGB webcam with privacy shutter', 'Up to 32 GB', 'Up to 2 TB', '15,2mm-16,5mm x 318mm x 230mm / 0,6 inch-0,65 inch x 12,52 inch x 9,06 inch', 'YOGA 7i is the perfect laptops for artists who is looking for the high tech laptop with a budget ', 'Windows 11', 'McAvee'),
('FIJ75X4PT', 'IDEAPAD FLEX 5I (16 inch, GEN 8)', 17, 'IP', '2023-12-04-656d8b4d40cb1.png', 15000000, 17000000, 'Up to 16 inch 2.5K (2560 x 1600) IPS, 60 Hz, 16 10, 400 nits, 100% sRGB, TUV Low Blue Light Certification, Touch', 'Up to LPDDR4x  16 GB', 'Up to 13th Gen Intel® Core™ i7-1355U', 'UMA  Intel® Integrated Graphics', 'Up to PCIe M.2  1TB', '2 x 2W User-facing Speakers, Dolby Audio®', '52.5WHr Polymer Battery Life up to 13.5 Hours', 'Starting at 2.10 kg (4.62 lbs)', 'WiFi Ports/Slots', 'FHD Camera | Privacy Shutter', '-', '-', '(mm)   357.8 x 253.9 x as thin as 18.7', 'Ideapad flex 5I is one of the best of the best', 'Windows 11', 'McAvee'),
('G7L83EQRL', 'YOGA 9I (14 inch, GEN 8)', 20, 'YG', '2023-12-04-656d9064156d5.png', 14000000, 16000000, '14 inch 4K (3840 x 2400) PureSight OLED, 400 nits (Peak HDR 600 nits), 16 10 aspect ratio, 100% DCI-P3, 60Hz refresh rate, VESA DisplayHDR™ True Black 500 certified, Dolby Vision™, TUV Rheinland® EyeSafe and Low Blue Light certification, touchscreen.', 'Up to 16GB LPDDR5 dual channel', 'Up to 13th Gen Intel® Core™ i7-1360P', 'Intel® Iris® Xe', 'Up to 1TB PCIe SSD', 'Bowers & Wilkins rotating soundbar system ', 'Up to 10.5 hours (MobileMark® 2018)/Up to 14 hours (Local Video Playback)', 'Starting at 1.4kg / 3.09lbs', 'WiFi 6E Bluetooth® 5.2', 'FHD 1080P IR Camera with camera privacy shutter', 'Up to 32 GB', 'Up to 2 TB', '16.4mm x 301.7mm x 214.6mm / 0.65 inch x 11.88 inch x 8.44 inch', 'This laptop never gets old', 'Windows 11', 'McAvee'),
('IDEAPAD01', 'IDEAPAD FLEX 5I (16 inch, GEN 7)', 14, 'IP', '2023-12-04-545c73a606zbz.png', 5000000, 7000000, 'Up to 16 inch 2.5K (2560 x 1600) IPS, 60 Hz, 16 10, 400 nits, 100% sRGB, TUV Low Blue Light Certification, Touch', 'Up to LPDDR4x  16 GB', 'Up to 13th Gen Intel® Core™ i7-1355U', 'UMA  Intel® Integrated Graphics', 'Up to PCIe M.2  1TB', '2 x 2W User-facing Speakers, Dolby Audio®', '52.5WHr Polymer Battery Life up to 13.5 Hours', 'Starting at 2.10 kg (4.62 lbs)', 'WiFi Ports/Slots', 'FHD Camera | Privacy Shutter', '-', '-', '14.08 inch x 9.99 inch x as thin as 0.74 inch', 'Ideapad is an budget laptop, especially for the students in IT USU', 'Red Hat', 'Mc Avee'),
('LEGION001', 'THINKPAD L13 YOGA GEN 4 (13 inch AMD)\n\n\n', 14, 'TP', '2023-12-04-435c73a606zbz.png', 10000000, 12000000, 'WUXGA (1920 X 1200) IPS, on-cell touchscreen, antiglare/antismudge, 400 nits, 100% sRGB, TUV certified low blue light', 'Up to 32GB 3200MHz soldered, dual channel\n\n\n', 'Up to AMD Ryzen™ PRO 7030 Series Mobile Processor\n\n\n', 'Integrated AMD Radeon™\n\n\n', 'Up to 32GB 3200MHz soldered, dual channel\n\n\n', '2 x microphones 2 x speakers', '46 Whr Supports Rapid Charge with 65W or higher adapter (60 minutes = 80% runtime)', 'Starting at 1.31kg / 2.9lbs\n\n\n', 'WiFi Ports/Slots', 'HD 720p RGB with webcam privacy shutter\n', '-', '-', '11.5mm x 297.5mm x 232.2mm x / 0.45 inch x 11.71 inch x 9.14 inch\n\n\n', 'Thinkpad like this is goooodd for various amount of users', 'Linux', 'Smadav'),
('Q8UN3VN67', 'IDEAPAD FLEX 5I (14 inch, GEN 8)', 4, 'IP', '2023-12-04-656d8c8a8af17.png', 11000000, 13000000, '14 inch WUXGA (1920 x 1200) OLED, 60 Hz, 16 10, 400 nits, 100% DCI-P3, TUV Low Blue Light Certification, Touch', 'Up to LPDDR4x  16 GB', 'Up to Intel® Core™ i7-1355U', 'UMA  Intel® Integrated Graphics', 'Up to PCIe M.2  1TB', '2 x 2W User-facing Speakers, Dolby Audio®', 'Up to 10 hours (MM18) Up to 15 hours (video playback)', 'Metal Cover Version Starting at 1.50 kg (3.31 lbs)', 'WiFi Ports/Slots', 'HD & FHD Camera | Privacy Shutter', '-', '-', '(inches)   12.32 inch x 8.85 inch x as thin as 0.69 inch', 'This laptop is suitable for crative people', 'Windows 11', 'McAvee'),
('TLQPDOADQ', 'THINKPAD X1 TITANIUM YOGA', 6, 'TP', '2023-12-04-656d8f4208d66.png', 9000000, 11000000, '14 inch FHD (1920 x 1080) IPS touchscreen, 300 nits, 72%NTSC', 'Up to 16GB LPDDR4x', 'Up to 11th Gen Intel®Core™ i7 vPro®', 'Intel®Iris®Xe', 'Up to 1TB PCIe SSD', 'Dolby Atmos®Speaker System 4 x 360-degree mics', 'Up to 8.9 hours 44.5Wh (MM18)', 'Starting at 1.15kg / 2.54lbs', 'Optional  WWAN 4x4 MIMO 5G (LTE CAT20) / 4G (LTE CAT9) ', '1MP HD 720p', 'Up to 32 GB', 'Up to 2 TB', '297,4mm x 205,5mm x 9,19mm / 11,7 inch x 8,1 inch x 0,4 inch', 'This product is one of the best', 'Windows 11', 'McAvee'),
('X26FGJ701', 'THINKPAD X1 YOGA GEN 8 (14 inch INTEL)', 15, 'TP', '2023-12-03-656bfc0ac28c1.png', 6000000, 8000000, '14 inch WQUXGA OLED (3840 x 2400) HDR400, touchscreen, IPS with Dolby Vision® 500 nits, 100% DCI P3 Color Gamut, antireflective/antismudge, Eyesafe®certified low blue-light emissions', 'Up to 64GB LPDDR5', 'Up to Intel vPro®, an Intel®Evo™ Design with 13th Gen Intel®Core™ i7 processor', 'Intel®Iris®Xe', 'Up to 2TB Gen 4 performance PCIe NVMe SSD', 'Dolby Atmos® - 4 x 360-degree quad-array microphones', '57Whr battery  - Rapid Charge (60 minutes = 80% runtime), requires 65W or higher adapter', 'Starting at 1.38kg / 3lbs', 'WiFi Ports/Slots Docking', 'FHD RGB with webcam privacy shutter', '-', '-', '15.53mm x 314.4mm x 222.3mm x / 0.61 inch x 12.38 inch x 8.75 inch', 'This product is suitable for college students who is looking for high volume tasks with a budget!', 'Windows 11', 'McAvee');

--
-- Trigger `products`
--
DELIMITER $$
CREATE TRIGGER `add_product` AFTER INSERT ON `products` FOR EACH ROW BEGIN
	INSERT INTO log_product VALUES (NEW.product_id, 'CREATED', NOW(), NEW.dealer_prices);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delete_product` BEFORE DELETE ON `products` FOR EACH ROW BEGIN
	INSERT INTO log_product VALUES (OLD.product_id, 'DELETED', NOW(), OLD.dealer_prices);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_product_price` AFTER UPDATE ON `products` FOR EACH ROW BEGIN
	INSERT INTO log_product VALUES (NEW.product_id, 'UPDATED', NOW(), NEW.dealer_prices);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `product_by_popularity`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `product_by_popularity` (
`category` varchar(255)
,`dealer_prices` decimal(10,0)
,`photo` varchar(255)
,`product_id` char(9)
,`product_name` text
,`sold_products` bigint
,`user_prices` decimal(10,0)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `product_carousels`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `product_carousels` (
`category` varchar(255)
,`dealer_prices` decimal(10,0)
,`photo` varchar(255)
,`product_id` char(9)
,`product_name` text
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `reports`
--

CREATE TABLE `reports` (
  `report_id` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `status` enum('Unresolved','Resolved') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `reports`
--

INSERT INTO `reports` (`report_id`, `user_id`, `description`, `status`, `time`) VALUES
('6LGFT', 'RMW6F2U33', 'Si sem kayak o chin-chin desu!', 'Resolved', '2023-12-05 06:36:49'),
('ASDFG', 'KHDA102YI', 'UI elements not displaying correctly', 'Resolved', '2023-11-28 09:47:01'),
('ASGFG', 'KHDA102YI', 'Product stability improved after fix', 'Resolved', '2023-04-28 11:45:00'),
('AUDAD', 'KHDA102YI', 'I cant use this product', 'Resolved', '2023-11-29 01:08:57'),
('BPKS6', 'UJ23SYDHT', 'wishlist apaan?', 'Unresolved', '2023-12-05 01:16:11'),
('GHDJF', 'KHDA102YI', 'Issues with login functionality', 'Resolved', '2023-11-29 00:42:46'),
('GHEJF', 'KHDA102YI', 'Startup crash fixed with recent update', 'Resolved', '2023-05-10 13:09:00'),
('ITHZH', 'UJ23SYDHT', 'kenapa kenapa', 'Resolved', '2023-12-05 08:10:59'),
('KTDHB', 'ADMDMGPTM', 'Testing this is report from admin', 'Resolved', '2023-11-28 08:55:44'),
('LKJGG', 'KHDA102YI', 'UI elements display corrected after patch', 'Resolved', '2023-10-30 09:28:00'),
('LKJHG', 'KHDA102YI', 'Crash on startup after recent update', 'Resolved', '2023-11-29 01:20:54'),
('MNDHB', 'KHDA102YI', 'Timeout issue resolved with server update', 'Resolved', '2023-05-24 20:41:00'),
('MNJHB', 'KHDA102YI', 'Frequent timeouts during usage', 'Resolved', '2023-12-05 01:05:58'),
('MPLUH', 'RMW6F2U33', 'Testing report, this is from users', 'Resolved', '2023-12-04 12:34:28'),
('NMJGL', 'KHDA102YI', 'Compatibility issue resolved with OS update', 'Resolved', '2023-06-07 15:03:00'),
('NMJKL', 'KHDA102YI', 'Compatibility issues with OS', 'Resolved', '2023-12-01 08:48:10'),
('PLKGU', 'KHDA102YI', 'Data recovery solution implemented', 'Resolved', '2023-08-19 00:55:00'),
('PLKIU', 'KHDA102YI', 'Data loss in specific scenarios', 'Resolved', '2023-12-04 17:11:07'),
('POKHD', 'KHDA102YI', 'Error fix for accessing specific features', 'Resolved', '2023-11-11 07:12:00'),
('POKSD', 'KHDA102YI', 'Product crashes frequently', 'Resolved', '2023-11-29 00:41:42'),
('QWERL', 'KHDA102YI', 'Resolved login authentication issue', 'Resolved', '2023-07-15 02:32:00'),
('QWERT', 'KHDA102YI', 'Slow performance after recent update', 'Resolved', '2023-11-29 00:41:58'),
('TUSDK', 'KHDA102YI', 'Si sem kayak o chin-chin desu!', 'Resolved', '2023-11-29 00:50:21'),
('YUIGP', 'KHDA102YI', 'Settings changes saving properly now', 'Resolved', '2023-08-14 06:07:00'),
('YUIOP', 'KHDA102YI', 'Unable to save changes in settings', 'Resolved', '2023-12-05 08:10:20'),
('ZXCVB', 'KHDA102YI', 'Error when accessing certain features', 'Resolved', '2023-12-06 02:18:20'),
('ZXCVF', 'KHDA102YI', 'Performance enhancement applied successfully', 'Resolved', '2023-09-02 04:20:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `salesman`
--

CREATE TABLE `salesman` (
  `user_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `position` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `salary` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `gender` enum('Male','Female') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `background_ed` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `employment_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `salesman`
--

INSERT INTO `salesman` (`user_id`, `position`, `salary`, `gender`, `background_ed`, `employment_type`) VALUES
('AIUH128O1', 'Chief Sales Officer', 'Rp.100.000.000,-', 'Female', 'Diploma of Arts, XXX', 'Full Time'),
('CHRISTY06', 'Junior Sales', 'Rp.5.000.000,-', 'Male', 'Undergrad of IT, USU', 'Internship'),
('TH0R10912', 'Senior Sales', 'Rp.7.000.000,-', 'Male', 'Undergrad of IT, USU', 'Full Time');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `sales_account`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `sales_account` (
`background_ed` varchar(255)
,`created_at` timestamp
,`email` varchar(255)
,`employment_type` varchar(255)
,`gender` enum('Male','Female')
,`name` varchar(255)
,`phone_number` varchar(14)
,`position` varchar(255)
,`salary` varchar(30)
,`user_id` char(9)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `sales_report`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `sales_report` (
`customer_name` varchar(255)
,`delivery_address` text
,`order_date` timestamp
,`order_id` char(10)
,`product_id` char(9)
,`product_name` text
,`status` enum('Unconfirmed','Confirmed','Received')
,`total` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `stock_report`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `stock_report` (
`dealer_prices` decimal(10,0)
,`product_id` char(9)
,`product_name` text
,`sold_products` bigint
,`stock` int
,`user_prices` decimal(10,0)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `treshold_stock`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `treshold_stock` (
`product_id` char(9)
,`product_name` text
,`stock` int
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `unconfirmed_order_delivery`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `unconfirmed_order_delivery` (
`delivery_address` text
,`name` varchar(255)
,`order_date` timestamp
,`order_id` char(10)
,`product_name` text
,`struct` varchar(255)
,`total` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `unresolved_bug_report`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `unresolved_bug_report` (
`description` text
,`email` varchar(255)
,`name` varchar(255)
,`report_id` char(5)
,`time` timestamp
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `user_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `level_user` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `phone_number` varchar(14) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`user_id`, `name`, `level_user`, `created_at`, `updated_at`, `email`, `phone_number`, `password`) VALUES
('2UDAYNYWA', 'Ikhwan Prananta', 'Users', '2023-12-06 02:11:16', NULL, 'pra@gmail.com', '092138912783', '3c24ca7afbc8766f1acb7d67893ec16d'),
('4TTDVC54B', 'Said Muhammad Mazaya', 'Courier', '2023-12-01 08:59:56', NULL, 'said@gmail.com', '08172673127', 'b7b791e873f143d5318310e59022175d'),
('ADMDMGPTM', 'Dayamega Pratama Admin', 'Admin', '2023-11-26 01:24:03', NULL, 'dayamegapratama@gmail.com', '081371699816', '21232f297a57a5a743894a0e4a801fc3'),
('AIUH128O1', 'Patricia Indry Ely', 'Sales', '2023-11-24 05:36:52', NULL, 'patchi@gmail.com', '081264036128', '4ffc7bec7f4d4f443ecd75fd07d55db6'),
('CBMPZ3KG4', 'Muhammad Raihan Abidllah Lubis', 'Users', '2023-11-28 07:56:49', NULL, 'raihan@gmail.com', '0801823723', 'b85daae836f261aa090f9f4ac573091c'),
('CHRISTY06', 'Christy Eliana Simarmata', 'Sales', '2023-11-24 05:36:52', NULL, 'christy@gmail.com', '081315752099', '0584b97a347e8afd603545c731900916'),
('HSAD032FA', 'Samuel Christoper Bintang Silaen', 'Courier', '2023-11-27 14:09:19', NULL, 'samuelganteng@gmail.com', '082277955226', 'd8ae5776067290c4712fa454006c8ec6'),
('KHDA102YI', 'Oswald Adrian Silalahi', 'Courier', '2023-11-27 11:49:34', NULL, 'oswaldsangkurir@gmail.com', '085274199560', '30d901e9aea791e635c984a6291b70d5'),
('M4UR3N999', 'Maureen Lovynka Trunstiatica Zalukhu', 'Courier', '2023-12-01 03:06:59', NULL, 'maureen@gmail.com', '081623771212', '23fac6d182d22ece806f28d7ba0264d4'),
('OK0VLQXX0', 'Paskal Irvaldi Manik', 'Users', '2023-12-04 20:55:40', NULL, 'paskals@gmail.com', '0128378273', 'aa141c20d606bb21fc45421d37c63761'),
('RMW6F2U33', 'Grant Gabriel Tambunan', 'Users', '2023-11-23 21:56:02', NULL, 'grantgabriel30@gmail.com', '081298764697', '145779bfc6fcd9967e4de7d8b541fac5'),
('TGEEDVQNU', 'Retep Grang Sitanggang', 'Users', '2023-12-24 07:49:55', NULL, 'grantgabriel3008@gmail.com', '0187621739123', 'd9b1d7db4cd6e70935368a1efb10e377'),
('TH0R10912', 'Muhammad Thoriq Al Asy-Jari', 'Sales', '2023-12-01 02:54:26', NULL, 'thoriqqq@gmail.com', '0812328613', 'c0176f364b73516947e8e45b8b3c9e97'),
('UJ23SYDHT', 'Pelangi Sanrilla Sinurat', 'Users', '2023-11-24 17:07:19', NULL, 'pelangi@gmail.com', '628983874300', '972a9f0dc30d2d552063983763dab7d8');

--
-- Trigger `users`
--
DELIMITER $$
CREATE TRIGGER `delete_admin_acc` BEFORE DELETE ON `users` FOR EACH ROW BEGIN
	IF(OLD.level_user = 'Admin') THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Cannot delete admin user.';
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delete_couriers_acc` BEFORE DELETE ON `users` FOR EACH ROW BEGIN
	IF(OLD.level_user = 'Courier') THEN
		INSERT INTO log_couriers_account VALUES (OLD.user_id, OLD.name, NOW(), 'DELETED');
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delete_customers_acc` BEFORE DELETE ON `users` FOR EACH ROW BEGIN 
	IF(OLD.level_user = 'Users') THEN
		INSERT INTO log_customers_account VALUES (OLD.user_id, OLD.name, NOW(), 'DELETED');
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delete_sales_acc` BEFORE DELETE ON `users` FOR EACH ROW BEGIN
	IF(OLD.level_user = 'Sales') THEN
		INSERT INTO log_sales_account VALUES (OLD.user_id, OLD.name, NOW(), 'DELETED');
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `regist_courier_acc` AFTER INSERT ON `users` FOR EACH ROW BEGIN
	IF(NEW.level_user = 'Courier') THEN
		INSERT INTO log_couriers_account VALUES (NEW.user_id, NEW.name, NOW(), 'CREATED');
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `regist_customers_acc` AFTER INSERT ON `users` FOR EACH ROW BEGIN 
	IF(NEW.level_user = 'Users') THEN
		INSERT INTO log_customers_account VALUES (NEW.user_id, NEW.name, NOW(), 'CREATED');
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `regist_sales_acc` AFTER INSERT ON `users` FOR EACH ROW BEGIN
	IF(NEW.level_user = 'Sales') THEN
		INSERT INTO log_sales_account VALUES (NEW.user_id, NEW.name, NOW(), 'CREATED');
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur untuk view `all_orders_data`
--
DROP TABLE IF EXISTS `all_orders_data`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `all_orders_data`  AS SELECT `o`.`order_id` AS `order_id`, `o`.`product_id` AS `product_id`, `o`.`user_id` AS `user_id`, `o`.`total` AS `total`, `o`.`delivery_address` AS `delivery_address`, `o`.`contact` AS `contact`, `o`.`order_date` AS `order_date`, `o`.`courier_id` AS `courier_id`, `o`.`status` AS `status`, `o`.`message` AS `message`, `o`.`struct` AS `struct`, `p`.`product_name` AS `product_name`, `p`.`photo` AS `photo`, `p`.`dealer_prices` AS `dealer_prices`, `u`.`name` AS `courier_name` FROM ((`orders` `o` join `products` `p` on((`o`.`product_id` = `p`.`product_id`))) join `users` `u` on((`o`.`courier_id` = `u`.`user_id`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `all_products`
--
DROP TABLE IF EXISTS `all_products`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `all_products`  AS SELECT `p`.`product_id` AS `product_id`, `p`.`product_name` AS `product_name`, `p`.`stock` AS `stock`, `c`.`category` AS `category`, `p`.`photo` AS `photo`, `p`.`user_prices` AS `user_prices`, `p`.`dealer_prices` AS `dealer_prices` FROM (`products` `p` join `categories` `c` on((`p`.`category_id` = `c`.`category_id`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `all_product_data`
--
DROP TABLE IF EXISTS `all_product_data`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `all_product_data`  AS SELECT `p`.`product_id` AS `product_id`, `p`.`product_name` AS `product_name`, `p`.`stock` AS `stock`, `p`.`category_id` AS `category_id`, `p`.`photo` AS `photo`, `p`.`user_prices` AS `user_prices`, `p`.`dealer_prices` AS `dealer_prices`, `p`.`spec_display` AS `spec_display`, `p`.`spec_ram` AS `spec_ram`, `p`.`spec_proc` AS `spec_proc`, `p`.`spec_gpu` AS `spec_gpu`, `p`.`spec_storage` AS `spec_storage`, `p`.`spec_audio` AS `spec_audio`, `p`.`spec_battery` AS `spec_battery`, `p`.`spec_weight` AS `spec_weight`, `p`.`spec_connectivity` AS `spec_connectivity`, `p`.`spec_camera` AS `spec_camera`, `p`.`spec_extandable_ram` AS `spec_extandable_ram`, `p`.`spec_extandable_ssd` AS `spec_extandable_ssd`, `p`.`spec_dimension` AS `spec_dimension`, `p`.`description` AS `description`, `p`.`operating_system` AS `operating_system`, `p`.`antivirus` AS `antivirus`, `c`.`category` AS `category`, (select count(`orders`.`product_id`) from `orders` where (`orders`.`product_id` = `p`.`product_id`)) AS `sold_products` FROM (`products` `p` join `categories` `c` on((`p`.`category_id` = `c`.`category_id`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `confirmed_order_delivery`
--
DROP TABLE IF EXISTS `confirmed_order_delivery`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `confirmed_order_delivery`  AS SELECT `o`.`order_id` AS `order_id`, `u`.`name` AS `name`, `u`.`email` AS `email`, `p`.`product_name` AS `product_name`, `o`.`delivery_address` AS `delivery_address`, `o`.`order_date` AS `order_date` FROM ((`orders` `o` join `products` `p` on((`o`.`product_id` = `p`.`product_id`))) join `users` `u` on((`o`.`user_id` = `u`.`user_id`))) WHERE (`o`.`status` = 'Confirmed') ;

-- --------------------------------------------------------

--
-- Struktur untuk view `couriers_account`
--
DROP TABLE IF EXISTS `couriers_account`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `couriers_account`  AS SELECT `u`.`user_id` AS `user_id`, `u`.`name` AS `name`, `u`.`created_at` AS `created_at`, `u`.`email` AS `email`, `u`.`phone_number` AS `phone_number`, `c`.`hourly_fee` AS `hourly_fee`, `c`.`vehicle` AS `vehicle` FROM (`users` `u` join `couriers` `c` on((`u`.`user_id` = `c`.`user_id`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `customers_account`
--
DROP TABLE IF EXISTS `customers_account`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customers_account`  AS SELECT `u`.`user_id` AS `user_id`, `u`.`name` AS `name`, `u`.`created_at` AS `created_at`, `u`.`email` AS `email`, `u`.`phone_number` AS `phone_number`, `c`.`address` AS `address`, `c`.`last_purchase` AS `last_purchase` FROM (`users` `u` join `customers` `c` on((`u`.`user_id` = `c`.`user_id`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `empty_stock`
--
DROP TABLE IF EXISTS `empty_stock`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `empty_stock`  AS SELECT `products`.`product_id` AS `product_id`, `products`.`product_name` AS `product_name`, `products`.`stock` AS `stock` FROM `products` WHERE (`products`.`stock` = 0) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `log_account`
--
DROP TABLE IF EXISTS `log_account`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `log_account`  AS SELECT `log_customers_account`.`user_id` AS `user_id`, `log_customers_account`.`name` AS `name`, `log_customers_account`.`time` AS `time`, `log_customers_account`.`action` AS `action` FROM `log_customers_account`union all select `log_couriers_account`.`user_id` AS `user_id`,`log_couriers_account`.`name` AS `name`,`log_couriers_account`.`time` AS `time`,`log_couriers_account`.`action` AS `action` from `log_couriers_account` union all select `log_sales_account`.`user_id` AS `user_id`,`log_sales_account`.`name` AS `name`,`log_sales_account`.`time` AS `time`,`log_sales_account`.`action` AS `action` from `log_sales_account` order by `time` desc  ;

-- --------------------------------------------------------

--
-- Struktur untuk view `log_product_v`
--
DROP TABLE IF EXISTS `log_product_v`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `log_product_v`  AS SELECT `l`.`product_id` AS `product_id`, `p`.`product_name` AS `product_name`, `l`.`action` AS `action`, `l`.`time` AS `time`, `l`.`price` AS `price` FROM (`log_product` `l` join `products` `p` on((`p`.`product_id` = `l`.`product_id`))) ORDER BY `l`.`time` DESC ;

-- --------------------------------------------------------

--
-- Struktur untuk view `log_purchase_v`
--
DROP TABLE IF EXISTS `log_purchase_v`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `log_purchase_v`  AS SELECT `l`.`order_id` AS `order_id`, `u`.`name` AS `name`, `p`.`product_name` AS `product_name`, `l`.`total` AS `total`, `l`.`time` AS `time`, `l`.`action` AS `action` FROM ((`log_purchase` `l` join `users` `u` on((`u`.`user_id` = `l`.`user_id`))) join `products` `p` on((`p`.`product_id` = `l`.`product_id`))) ORDER BY `l`.`time` DESC ;

-- --------------------------------------------------------

--
-- Struktur untuk view `product_by_popularity`
--
DROP TABLE IF EXISTS `product_by_popularity`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `product_by_popularity`  AS SELECT `p`.`product_id` AS `product_id`, `p`.`product_name` AS `product_name`, `c`.`category` AS `category`, `p`.`dealer_prices` AS `dealer_prices`, `p`.`user_prices` AS `user_prices`, `p`.`photo` AS `photo`, (select count(`orders`.`product_id`) from `orders` where (`orders`.`product_id` = `p`.`product_id`)) AS `sold_products` FROM (`products` `p` join `categories` `c` on((`p`.`category_id` = `c`.`category_id`))) ORDER BY (select count(`orders`.`product_id`) from `orders` where (`orders`.`product_id` = `p`.`product_id`)) DESC ;

-- --------------------------------------------------------

--
-- Struktur untuk view `product_carousels`
--
DROP TABLE IF EXISTS `product_carousels`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `product_carousels`  AS SELECT `p`.`product_id` AS `product_id`, `p`.`product_name` AS `product_name`, `c`.`category` AS `category`, `p`.`dealer_prices` AS `dealer_prices`, `p`.`photo` AS `photo` FROM (`products` `p` join `categories` `c` on((`p`.`category_id` = `c`.`category_id`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `sales_account`
--
DROP TABLE IF EXISTS `sales_account`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sales_account`  AS SELECT `u`.`user_id` AS `user_id`, `u`.`name` AS `name`, `u`.`created_at` AS `created_at`, `u`.`email` AS `email`, `u`.`phone_number` AS `phone_number`, `s`.`position` AS `position`, `s`.`salary` AS `salary`, `s`.`gender` AS `gender`, `s`.`background_ed` AS `background_ed`, `s`.`employment_type` AS `employment_type` FROM (`users` `u` join `salesman` `s` on((`u`.`user_id` = `s`.`user_id`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `sales_report`
--
DROP TABLE IF EXISTS `sales_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sales_report`  AS SELECT `o`.`order_id` AS `order_id`, `o`.`order_date` AS `order_date`, `u`.`name` AS `customer_name`, `p`.`product_id` AS `product_id`, `p`.`product_name` AS `product_name`, `o`.`delivery_address` AS `delivery_address`, `o`.`status` AS `status`, `o`.`total` AS `total` FROM ((`orders` `o` join `products` `p` on((`o`.`product_id` = `p`.`product_id`))) join `users` `u` on((`o`.`user_id` = `u`.`user_id`))) WHERE (`o`.`status` = 'Received') ORDER BY `o`.`order_date` DESC ;

-- --------------------------------------------------------

--
-- Struktur untuk view `stock_report`
--
DROP TABLE IF EXISTS `stock_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `stock_report`  AS SELECT `p`.`product_id` AS `product_id`, `p`.`product_name` AS `product_name`, `p`.`stock` AS `stock`, (select count(`orders`.`product_id`) from `orders` where (`orders`.`product_id` = `p`.`product_id`)) AS `sold_products`, `p`.`user_prices` AS `user_prices`, `p`.`dealer_prices` AS `dealer_prices` FROM `products` AS `p` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `treshold_stock`
--
DROP TABLE IF EXISTS `treshold_stock`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `treshold_stock`  AS SELECT `products`.`product_id` AS `product_id`, `products`.`product_name` AS `product_name`, `products`.`stock` AS `stock` FROM `products` WHERE ((`products`.`stock` > 0) AND (`products`.`stock` < 5)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `unconfirmed_order_delivery`
--
DROP TABLE IF EXISTS `unconfirmed_order_delivery`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `unconfirmed_order_delivery`  AS SELECT `o`.`order_id` AS `order_id`, `u`.`name` AS `name`, `p`.`product_name` AS `product_name`, `o`.`delivery_address` AS `delivery_address`, `o`.`struct` AS `struct`, `o`.`total` AS `total`, `o`.`order_date` AS `order_date` FROM ((`orders` `o` join `products` `p` on((`o`.`product_id` = `p`.`product_id`))) join `users` `u` on((`o`.`user_id` = `u`.`user_id`))) WHERE (`o`.`status` = 'Unconfirmed') ;

-- --------------------------------------------------------

--
-- Struktur untuk view `unresolved_bug_report`
--
DROP TABLE IF EXISTS `unresolved_bug_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `unresolved_bug_report`  AS SELECT `r`.`report_id` AS `report_id`, `u`.`name` AS `name`, `u`.`email` AS `email`, `r`.`description` AS `description`, `r`.`time` AS `time` FROM (`reports` `r` join `users` `u` on((`r`.`user_id` = `u`.`user_id`))) WHERE (`r`.`status` = 'Unresolved') ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indeks untuk tabel `couriers`
--
ALTER TABLE `couriers`
  ADD KEY `courier_user_CC` (`user_id`);

--
-- Indeks untuk tabel `customers`
--
ALTER TABLE `customers`
  ADD KEY `customer_user_CC` (`user_id`);

--
-- Indeks untuk tabel `log_category`
--
ALTER TABLE `log_category`
  ADD KEY `category_id` (`category_id`);

--
-- Indeks untuk tabel `log_couriers_account`
--
ALTER TABLE `log_couriers_account`
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `log_customers_account`
--
ALTER TABLE `log_customers_account`
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `log_order_status`
--
ALTER TABLE `log_order_status`
  ADD KEY `order_id` (`order_id`);

--
-- Indeks untuk tabel `log_product`
--
ALTER TABLE `log_product`
  ADD KEY `product_id` (`product_id`);

--
-- Indeks untuk tabel `log_purchase`
--
ALTER TABLE `log_purchase`
  ADD KEY `order_id` (`order_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indeks untuk tabel `log_sales_account`
--
ALTER TABLE `log_sales_account`
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `courier_id` (`courier_id`),
  ADD KEY `orders_ibfk_1` (`user_id`);

--
-- Indeks untuk tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indeks untuk tabel `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `salesman`
--
ALTER TABLE `salesman`
  ADD KEY `sales_user_CC` (`user_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `couriers`
--
ALTER TABLE `couriers`
  ADD CONSTRAINT `courier_user_CC` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Ketidakleluasaan untuk tabel `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customer_user_CC` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Ketidakleluasaan untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`courier_id`) REFERENCES `users` (`user_id`);

--
-- Ketidakleluasaan untuk tabel `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Ketidakleluasaan untuk tabel `salesman`
--
ALTER TABLE `salesman`
  ADD CONSTRAINT `sales_user_CC` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `salesman_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
