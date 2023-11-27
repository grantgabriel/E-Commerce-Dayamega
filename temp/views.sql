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
        user_id,
        description,
        time
    FROM
        reports
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
CREATE VIEW 
