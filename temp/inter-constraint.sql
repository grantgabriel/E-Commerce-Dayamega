-- Constraint untuk account customers -> user
ALTER TABLE customers
ADD CONSTRAINT customer_user_CC
FOREIGN KEY (user_id)
REFERENCES users(user_id)
ON UPDATE CASCADE ON DELETE CASCADE;

-- Constraint untuk account sales -> user
ALTER TABLE salesman
ADD CONSTRAINT sales_user_CC
FOREIGN KEY (user_id)
REFERENCES users(user_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Constraint untuk account courier -> user
ALTER TABLE couriers
ADD CONSTRAINT courier_user_CC
FOREIGN KEY (user_id)
REFERENCES users(user_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Constraint untuk users -> orders
ALTER TABLE orders 
ADD CONSTRAINT orders_users_NR
FOREIGN KEY (user_id)
REFERENCES users(user_id)
ON DELETE SET NULL
ON UPDATE RESTRICT;