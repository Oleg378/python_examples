-- 1. Find customers and employees serving orders such that: both
-- customers and employees are from the city of London, and delivery is
-- carried out by Speedy Express. Display the customer's company and employee's
-- full name.

SELECT customers.company_name,
       first_name || ' ' || last_name as empl, -- or use CONCAT(first_name, ' ', last_name)
       shippers.company_name
FROM customers
JOIN orders USING (customer_id)
JOIN employees empl USING (employee_id)
JOIN shippers ON orders.ship_via = shippers.shipper_id
WHERE customers.city = 'London' AND empl.city = 'London' AND shippers.company_name = 'Speedy Express';

-- SELECT *
-- FROM shippers;


-- 2. Find active (see the discontinued field) products from
-- the Beverages and Seafood categories, of which there are
-- less than 20 units on sale. Display the name of the products,
-- the number of units on sale, the name of the supplier's contact
-- and his phone number.

SELECT product_name, units_in_stock, suppliers.contact_name, suppliers.phone
FROM products
JOIN categories USING (category_id)
JOIN suppliers USING (supplier_id)
WHERE discontinued != 1 AND category_name IN ('Beverages', 'Seafood') AND units_in_stock < 20;


-- 3. Find customers who haven't made an any order.
-- Print customer name and order_id.
SELECT customers.company_name, order_id
FROM customers
LEFT JOIN orders USING (customer_id)
WHERE order_id IS null;


-- 4. Rewrite the previous query using a symmetrical
-- type of join (LEFT <--> RIGHT).

SELECT customers.company_name, order_id
FROM orders
RIGHT JOIN customers USING (customer_id)
WHERE order_id IS null;
