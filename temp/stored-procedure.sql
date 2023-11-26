-- Stored procedure untuk tambah data customers -- 1
DELIMITER &&
CREATE PROCEDURE appendCustomers(
    IN user_id CHAR(9),
    IN name VARCHAR(255), 
    IN email VARCHAR(255), 
    IN phone_number VARCHAR(14),
    IN password VARCHAR(255),
    IN address TEXT
)
BEGIN
    DECLARE level_user CHAR(9);
    SET level_user = 'Users';

    INSERT INTO users VALUES(user_id, name, level_user, NOW(), NULL, email, phone_number, password);
    INSERT INTO customers VALUES(user_id, NULL, address, NULL);
END; &&
DELIMITER ;

-- Stored procedure untuk delete data customers -- 2
DELIMITER &&
CREATE PROCEDURE deleteCustomers(
    IN user_id_param CHAR(9)
)
BEGIN
    DECLARE user_level VARCHAR(9);

    SELECT level_user INTO user_level FROM users WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci LIMIT 1;

    IF (user_level = 'Users') THEN
        DELETE FROM users WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci;
        DELETE FROM customers WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci;
    END IF;
END &&
DELIMITER ;

-- Stored procedure untuk tambah data sales -- 3
DELIMITER &&
CREATE PROCEDURE appendSales(
    IN user_id CHAR(9),
    IN name VARCHAR(255), 
    IN email VARCHAR(255), 
    IN phone_number VARCHAR(14),
    IN password VARCHAR(255),
    IN position VARCHAR(255),
    IN salary VARCHAR(30),
    IN gender VARCHAR(10),
    IN background_ed VARCHAR(255),
    IN employment_type VARCHAR(255)
)
BEGIN
    DECLARE level_user CHAR(9);
    SET level_user = 'Sales';

    INSERT INTO users VALUES(user_id, name, level_user, NOW(), NULL, email, phone_number, password);
    INSERT INTO salesman VALUES(user_id, position, salary, gender, background_ed, employment_type);
END; &&
DELIMITER ;


-- Stored procedure untuk delete data sales -- 4
DELIMITER &&
CREATE PROCEDURE deleteSales(
    IN user_id_param CHAR(9)
)
BEGIN
    DECLARE user_level VARCHAR(9);

    SELECT level_user INTO user_level FROM users WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci LIMIT 1;

    IF (user_level = 'Sales') THEN
        DELETE FROM users WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci;
        DELETE FROM salesman WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci;
    END IF;
END &&
DELIMITER ;

-- Stored procedure untuk tambah data couriers -- 5
DELIMITER &&
CREATE PROCEDURE appendCouriers(
    IN user_id CHAR(9),
    IN name VARCHAR(255), 
    IN email VARCHAR(255), 
    IN phone_number VARCHAR(14),
    IN password VARCHAR(255),
    IN hourly_fee DECIMAL(10,0),
    IN vehicle VARCHAR(255)
)
BEGIN
    DECLARE level_user CHAR(9);
    SET level_user = 'Courier';

    INSERT INTO users VALUES(user_id, name, level_user, NOW(), NULL, email, phone_number, password);
    INSERT INTO couriers VALUES(user_id, hourly_fee, vehicle);
END; &&
DELIMITER ;

-- Stored procedure untuk delete data couriers -- 6
DELIMITER &&
CREATE PROCEDURE deleteCouriers(
    IN user_id_param CHAR(9)
)
BEGIN
    DECLARE user_level VARCHAR(9);

    SELECT level_user INTO user_level FROM users WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci LIMIT 1;

    IF (user_level = 'Courier') THEN
        DELETE FROM users WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci;
        DELETE FROM couriers WHERE user_id = user_id_param COLLATE utf8mb4_0900_ai_ci;
    END IF;
END &&
DELIMITER ;

-- Untuk menyimpan data saat terjadi purchase -- 7
-- NOTE : INI GAGAL MULU NGENTOT JADI GAK BAKAL DIPAKE, TP TTP AJA CATAT KE LAPORAN YA KMMAC.
--        ERROR TERUS INI PROCEDURE KENTOT EMANG PALING PAS PAKE DOCKER
DELIMITER &&
CREATE PROCEDURE addPurchase(
    IN order_id CHAR(10),
    IN product_id_param CHAR(9),
    IN user_id CHAR(9),
    IN delivery_address TEXT,
    IN contact CHAR(13)
)
BEGIN
    DECLARE purchase_total DECIMAL(10, 0);
    SELECT dealer_prices INTO purchase_total FROM products WHERE product_id = CONVERT(product_id_param USING utf8mb4_general_ci);

    INSERT INTO orders VALUES(
        order_id,
        product_id_param,
        user_id,
        purchase_total,
        delivery_address,
        contact,
        NOW(),
        getRandomCourierUserId(),
        'Unconfirmed',
        NULL
    );
END; &&
DELIMITER ;

-- Stored procedure untuk menghapus data pesanan -- 8
DELIMITER &&
CREATE PROCEDURE deletePurchase(
    IN order_id_param CHAR(10)
)
BEGIN
    DECLARE converted_order_id CHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
    SET converted_order_id = CONVERT(order_id_param USING utf8mb4);
    DELETE FROM orders WHERE order_id = converted_order_id;
END; &&
DELIMITER ;

-- Stored procedure untuk menyimpan data produk -- 9
DELIMITER &&
CREATE PROCEDURE addItems(
    IN product_id CHAR(9),
    IN product_name TEXT,
    IN stock INT,
    IN category_id CHAR(2),
    IN photo VARCHAR(255),
    IN user_prices DECIMAL(10,0),
    IN dealer_prices DECIMAL(10,0),
    IN spec_display VARCHAR(255),
    IN spec_ram VARCHAR(255),
    IN spec_proc VARCHAR(255),
    IN spec_gpu VARCHAR(255),
    IN spec_storage VARCHAR(255),
    IN spec_audio VARCHAR(255),
    IN spec_battery VARCHAR(255),
    IN spec_weight VARCHAR(255),
    IN spec_connectivity VARCHAR(255),
    IN spec_camera VARCHAR(255),
    IN spec_extandable_ram VARCHAR(255),
    IN spec_extandable_ssd VARCHAR(255),
    IN spec_dimension VARCHAR(255),
    IN description text(255),
    IN operating_system VARCHAR(255),
    IN antivirus VARCHAR(255)
)
BEGIN
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
END; &&
DELIMITER ;

-- Stored procedure untuk mengdelete product -- 10
DELIMITER &&
CREATE PROCEDURE deleteItems(
    IN product_id_param CHAR(9)
)
BEGIN
    DECLARE converted_id CHAR(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
    SET converted_id = CONVERT(product_id_param USING utf8mb4);
    DELETE FROM products WHERE product_id = converted_id;
END &&
DELIMITER ;

