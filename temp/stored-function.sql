-- Menghitung hourly fee kurir -- 2
DELIMITER &&
CREATE FUNCTION courierSalary(courier_id CHAR(9)) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE fee DECIMAL(10, 2);
    SELECT hourly_fee INTO fee FROM couriers WHERE BINARY user_id = BINARY courier_id;
    RETURN fee * 8; -- Courier work for 8 hours a day!
END; &&
DELIMITER ;

-- Menghitung banyak jumlah akun pembeli -- 3
DELIMITER &&
CREATE FUNCTION countCustomer() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fUser INT;
    SELECT COUNT(*) INTO fUser FROM users WHERE level_user = 'Users';
    RETURN fUser;
END; &&
DELIMITER ;

-- Menghitung banyak jumlah akun penjual -- 4
DELIMITER &&
CREATE FUNCTION countSales() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fSales INT;
    SELECT COUNT(*) INTO fSales FROM users WHERE level_user = 'Sales';
    RETURN fSales;
END; &&
DELIMITER ;

-- Menghitung banyak jumlah akun kurir -- 5
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

-- Stored function untuk menghitung banyak laporan yang belum terselesaikan

-- Stored function untuk mengambil userid dari kurir secara acak.
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

-- Stored function untuk menghitung total laba bulan 
-- JANGAN DISENTUH LAGI KODE INI UDAH BERJALAN YAA ALLAHH
-- Jangan tanya, biarlah Tuhan dan hanya Tuhan yang paham
DELIMITER &&
CREATE FUNCTION monthlyTotal(month_name CHAR(3)) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE profit DECIMAL(10, 2);
    SET profit = (
        SELECT SUM(total)
        FROM orders
        WHERE DATE_FORMAT(order_date, '%b') = month_name
    );
    RETURN COALESCE(profit, 0.00);
END &&
DELIMITER ;
