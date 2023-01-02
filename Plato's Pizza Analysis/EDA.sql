/* Checking each table */
SELECT * FROM dbo.pizzas

SELECT * FROM dbo.pizza_types

SELECT * FROM dbo.orders

SELECT * FROM dbo.order_details

/* Joining everything together */
SELECT * FROM dbo.pizzas piz
JOIN dbo.pizza_types pzt ON piz.pizza_type_id = pzt.pizza_type_id
JOIN dbo.order_details odt ON odt.pizza_id = piz.pizza_id
JOIN dbo.orders ord ON ord.order_id = odt.order_id

/* Getting the Total Revenue */
SELECT SUM(odt.quantity * piz.price) AS revenue
FROM order_details odt
JOIN pizzas piz ON odt.pizza_id = piz.pizza_id

/* Getting the total number of orders */
SELECT COUNT(order_id)
FROM orders

/* Getting the Average Order Value */
SELECT SUM(odt.quantity * piz.price) / COUNT(DISTINCT ord.order_id)
FROM order_details odt
JOIN pizzas piz ON odt.pizza_id = piz.pizza_id
JOIN orders ord on ord.order_id = odt.order_id

/* Getting the total number of pizzas sold */
SELECT SUM(quantity)
FROM order_details