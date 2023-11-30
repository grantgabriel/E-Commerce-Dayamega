-- View untuk laporan stok produk --> 1
CREATE VIEW stock_report AS
    SELECT
        product_id,
        product_name,
        stock,
        (SELECT
                COUNT(product_id)
            FROM
                orders
            WHERE
                product_id = p.product_id) AS sold_products,
        user_prices,
        dealer_prices
    FROM
        products p;

-- View untuk laporan bug yang belum terselesaikan--> 2
CREATE VIEW unresolved_bug_report AS
    SELECT
        report_id,
        u.name,
        u.email,
        description,
        time
    FROM
        reports r
        JOIN users u ON r.user_id = u.user_id 
    WHERE
        status = 'Unresolved';

-- View untuk pesanan yang belum terselesaikan--> 3
CREATE VIEW confirmed_order_delivery AS
    SELECT
        order_id,
        u.name,
        u.email,
        p.product_name,
        delivery_address,
        order_date
    FROM
        orders o
            JOIN products p ON o.product_id = p.product_id
            JOIN users u ON o.user_id = u.user_id
    WHERE
        status = 'Confirmed';

-- View untuk produk berdasarkan urutan kelarisan--> 4
CREATE VIEW product_by_popularity AS
    SELECT
        product_id,
        product_name,
        c.category,
        (SELECT
                COUNT(product_id)
            FROM
                orders
            WHERE
                product_id = p.product_id) AS sold_products
    FROM
        products p JOIN categories c ON p.category_id = c.category_id
    ORDER BY
        sold_products DESC;

-- View untuk produk yang stoknya sudah habis--> 5
CREATE VIEW empty_stock AS
    SELECT
        product_id,
        product_name,
        stock
    FROM
        products
    WHERE
        stock = 0;

-- View untuk produk yang stoknya diambang batas--> 6
CREATE VIEW treshold_stock AS
    SELECT
        product_id,
        product_name,
        stock
    FROM
        products
    WHERE
        stock > 0 AND stock < 5;

-- View untuk pesanan yang belum terkonfirmasi kepada penjual --> 7
CREATE VIEW unconfirmed_order_delivery AS
    SELECT
        order_id,
        u.name,
        p.product_name,
        delivery_address,
        total,
        order_date
    FROM
        orders o
            JOIN products p ON o.product_id = p.product_id
            JOIN users u ON o.user_id = u.user_id
    WHERE
        status IN ('Unconfirmed');

-- View untuk menampilkan semua data undelivered pada kurir tertentu --> 8

-- View untuk menggabungkan data log akun untuk admin --> 9
CREATE VIEW log_account AS
    SELECT 
        user_id, name, time, action
    FROM 
        log_customers_account
    UNION ALL
    SELECT 
        user_id, name, time, action
    FROM 
        log_couriers_account
    UNION ALL
    SELECT 
        user_id, name, time, action
    FROM 
        log_sales_account
    ORDER BY time DESC;
        
-- View untuk menggabungkan field-field dari log purchase --> 10
CREATE VIEW log_purchase_v AS
    SELECT
        l.order_id,
        u.name,
        p.product_name,
        l.total,
        l.time,
        l.action
    FROM
        log_purchase l
            JOIN users u ON u.user_id = l.user_id
            JOIN products p ON p.product_id = l.product_id
    ORDER BY time DESC;

-- View untuk menggabungkan field dari log product --> 
CREATE VIEW log_product_v AS 
    SELECT
        l.product_id,
        p.product_name,
        l.action,
        l.time,
        l.price
    FROM
        log_product l 
            JOIN products p ON p.product_id = l.product_id
    ORDER BY time DESC;


