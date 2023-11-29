-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 28 Nov 2023 pada 15.25
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

CREATE DEFINER=`root`@`localhost` FUNCTION `countMonthlyUnresolvedReports` (`input_month` INT) RETURNS INT DETERMINISTIC BEGIN
    DECLARE fUnresolvedReports INT;

    SELECT COUNT(*) INTO fUnresolvedReports 
    FROM reports 
    WHERE status = 'Unresolved' 
    AND MONTH(time) = input_month;

    RETURN fUnresolvedReports;
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

CREATE DEFINER=`root`@`localhost` FUNCTION `getRandomCourierUserId` () RETURNS CHAR(9) CHARSET utf8mb4 DETERMINISTIC BEGIN
    DECLARE courier_id CHAR(9);

    SELECT user_id INTO courier_id
    FROM users
    WHERE level_user = 'Courier'
    ORDER BY RAND()
    LIMIT 1;

    RETURN courier_id;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `monthlyProfit` (`month_name` CHAR(3)) RETURNS DECIMAL(10,2) DETERMINISTIC BEGIN
    DECLARE profit DECIMAL(10, 2);
    SET profit = (
        SELECT SUM(total)
        FROM orders
        WHERE DATE_FORMAT(order_date, '%b') = month_name
    );
    RETURN COALESCE(profit, 0.00);
END$$

DELIMITER ;

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
`order_id` char(10)
,`name` varchar(255)
,`email` varchar(255)
,`product_name` text
,`delivery_address` text
,`order_date` timestamp
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
('KHDA102YI', 20000, 'Beat Regular 2021');

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
('KW2CTTPNX', NULL, 'Jl. Dwikora No 19 LK XI', NULL),
('RMW6F2U33', NULL, 'Jalan Dwikora Baru No 19', NULL),
('UJ23SYDHT', NULL, 'Jalan Binje Belok Kiri Kanan Sikit', NULL),
('V74BJ87U8', NULL, 'Jalan dekat gang gelap Gajah Mada', NULL),
('PZR1J2U5F', NULL, 'Jalan Pondok Surya VI-A No 231c', NULL),
('OL21FLPAB', NULL, 'Jalan Pondok Surya VI-A No 231c', NULL),
('CBMPZ3KG4', NULL, 'Jalan Neraka Sebelahnya', NULL);

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
('YG', 'YOGA', 'CREATED', '2023-11-26 15:35:59');

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
('COURIER01', 'Ethanzera', '2023-11-27 16:11:57', 'DELETED');

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
('CBMPZ3KG4', 'Muhammad Raihan Abidllah Lubis', '2023-11-28 07:56:49', 'CREATED');

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
('OAUSDHA123', 'Updated By', '2023-11-28 05:53:04', 'Courier');

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
('LEGION001', 'UPDATED', '2023-11-28 01:50:29', 12000000);

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
('J0K0W1KRN1', 'UJ23SYDHT', 'LEGION001', 12000000, '2023-11-28 08:50:29', 'PURCHASED');

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
('4ZM1LUB15', 'M. Naufal Azmi Lubis', '2023-11-26 02:53:31', 'DELETED');

-- --------------------------------------------------------

--
-- Struktur dari tabel `orders`
--

