SELECT product_name, company_name, units_in_stock
FROM products
INNER JOIN suppliers
ON products.supplier_id = suppliers.supplier_id
ORDER BY units_in_stock DESC;

SELECT SUM(units_in_stock), category_name
FROM products
JOIN categories
--ON products.category_id = categories.category_id
USING (category_id)
GROUP BY category_name
ORDER BY SUM(units_in_stock) DESC
LIMIT 5;

SELECT SUM(unit_price*units_in_stock), category_name
FROM products
JOIN categories
--ON products.category_id = categories.category_id
USING (category_id)
WHERE discontinued !=1
GROUP BY category_name
HAVING SUM(unit_price*units_in_stock) > 10000
ORDER BY SUM(unit_price*units_in_stock) DESC;


-- An example of usage contraction:
SELECT category_id, SUM(unit_price * units_in_stock) AS total_price
FROM products
WHERE discontinued != 1
GROUP BY category_id
HAVING SUM(unit_price * units_in_stock) > 5000
ORDER BY total_price;





