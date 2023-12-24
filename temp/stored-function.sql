-- Menghitung hourly fee kurir -- 1
DELIMITER &&
CREATE FUNCTION courierSalary(courier_id CHAR(9)) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE fee DECIMAL(10, 2);
    SELECT hourly_fee INTO fee FROM couriers WHERE BINARY user_id = BINARY courier_id;
    RETURN fee * 8; -- Courier work for 8 hours a day!
END; &&
DELIMITER ;

-- Menghitung banyak jumlah akun pembeli -- 2
DELIMITER &&
CREATE FUNCTION countCustomer() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fUser INT;
    SELECT COUNT(*) INTO fUser FROM users WHERE level_user = 'Users';
    RETURN fUser;
END; &&
DELIMITER ;

-- Menghitung banyak jumlah akun penjual -- 3
DELIMITER &&
CREATE FUNCTION countSales() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fSales INT;
    SELECT COUNT(*) INTO fSales FROM users WHERE level_user = 'Sales';
    RETURN fSales;
END; &&
DELIMITER ;

-- Menghitung banyak jumlah akun kurir -- 4
DELIMITER &&
CREATE FUNCTION countCouriers() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fCourier INT;
    SELECT COUNT(*) INTO fCourier FROM users WHERE level_user = 'Courier';
    RETURN fCourier;
END; &&
DELIMITER ;

!-- PENTING : Ini Belum ada di Laporan! 

-- Stored function untuk menghitung banyak laporan yang belum terselesaikan -- 5
DELIMITER &&
CREATE FUNCTION countUnresolvedReports() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fUnresolvedReports INT;
    SELECT COUNT(*) INTO fUnresolvedReports FROM reports WHERE status = 'Unresolved';
    RETURN fUnresolvedReports;
END; &&
DELIMITER ;

-- Stored function untuk menghitung banyak laporan yang sudah terselesaikan -- 6
DELIMITER &&
CREATE FUNCTION countResolvedReports() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fResolvedReports INT;
    SELECT COUNT(*) INTO fResolvedReports FROM reports WHERE status = 'Resolved';
    RETURN fResolvedReports;
END; &&
DELIMITER ;


-- Stored function untuk mengambil userid dari kurir secara acak. -- 7
DELIMITER &&
CREATE FUNCTION getRandomCourierUserId()
RETURNS CHAR(9)
DETERMINISTIC
BEGIN
    DECLARE courierId CHAR(9);

    SELECT user_id INTO courierId
    FROM users
    WHERE level_user = 'Courier'
    ORDER BY RAND()
    LIMIT 1;

    RETURN courierId;
END &&
DELIMITER ;

