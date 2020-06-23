
```SQL
-- 0. Get all the users
SELECT * FROM customers;
```

## Tasks
-- 1. Get all customers and their addresses.
SELECT first_name, last_name, addresses FROM customers 
JOIN addresses ON addresses.id = customers.id;

-- 2. Get all orders and their line items (orders, quantity and product).
SELECT orders, line_items from orders
JOIN line_items ON line_items.order_id = orders.id;

SELECT "products"."description", "line_items"."quantity", "orders"."id"
FROM "orders"
JOIN "products" ON "line_items"."product_id"="products"."id"
JOIN "line_items" ON "orders"."id"="line_items"."order_id";
-- 3. Which warehouses have cheetos?
SELECT warehouse.warehouse from warehouse
JOIN warehouse_product on warehouse.id = warehouse_product.warehouse_id
JOIN products on warehouse_product.product_id = products.id
WHERE products.description ilike '%Cheeto%' AND warehouse_product.on_hand >0;
-- 4. Which warehouses have diet pepsi?
SELECT warehouse.warehouse from warehouse
JOIN warehouse_product on warehouse.id = warehouse_product.warehouse_id
JOIN products on warehouse_product.product_id = products.id
WHERE products.description = 'diet pepsi' AND warehouse_product.on_hand !=0;
-- 5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT (customers.first_name, customers.last_name) AS customer_name, COUNT(orders.id) from orders
JOIN addresses on addresses.id = orders.address_id
JOIN customers on customers.id = addresses.customer_id
GROUP By customer_name; 

-- 6. How many customers do we have?
SELECT count(*) from customers;
-- 7. How many products do we carry?
SELECT count(*) from products;
-- 8. What is the total available on-hand quantity of diet pepsi?
SELECT SUM(warehouse_product.on_hand) from warehouse_product
JOIN products on products.id = warehouse_product.product_id 
WHERE products.description = 'diet pepsi';

-- STRETCH GOALS:
--9. How much was the total cost for each order?
SELECT orders.id, SUM(products.unit_price) from products
JOIN line_items on line_items.product_id = products.id
JOIN orders on orders.id = line_items.order_id 
group by orders.id
order by orders.id ASC;
--10. How much has each customer spent in total?

--11. How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).
