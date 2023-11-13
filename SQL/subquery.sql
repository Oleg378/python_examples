SELECT product_name, units_in_stock
FROM products
WHERE units_in_stock > (SELECT AVG(units_in_stock)
                        FROM products)
ORDER BY units_in_stock;

SELECT company_name, contact_name
FROM customers
WHERE EXISTS (SELECT customer_id FROM orders
            WHERE orders.customer_id = customers.customer_id
            AND freight BETWEEN 50 AND 100);

SELECT DISTINCT contact_name
FROM customers
WHERE customer_id = ANY (
    SELECT customer_id
    FROM orders
    JOIN order_details USING (order_id)
    WHERE quantity > 40
    );


-- 1. Display products:
--   quantity on sale must be less than the smallest average
--   quantity of products in order details (grouping by product_id).
--   the table must have columns product_name and units_in_stock.

SELECT product_name, units_in_stock
FROM products
WHERE units_in_stock < (SELECT AVG (quantity)
                        FROM order_details)
GROUP BY product_id;



--
-- 2. Display the total amount of freight orders for customer companies for orders:
-- The freight cost is greater than or equal to the average freight cost of all orders,
-- and the order's shipment date must be in the second half of July 1996.
-- The resulting table should have customer_id and freight_sum columns,
-- and the rows should be sorted by order freight amount.

--
-- Hint: tables can also be joined with subqueries
-- (after all, a subquery essentially forms a table)
--
-- 3. Write a query that returns the 3 highest value orders
-- that were created after September 1, 1997 inclusive and
-- were delivered to South American countries.
-- The total cost is calculated as the sum of the cost of the order parts - discount.
-- The resulting table should have columns:
-- customer_id, ship_country and order_price,
-- the rows should be sorted by order value in reverse order.
--
-- 4. Display all products (unique product names) of
-- which exactly 10 units are ordered