-- Stored function untuk generate random ID -- 8
DELIMITER &&
CREATE FUNCTION generateUniqueID(limitLength INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
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
END &&
DELIMITER ;

-- Stored function untuk menghitung total laba bulan -- 9
-- JANGAN DISENTUH LAGI KODE INI UDAH BERJALAN YAA ALLAHH
-- Jangan tanya, biarlah Tuhan dan hanya Tuhan yang paham
DELIMITER &&
CREATE FUNCTION monthlyTotal(month_param INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE profit DECIMAL(10, 2);

    SELECT COALESCE(SUM(total), 0.00) INTO profit FROM orders WHERE MONTH(order_date) = month_param;

    RETURN profit;
END &&
DELIMITER ;

-- Stored function untuk menghitung total paket yang belum dikirim kurir tertentu -- 10
DELIMITER &&
CREATE FUNCTION countUndeliveredPackages(courier_id_param CHAR(9)) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fUndeliveredPackages INT;
    
    SELECT COUNT(*) INTO fUndeliveredPackages FROM orders 
    WHERE courier_id COLLATE utf8mb4_general_ci = courier_id_param COLLATE utf8mb4_general_ci 
    AND status = 'Confirmed';

    RETURN fUndeliveredPackages;
END; &&
DELIMITER ;

-- Stored function untuk menghitung total paket yang telah dikirim kurir tertentu -- 11
DELIMITER &&
CREATE FUNCTION countDeliveredPackages(courier_id_param CHAR(9)) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fDeliveredPackages INT;
    
    SELECT COUNT(*) INTO fDeliveredPackages FROM orders 
    WHERE courier_id COLLATE utf8mb4_general_ci = courier_id_param COLLATE utf8mb4_general_ci 
    AND status = 'Received';

    RETURN fDeliveredPackages;
END; &&
DELIMITER ;

-- Stored function untuk menghitung total paket yang telah diantar oleh semua kurir dalam bulan tertentu -- 12
DELIMITER &&
CREATE FUNCTION countMonthlyDeliveredPackages(month INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fDeliveredPackages INT;
    
    SELECT COUNT(*) INTO fDeliveredPackages FROM orders 
    WHERE status = 'Received' AND 
    MONTH(order_date) = month;

    RETURN fDeliveredPackages;
END; &&
DELIMITER ;

-- Stored function untuk menghitung total report yang belum diselesaikan pada bulan tertentu -- 13
DELIMITER &&
CREATE FUNCTION countMonthlyUnresolvedReports(input_month INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fUnresolvedReports INT;

    SELECT COUNT(*) INTO fUnresolvedReports 
    FROM reports 
    WHERE status = 'Unresolved' 
    AND MONTH(time) = input_month;

    RETURN fUnresolvedReports;
END &&
DELIMITER ;

-- Stored function untuk menghitung total report yang sudah diselesaikan pada bulan tertentu -- 14
DELIMITER &&
CREATE FUNCTION countMonthlyResolvedReports(input_month INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fResolvedReports INT;

    SELECT COUNT(*) INTO fResolvedReports 
    FROM reports 
    WHERE status = 'Resolved' 
    AND MONTH(time) = input_month;

    RETURN fResolvedReports;
END &&
DELIMITER ;

-- Stored function untuk menghitung total produk yang terjual per bulan -- 15
DELIMITER &&
CREATE FUNCTION countMonthlySoldProducts(input_month INT) RETURNS INT   
DETERMINISTIC
BEGIN
    DECLARE fSold INT;

    SELECT COUNT(*) INTO fSold 
    FROM orders 
    WHERE MONTH(order_date) = input_month
    AND status = 'Received';

    RETURN fSold;
END &&
DELIMITER ;

-- Stored function untuk menghitung total produk yang ada -- 16
DELIMITER &&
CREATE FUNCTION totalProducts() RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM products;

    RETURN total;
END &&
DELIMITER ; 

-- Stored function untuk menghitung jumlah kesuluruhan stock barang yang ada -- 17
DELIMITER &&
CREATE FUNCTION totalStocks() RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE totalStocks INT;
    SELECT SUM(stock) INTO totalStocks
    FROM products;

    RETURN totalStocks;
END &&
DELIMITER ;

-- Stored function untuk menghitung total pesanan yang belum terkonfirmasi -- 18
DELIMITER &&
CREATE FUNCTION countUnconfirmedPackages() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fUnconfirmedPackages INT;
    
    SELECT COUNT(*) INTO fUnconfirmedPackages FROM orders 
    WHERE status = 'Unconfirmed';

    RETURN fUnconfirmedPackages;
END; &&
DELIMITER ;

-- Stored function untuk menghitung pesanan yang telah terkonfirmasi -- 19
DELIMITER &&
CREATE FUNCTION countConfirmedPackages() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fConfirmedPackages INT;
    
    SELECT COUNT(*) INTO fConfirmedPackages FROM orders 
    WHERE status = 'Confirmed';

    RETURN fConfirmedPackages;
END; &&
DELIMITER ;

-- Stored function untuk menghitung berapa banyak produk yang telah terjual -- 20
DELIMITER &&
CREATE FUNCTION countTotalDeliveredPackages() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fDeliveredPackages INT;
    
    SELECT COUNT(*) INTO fDeliveredPackages FROM orders 
    WHERE status = 'Received';

    RETURN fDeliveredPackages;
END; &&
DELIMITER ;

-- Stored function untuk menghitung berapa banyak produk yang diambang batas habis stock -- 21
DELIMITER &&
CREATE FUNCTION countTresholdStocks() RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE fTresholdStocks INT;

    SELECT COUNT(*) INTO fTresholdStocks FROM treshold_stock;

    RETURN fTresholdStocks;
END &&
DELIMITER ;

-- Stored function untuk menghitung berapa banyak total produk yang stocknya telah habis -- 22
DELIMITER &&
CREATE FUNCTION countOutOfStocks() RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE fOutOfStocks INT;

    SELECT COUNT(*) INTO fOutOfStocks FROM empty_stock;

    RETURN fOutOfStocks;
END &&
DELIMITER ;

-- Stored function untuk mengambil harga dari suatu barang -- 23
DELIMITER &&
CREATE FUNCTION getDealerPrices(product_id_param CHAR(9)) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE p_dealer_price DECIMAL(10, 2);

    SELECT dealer_prices INTO p_dealer_price FROM products WHERE BINARY product_id = BINARY product_id_param;

    RETURN p_dealer_price;
END; &&
DELIMITER ;

-- Stored function untuk menghitung total penjualan -- 24
DELIMITER &&
CREATE FUNCTION totalSales()
RETURNS DECIMAL(18, 2)
DETERMINISTIC
BEGIN
    DECLARE total_sales DECIMAL(18, 2);

    SELECT SUM(total) INTO total_sales
    FROM sales_report;

    RETURN total_sales;
END &&
DELIMITER ;

-- Stored function untuk menghitung total penjualan di bulan tertentu
DELIMITER &&
CREATE FUNCTION totalMonthlySales(input_month INT)
RETURNS DECIMAL(18, 2)
DETERMINISTIC
BEGIN
    DECLARE total_sales DECIMAL(18, 2);

    SELECT SUM(total) INTO total_sales
    FROM sales_report WHERE MONTH(order_date) = input_month;

    RETURN total_sales;
END &&
DELIMITER ;
