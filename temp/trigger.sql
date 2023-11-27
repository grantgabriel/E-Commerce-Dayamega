-- Trigger saat pembeli register akun --> 1, 
DELIMITER &&
CREATE TRIGGER regist_customers_acc AFTER INSERT ON users FOR EACH ROW
BEGIN 
	IF(NEW.level_user = 'Users') THEN
		INSERT INTO log_customers_account VALUES (NEW.user_id, NEW.name, NOW(), 'CREATED');
	END IF;
END; &&
DELIMITER ;

-- Trigger saat pembeli didelete akun -- 2, 3
DELIMITER &&
CREATE TRIGGER delete_customers_acc BEFORE DELETE ON users FOR EACH ROW
BEGIN 
	IF(OLD.level_user = 'Users') THEN
		INSERT INTO log_customers_account VALUES (OLD.user_id, OLD.name, NOW(), 'DELETED');
	END IF;
END; &&
DELIMITER ;

-- Trigger saat penjual menambahkan produk -- 4
DELIMITER &&
CREATE TRIGGER add_product AFTER INSERT ON products FOR EACH ROW
BEGIN
	INSERT INTO log_product VALUES (NEW.product_id, 'CREATED', NOW(), NEW.dealer_prices);
END; &&
DELIMITER ;

-- Trigger saat penjual menghapus produk -- 5
DELIMITER &&
CREATE TRIGGER delete_product BEFORE DELETE ON products FOR EACH ROW
BEGIN
	INSERT INTO log_product VALUES (OLD.product_id, 'DELETED', NOW(), OLD.dealer_prices);
END; &&
DELIMITER ;

-- Trigger saat penjual mengupdate harga produk -- 6
DELIMITER &&
CREATE TRIGGER update_product_price AFTER UPDATE ON products FOR EACH ROW
BEGIN
	INSERT INTO log_product VALUES (NEW.product_id, 'UPDATED', NOW(), NEW.dealer_prices);
END; &&
DELIMITER ;

-- Trigger penjual menambah kategori -- 7
DELIMITER &&
CREATE TRIGGER append_category AFTER INSERT ON categories FOR EACH ROW
BEGIN
	INSERT INTO log_category VALUES (NEW.category_id, NEW.category, 'CREATED', NOW());
END; &&
DELIMITER ;

-- Trigger penjual mendelete kategori -- 8
DELIMITER &&
CREATE TRIGGER pop_category BEFORE DELETE ON categories FOR EACH ROW
BEGIN
	INSERT INTO log_category VALUES (OLD.category_id, OLD.category, 'DELETED', NOW());
END; &&
DELIMITER ;

-- Trigger ketika pembeli membeli sebuah barang -- 9
DELIMITER &&
CREATE TRIGGER cust_purchase AFTER INSERT ON orders FOR EACH ROW
BEGIN
	DECLARE total DECIMAL(10, 2);

	SELECT dealer_prices, INTO total FROM products WHERE NEW.product_id = product_id;

	INSERT INTO log_purchase VALUES(NEW.order_id, NEW.user_id, NEW.product_id, total, NOW(), 'PURCHASED');
END; &&
DELIMITER ;

-- Trigger ketika pembeli menghapus sebuah barang -- 10, 11
DELIMITER &&
CREATE TRIGGER delete_purchase BEFORE DELETE ON orders FOR EACH ROW
BEGIN
	DECLARE total DECIMAL(10, 2);

	SELECT dealer_prices INTO total FROM products WHERE OLD.product_id = product_id;

	INSERT INTO log_purchase VALUES(OLD.order_id, OLD.user_id, OLD.product_id, NULL, NOW(), 'DELETED');
END; &&
DELIMITER ;

-- Trigger ketika status pesanan di update -- 12, 13
DELIMITER &&
CREATE TRIGGER update_purchase_status BEFORE UPDATE ON orders FOR EACH ROW
BEGIN
	DECLARE actioner VARCHAR(255);
	
	IF NEW.status = 'Confirmed' THEN
		SET actioner = 'Seller';
	ELSE
		SET actioner = 'Courier';
	END IF;

	INSERT INTO log_order_status VALUES(NEW.order_id, 'Updated By', NOW(), actioner);
END; &&
DELIMITER ;

-- Trigger saat sales akun dibuat -- 14
DELIMITER &&
CREATE TRIGGER regist_sales_acc AFTER INSERT ON users FOR EACH ROW
BEGIN
	IF(NEW.level_user = 'Sales') THEN
		INSERT INTO log_sales_account VALUES (NEW.user_id, NEW.name, NOW(), 'CREATED');
	END IF;
END; &&
DELIMITER ;

-- Trigger saat sales akun dihapus -- 15
DELIMITER &&
CREATE TRIGGER delete_sales_acc BEFORE DELETE ON users FOR EACH ROW
BEGIN
	IF(OLD.level_user = 'Sales') THEN
		INSERT INTO log_sales_account VALUES (OLD.user_id, OLD.name, NOW(), 'DELETED');
	END IF;
END; &&
DELIMITER ;

-- Trigger saat akun kurir dibuat -- 16
DELIMITER &&
CREATE TRIGGER regist_courier_acc AFTER INSERT ON users FOR EACH ROW
BEGIN
	IF(NEW.level_user = 'Courier') THEN
		INSERT INTO log_couriers_account VALUES (NEW.user_id, NEW.name, NOW(), 'CREATED');
	END IF;
END; &&
DELIMITER ;

-- Trigger saat akun kurir dihapus -- 17, 18
DELIMITER &&
CREATE TRIGGER delete_couriers_acc BEFORE DELETE ON users FOR EACH ROW
BEGIN
	IF(OLD.level_user = 'Courier') THEN
		INSERT INTO log_couriers_account VALUES (OLD.user_id, OLD.name, NOW(), 'DELETED');
	END IF;
END; &&
DELIMITER ;

-- Trigger saat akun admin dihapus -- 19
DELIMITER &&
CREATE TRIGGER delete_admin_acc BEFORE DELETE ON users FOR EACH ROW
BEGIN
	IF(OLD.level_user = 'Admin') THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Cannot delete admin user.';
	END IF;
END; &&
DELIMITER ;

-- Trigger update stock otomatis -- 20
DELIMITER &&
CREATE TRIGGER auto_update_stock AFTER INSERT ON orders FOR EACH ROW
BEGIN
    DECLARE before_stock INT;
    DECLARE after_stock INT;

    SELECT stock INTO before_stock FROM products WHERE product_id = NEW.product_id;

    SET after_stock = before_stock - 1;

    UPDATE products SET stock = after_stock WHERE product_id = NEW.product_id;
END; &&
DELIMITER ;

-- Trigger validasi stock otomatis -- 21
DELIMITER &&
CREATE TRIGGER auto_check_stock BEFORE INSERT ON orders FOR EACH ROW
BEGIN
	DECLARE current_stock INT;

    SELECT stock INTO current_stock FROM products WHERE product_id = NEW.product_id;

	IF current_stock <= 0 THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Stocks are empty!';
	END IF;
END; &&
DELIMITER ;

-- 