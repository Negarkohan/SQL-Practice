/*
===============================================
 Author:  Negar Kohansal
 Purpose: Demonstration of SQL Transaction for processing an order with stock check.
 ===============================================
*/

BEGIN TRANSACTION;

-- Step 1: Check if the product is in stock
IF (SELECT stock_quantity FROM products WHERE product_id = 101) < 1
BEGIN
    -- If no stock, cancel the transaction
    PRINT 'Order cannot be processed: Out of stock';
    ROLLBACK;
END
ELSE
BEGIN
    -- Step 2: Reduce stock by 1
    UPDATE products
    SET stock_quantity = stock_quantity - 1
    WHERE product_id = 101;

    -- Step 3: Insert the order record
    INSERT INTO orders (order_id, product_id, customer_id, quantity, order_date)
    VALUES (1001, 101, 501, 1, GETDATE());

    -- Step 4: Commit all changes permanently
    COMMIT;

    PRINT 'Order processed successfully';
END
