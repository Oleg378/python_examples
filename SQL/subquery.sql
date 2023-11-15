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
ORDER BY units_in_stock DESC;

SELECT product_name, units_in_stock
FROM products
WHERE units_in_stock < ALL (SELECT AVG (quantity)
                        FROM order_details
                        GROUP BY product_id)
ORDER BY units_in_stock DESC;

-- SELECT AVG (quantity)
-- FROM order_details;
--
-- SELECT AVG (quantity)
-- FROM order_details
-- GROUP BY product_id;

--
-- 2. Display the total amount of freight orders for customer companies for orders:
-- The freight cost is greater than or equal to the average freight cost of all orders,
-- and the order's shipment date must be in the second half of July 1996.
-- The resulting table should have customer_id and freight_sum columns,
-- and the rows should be sorted by order freight amount.

SELECT sum_table.customer_id, SUM(freight) as freight_sum
FROM orders as sum_table
JOIN (SELECT customer_id, AVG (freight) as freight_avg
      FROM orders
      GROUP BY customer_id) avg_table
ON sum_table.customer_id = avg_table.customer_id
--USING (customer_id)
WHERE freight > freight_avg AND shipped_date BETWEEN '1996-07-16' AND '1996-07-31'
GROUP BY sum_table.customer_id
ORDER BY freight_sum DESC;

-- SELECT customer_id, AVG (freight) as freight_avg
-- FROM orders
-- GROUP BY customer_id;

--
-- Hint: tables can also be joined with subquery


-- 3. Write a query that returns the 3 highest value orders
-- that were created after September 1, 1997 inclusive and
-- were delivered to South American countries.
-- The total cost is calculated as the sum of the cost of the order parts - discount.
-- The resulting table should have columns:
-- customer_id, ship_country and order_price,
-- the rows should be sorted by order value in reverse order.

SELECT customer_id, ship_country, order_price
FROM orders as orders_table
JOIN (SELECT order_id, SUM(unit_price*quantity*(1-discount)) as order_price
      FROM order_details
      GROUP BY order_id) as details_table
USING (order_id)
WHERE order_date >= '1997-09-01' AND ship_country IN ('Brazil', 'Mexico', 'Venezuela', 'Argentina')
ORDER BY order_price DESC
LIMIT 3;
--Brazil Mexico Venezuela Argentina

--
-- 4. Display all products (unique product names) of
-- which exactly 10 units are ordered

SELECT product_id
FROM order_details
WHERE quantity = 10
GROUP BY product_id;

SELECT product_name
FROM products
WHERE product_id in (SELECT product_id, quantity
                    FROM order_details
                    WHERE quantity = 10)
ORDER BY product_name;

--the same:

SELECT distinct product_name, quantity
from products
JOIN order_details using (product_id)
where quantity = 10

