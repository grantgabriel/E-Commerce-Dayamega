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