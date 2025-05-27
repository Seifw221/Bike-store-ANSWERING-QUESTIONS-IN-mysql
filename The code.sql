use my_nti ;

SELECT * FROM brands ;
SELECT * FROM categories ; 
SELECT * FROM customers ;
SELECT * FROM order_items;
SELECT * FROM orders ; 
SELECT * FROM products ; 
SELECT * FROM staffs ;
SELECT * FROM stocks ;
SELECT * FROM stores;

-- 1
SELECT product_id, list_price
FROM order_items
ORDER BY list_price DESC
LIMIT 1;

-- 2
SELECT COUNT(customer_id)
FROM customers;


-- 3
SELECT COUNT(*)
FROM stores;


-- 4
SELECT order_id, SUM(list_price * quantity * (1 - discount)) AS total_price
FROM order_items
GROUP BY order_id;

-- 5
SELECT s.store_name, SUM(oi.list_price * oi.quantity * (1 - oi.discount)) AS total_revenue
FROM stores as s
JOIN orders as  o ON s.store_id = o.store_id
JOIN order_items as oi ON o.order_id = oi.order_id
GROUP BY s.store_name;

-- 6
SELECT c.category_name, SUM(oi.quantity) AS total_quantity_sold
FROM categories as c
JOIN products as p ON c.category_id = p.category_id
JOIN order_items as  oi ON p.product_id = oi.product_id
GROUP BY c.category_name
ORDER BY total_quantity_sold DESC
LIMIT 1;

-- 7 
SELECT c.category_name, SUM(oi.quantity) AS total_quantity_sold
FROM categories as c
JOIN products as p ON c.category_id = p.category_id
JOIN order_items as  oi ON p.product_id = oi.product_id
GROUP BY c.category_name
ORDER BY total_quantity_sold asc
LIMIT 1;

-- 8 
SELECT p.product_name as bike_name, SUM(oi.quantity) AS total_quantity_sold
FROM products as p
JOIN order_items as oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold ASC
limit 1;



-- 9 
SELECT first_name, last_name
FROM customers
WHERE customer_id = 259;


-- 10
SELECT p.product_name, o.order_date, o.order_status
FROM orders as o
JOIN order_items as  oi ON o.order_id = oi.order_id
JOIN products as p ON oi.product_id = p.product_id
WHERE o.customer_id = 259;

-- 11
SELECT st.first_name AS staff_first_name, st.last_name AS staff_last_name, s.store_name
FROM orders as o
JOIN staffs as  st ON o.staff_id = st.staff_id
JOIN stores as s ON o.store_id = s.store_id
WHERE o.customer_id = 259;

-- 12
SELECT COUNT(staff_id)
FROM staffs;

SELECT first_name, last_name
FROM staffs
WHERE manager_id IS NULL;

-- 13
SELECT b.brand_name, sum(oi.quantity)as most_liked
FROM brands as b
JOIN products as p ON b.brand_id = p.brand_id
JOIN order_items as oi  ON p.product_id = oi.product_id
GROUP BY b.brand_name
order by most_liked desc  limit 1;


select b.brand_name,
count(*) as most_liked
from products p 
join brands as b on b.brand_id = p.brand_id 
join order_items as oi on p.product_id = oi.product_id
group by b.brand_id,b.brand_name
ORDER BY most_liked DESC
LIMIT 1;

-- 14
SELECT COUNT(*)
FROM categories;

SELECT c.category_name, sum(oi.quantity)as least_liked
FROM categories as c
JOIN products as p ON c.category_id = p.category_id
JOIN order_items as oi ON p.product_id = oi.product_id
GROUP BY c.category_name
ORDER BY least_liked ASC
LIMIT 1;



-- 15  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
select s.store_name,p.product_name,st.quantity
from stores as s
join stocks AS st on s.store_id=st.store_id
join products as p on st.product_id=p.product_id
join brands as b on p.brand_id=b.brand_id
where b.brand_name='Electra' 
order by st.quantity desc
LIMIT 9 ;

-- 16 
SELECT state, SUM(oi.list_price * oi.quantity * (1 - oi.discount)) AS total_sales
FROM customers  c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY state
ORDER BY total_sales DESC
LIMIT 1;


-- 17 
SELECT p.product_id,p.list_price * (1 - oi.discount) AS discounted_price
FROM products as p
JOIN order_items as oi ON p.product_id = oi.product_id
WHERE oi.product_id = 259;

-- 18
SELECT p.product_id , p.product_name, sum(oi.quantity)as total_quantity , oi.list_price, c.category_name, p.model_year, b.brand_name
FROM products as  p
JOIN order_items as oi ON p.product_id = oi.product_id
JOIN categories as c ON p.category_id = c.category_id
JOIN brands as b ON p.brand_id = b.brand_id
WHERE p.product_id = 44
group by p.product_id , p.product_name, oi.list_price, c.category_name, p.model_year, b.brand_name;


-- 19 
SELECT distinct zip_code
FROM customers
WHERE state = 'CA';


-- 20
SELECT COUNT(DISTINCT state)
FROM customers;

-- 21 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT c.category_name,COUNT(oi.quantity) AS total_quantity,  o.order_date
FROM categories AS c
JOIN products as p
ON c.category_id = p.category_id
JOIN order_items as oi
ON p.product_id = oi.product_id
JOIN orders as o
ON oi.order_id = o.order_id
WHERE o.order_date >= DATE_SUB((SELECT MAX(order_date) FROM orders), INTERVAL 8 MONTH)
AND c.category_name = 'Children Bicycles'
GROUP BY c.category_name, o.order_date;



-- 22
SELECT o.shipped_date
FROM orders as o
WHERE o.customer_id = 523;


-- 23 
SELECT COUNT(*) as pending_orders
FROM orders
WHERE order_status =1 ;

-- 24 
SELECT p.product_name,c.category_name, b.brand_name
FROM products as p
JOIN categories as c ON p.category_id = c.category_id
JOIN brands as b ON p.brand_id = b.brand_id
WHERE p.product_name = 'Electra white water 3i - 2018';


