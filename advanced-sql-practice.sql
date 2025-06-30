
create table customers (
 id int primary key auto_increment,
 first_name varchar(50),
 last_name varchar(50)
);

create table orders (
 id int primary key,
 customer_id int null,
 order_date date,
 total_amount decimal(10, 2),
 foreign key (customer_id) references customers(id)
);

insert into customers (id, first_name, last_name) values
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Smith'),
(4, 'Bob', 'Brown');

insert into orders (id, customer_id, order_date, total_amount) values
(1, 1, '2023-01-01', 100.00),
(2, 1, '2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00),
(6, NULL, '2023-04-01', 100.00);

SELECT * FROM customers;
SELECT * FROM orders;

-- using GROUPBY to find the total amount spent by each customer
-- uses an aggregate function to specify how to combine the columns
SELECT customer_id, SUM(total_amount) 
AS total_spent
FROM orders
GROUP BY customer_id;

-- using the groupby clause to include another column in the select statement
SELECT customer_id, order_date, SUM(total_amount)
AS total_spent
FROM orders
GROUP BY customer_id, order_date;

-- filter results to only include orders >= 200
SELECT customer_id, SUM(total_amount)
AS total_spent
FROM orders
WHERE total_amount >= 200
GROUP BY customer_id;

-- filter by orders > 200
SELECT customer_id, SUM(total_amount)
AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 200;

-- inner join between customers and orders bases on customer id
SELECT orders.id, customers.first_name, 
customers.last_name, orders.order_date, orders.total_amount
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;

-- left join between customers and orders based on customer id
SELECT orders.id, customers.first_name, customers.last_name,
orders.order_date, orders.total_amount
FROM orders
LEFT JOIN customers ON orders.customer_id = customer_id;

-- subquery to return all orders where total amount is >= the avg total amount of all orders
SELECT id, order_date, total_amount
FROM orders
WHERE total_amount >= (SELECT AVG(total_amount) FROM orders); 

-- subquery for users with the last name Smith
SELECT id, order_date, total_amount, customer_id
FROM orders
WHERE customer_id IN (SELECT id FROM customers WHERE last_name = 'Smith');

-- table subquery to return all order date values from the order table 
SELECT order_date
FROM (SELECT id, order_date, total_amount FROM orders) AS order_summary;

-- groupby using count where customer count is >= 2
SELECT customer_id, COUNT(customer_id) AS customer_count
FROM orders
GROUP BY customer_id
HAVING customer_count >= 2;

-- group by using order date
SELECT customer_id, COUNT(*) AS order_count
FROM orders
WHERE order_date > '2023-02-01'
GROUP BY customer_id;

-- subquery
SELECT id, order_date, total_amount
FROM orders
WHERE total_amount >= (SELECT MIN(250) FROM orders);

-- subquery
SELECT id, order_date, customer_id
FROM orders
WHERE customer_id IN (SELECT id FROM customers WHERE order_date = '2023-04-01');

-- subquery
SELECT id, order_date, total_amount, customer_id
FROM orders
WHERE total_amount IN (SELECT id FROM customers WHERE total_amount = '100');