CREATE TABLE `orders` (
  `order_id` char(10) COLLATE utf8mb4_general_ci NOT NULL,
  `product_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `total` decimal(10,0) NOT NULL,
  `delivery_address` text COLLATE utf8mb4_general_ci NOT NULL,
  `contact` char(13) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `courier_id` char(9) COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('Unconfirmed','Confirmed','Received') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `orders`
--

INSERT INTO `orders` (`order_id`, `product_id`, `user_id`, `total`, `delivery_address`, `contact`, `order_date`, `courier_id`, `status`, `message`) VALUES
('AAGHH07437', 'LEGION001', 'UJ23SYDHT', 10000000, 'Jalan Ganteng Banget No.19', NULL, '2023-08-17 01:43:18', 'KHDA102YI', 'Received', NULL),
('ADGAD07437', 'LEGION001', 'V74BJ87U8', 10000000, 'Jalan Gajah Mada dekat Rakasih', NULL, '2023-10-14 01:40:58', 'KHDA102YI', 'Received', NULL),
('AGADUH313H', 'LEGION001', 'RMW6F2U33', 10000000, 'Komplek Marelan Nippon Permai, No 18C', NULL, '2023-07-10 01:45:39', 'KHDA102YI', 'Received', NULL),
('AOSUIST123', 'LEGION001', 'RMW6F2U33', 10000000, 'Jalan Rumah Grant No.123', NULL, '2023-11-28 01:50:29', 'KHDA102YI', 'Confirmed', NULL),
('AOUDH78153', 'IDEAPAD01', 'UJ23SYDHT', 7000000, 'Jalan Binje dekat KAI', NULL, '2023-09-18 01:43:18', 'KHDA102YI', 'Received', NULL),
('AYSDG12345', 'LEGION001', 'V74BJ87U8', 10000000, 'Jalan Fasilkom TI', NULL, '2023-11-27 15:32:41', 'KHDA102YI', 'Received', NULL),
('C14M0NR077', 'IDEAPAD01', 'UJ23SYDHT', 7000000, 'Jalan Jauh Banget Dekat Tokyo', '+821579471', '2023-11-27 15:27:04', 'KHDA102YI', 'Received', NULL),
('J0K0W1KRN1', 'LEGION001', 'UJ23SYDHT', 10000000, 'Jalan Binjai Dekat SMAN 1', NULL, '2023-11-28 01:50:44', 'KHDA102YI', 'Confirmed', NULL),
('JDGUY12375', 'IDEAPAD01', 'KW2CTTPNX', 7000000, 'Jalan Pancing Sebelah Rumah Dira', NULL, '2023-11-17 01:45:39', 'KHDA102YI', 'Received', NULL),
('LOPC1AM0NS', 'IDEAPAD01', 'RMW6F2U33', 7000000, 'Jalan Cinta Diantara Kita No.21', NULL, '2023-11-09 01:48:09', 'KHDA102YI', 'Received', NULL),
('OAUSDHA123', 'IDEAPAD01', 'V74BJ87U8', 7000000, 'Jalan wow keren banget', NULL, '2023-11-28 05:53:03', 'KHDA102YI', 'Received', NULL),
('SD831IAF45', 'LEGION001', 'RMW6F2U33', 10000000, 'Jalan jalan ke Tamasya', NULL, '2023-10-18 01:40:58', 'KHDA102YI', 'Received', NULL);

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
('IDEAPAD01', 'Ideapad Galaxy S23 Ultra', 5, 'IP', 'iniPhotoLegion.jpg', 5000000, 8000000, 'AMOLED', '16 GB', 'AMD Ryzen 6000', NULL, '256 GB', 'Harmonics', '16000 MaH', '1.6 KG', NULL, NULL, NULL, NULL, '14\"', 'Ideapad is an budget laptop', 'Red Hat', 'Mc Avee'),
('LEGION001', 'Legion IP Pro Max', 53, 'LG', 'iniPhotoLegion.jpg', 10000000, 12000000, 'OLED', '12 GB', 'Intel I7', 'NVIDIA 4090 ', '512 GB', 'RealTek', '12000 MaH', '3.3 KG', NULL, NULL, NULL, NULL, '15.6\"', 'Legion is the highend gaming laptop', 'Linux', 'Smadav');

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
`product_id` char(9)
,`product_name` text
,`category` varchar(255)
,`sold_products` bigint
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
('ASDFG', 'KHDA102YI', 'UI elements not displaying correctly', 'Resolved', '2023-11-28 09:47:01'),
('ASGFG', 'KHDA102YI', 'Product stability improved after fix', 'Resolved', '2023-04-28 11:45:00'),
('AUDAD', 'KHDA102YI', 'I cant use this product', 'Unresolved', '2023-11-28 09:36:06'),
('GHDJF', 'KHDA102YI', 'Issues with login functionality', 'Unresolved', '2023-07-15 02:32:00'),
('GHEJF', 'KHDA102YI', 'Startup crash fixed with recent update', 'Resolved', '2023-02-10 13:09:00'),
('KTDHB', 'ADMDMGPTM', 'Testing this is report from admin', 'Resolved', '2023-11-28 08:55:44'),
('LKJGG', 'KHDA102YI', 'UI elements display corrected after patch', 'Resolved', '2023-10-30 09:28:00'),
('LKJHG', 'KHDA102YI', 'Crash on startup after recent update', 'Unresolved', '2023-02-10 13:09:00'),
('MNDHB', 'KHDA102YI', 'Timeout issue resolved with server update', 'Resolved', '2023-05-24 20:41:00'),
('MNJHB', 'KHDA102YI', 'Frequent timeouts during usage', 'Unresolved', '2023-05-24 20:41:00'),
('NMJGL', 'KHDA102YI', 'Compatibility issue resolved with OS update', 'Resolved', '2023-06-07 15:03:00'),
('NMJKL', 'KHDA102YI', 'Compatibility issues with OS', 'Unresolved', '2023-06-07 15:03:00'),
('PLKGU', 'KHDA102YI', 'Data recovery solution implemented', 'Resolved', '2023-03-19 00:55:00'),
('PLKIU', 'KHDA102YI', 'Data loss in specific scenarios', 'Unresolved', '2023-03-19 00:55:00'),
('POKHD', 'KHDA102YI', 'Error fix for accessing specific features', 'Resolved', '2023-11-11 07:12:00'),
('POKSD', 'KHDA102YI', 'Product crashes frequently', 'Unresolved', '2023-04-28 11:45:00'),
('QWERL', 'KHDA102YI', 'Resolved login authentication issue', 'Resolved', '2023-07-15 02:32:00'),
('QWERT', 'KHDA102YI', 'Slow performance after recent update', 'Unresolved', '2023-09-02 04:20:00'),
('YUIGP', 'KHDA102YI', 'Settings changes saving properly now', 'Resolved', '2023-08-14 06:07:00'),
('YUIOP', 'KHDA102YI', 'Unable to save changes in settings', 'Unresolved', '2023-08-14 06:07:00'),
('ZXCVB', 'KHDA102YI', 'Error when accessing certain features', 'Unresolved', '2023-11-11 07:12:00'),
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
('CHRISTY06', 'Junior Sales', 'Rp.5.000.000,-', 'Male', 'Undergrad of IT, USU', 'Internship');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `stock_report`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `stock_report` (
`product_id` char(9)
,`product_name` text
,`stock` int
,`sold_products` bigint
,`user_prices` decimal(10,0)
,`dealer_prices` decimal(10,0)
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
`order_id` char(10)
,`name` varchar(255)
,`product_name` text
,`delivery_address` text
,`total` decimal(10,0)
,`order_date` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `unresolved_bug_report`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `unresolved_bug_report` (
`report_id` char(5)
,`name` varchar(255)
,`email` varchar(255)
,`description` text
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
('ADMDMGPTM', 'Dayamega Pratama Admin', 'Admin', '2023-11-26 01:24:03', NULL, 'dayamegapratama@gmail.com', '081371699816', '21232f297a57a5a743894a0e4a801fc3'),
('AIUH128O1', 'Patricia Indry Ely', 'Sales', '2023-11-24 05:36:52', NULL, 'patchi@gmail.com', '081264036128', '4ffc7bec7f4d4f443ecd75fd07d55db6'),
('CBMPZ3KG4', 'Muhammad Raihan Abidllah Lubis', 'Users', '2023-11-28 07:56:49', NULL, 'raihan@gmail.com', '0801823723', 'b85daae836f261aa090f9f4ac573091c'),
('CHRISTY06', 'Christy Eliana Simarmata', 'Sales', '2023-11-24 05:36:52', NULL, 'christy@gmail.com', '081315752099', '0584b97a347e8afd603545c731900916'),
('HSAD032FA', 'Samuel Christoper Bintang Silaen', 'Courier', '2023-11-27 14:09:19', NULL, 'samuelganteng@gmail.com', '082277955226', 'd8ae5776067290c4712fa454006c8ec6'),
('KHDA102YI', 'Oswald Adrian Silalahi', 'Courier', '2023-11-27 11:49:34', NULL, 'oswaldsangkurir@gmail.com', '085274199560', '30d901e9aea791e635c984a6291b70d5'),
('KW2CTTPNX', 'Ijat UMKM', 'Users', '2023-11-24 06:43:49', NULL, 'ijat@gmail.com', '08125669221', '8bd901218767cb93734036c695d1a225'),
('OL21FLPAB', 'Ibra Rizqy', 'Users', '2023-11-28 05:57:09', NULL, 'rizqyibra@gmail.com', '082370597095', 'e807f1fcf82d132f9bb018ca6738a19f'),
('PZR1J2U5F', 'Ibra Rizqy', 'Users', '2023-11-28 05:56:28', NULL, 'rizqyibra@gmail.com', '082370597095', 'e807f1fcf82d132f9bb018ca6738a19f'),
('RMW6F2U33', 'Grant Gabriel Tambunan', 'Users', '2023-11-23 21:56:02', NULL, 'grantgabriel30@gmail.com', '081298764697', '145779bfc6fcd9967e4de7d8b541fac5'),
('UJ23SYDHT', 'Pelangi Sanrilla Sinurat', 'Users', '2023-11-24 17:07:19', NULL, 'pelangi@gmail.com', '628983874300', '972a9f0dc30d2d552063983763dab7d8'),
('V74BJ87U8', 'Paskal Irvaldi Manik', 'Users', '2023-11-26 18:55:26', NULL, 'paskals@gmail.com', '0812836535', 'aa141c20d606bb21fc45421d37c63761');

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
-- Struktur untuk view `confirmed_order_delivery`
--
DROP TABLE IF EXISTS `confirmed_order_delivery`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `confirmed_order_delivery`  AS SELECT `o`.`order_id` AS `order_id`, `u`.`name` AS `name`, `u`.`email` AS `email`, `p`.`product_name` AS `product_name`, `o`.`delivery_address` AS `delivery_address`, `o`.`order_date` AS `order_date` FROM ((`orders` `o` join `products` `p` on((`o`.`product_id` = `p`.`product_id`))) join `users` `u` on((`o`.`user_id` = `u`.`user_id`))) WHERE (`o`.`status` = 'Confirmed') ;

-- --------------------------------------------------------

--
-- Struktur untuk view `empty_stock`
--
DROP TABLE IF EXISTS `empty_stock`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `empty_stock`  AS SELECT `products`.`product_id` AS `product_id`, `products`.`product_name` AS `product_name`, `products`.`stock` AS `stock` FROM `products` WHERE (`products`.`stock` = 0) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `product_by_popularity`
--
DROP TABLE IF EXISTS `product_by_popularity`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `product_by_popularity`  AS SELECT `p`.`product_id` AS `product_id`, `p`.`product_name` AS `product_name`, `c`.`category` AS `category`, (select count(`orders`.`product_id`) from `orders` where (`orders`.`product_id` = `p`.`product_id`)) AS `sold_products` FROM (`products` `p` join `categories` `c` on((`p`.`category_id` = `c`.`category_id`))) ORDER BY (select count(`orders`.`product_id`) from `orders` where (`orders`.`product_id` = `p`.`product_id`)) DESC ;

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

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `unconfirmed_order_delivery`  AS SELECT `o`.`order_id` AS `order_id`, `u`.`name` AS `name`, `p`.`product_name` AS `product_name`, `o`.`delivery_address` AS `delivery_address`, `o`.`total` AS `total`, `o`.`order_date` AS `order_date` FROM ((`orders` `o` join `products` `p` on((`o`.`product_id` = `p`.`product_id`))) join `users` `u` on((`o`.`user_id` = `u`.`user_id`))) WHERE (`o`.`status` = 'Unconfirmed') ;

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
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `courier_id` (`courier_id`);

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
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
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
