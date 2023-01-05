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

/* Category by number of orders */
SELECT pzt.category, SUM(odt.quantity) AS quantity
FROM pizza_types pzt
JOIN pizzas piz ON pzt.pizza_type_id = piz.pizza_type_id
JOIN order_details odt ON piz.pizza_id = odt.pizza_id
GROUP BY pzt.category
ORDER BY quantity DESC

/* Size by number of orders */
SELECT piz.size, SUM(odt.quantity) AS quantity
FROM pizzas piz 
JOIN order_details odt ON piz.pizza_id = odt.pizza_id
GROUP BY piz.size
ORDER BY quantity DESC

/* Top 5 Small Pizzas by Sales*/
SELECT TOP 5 pzt.name, SUM(odt.quantity * piz.price) AS revenue
FROM order_details odt
JOIN pizzas piz ON odt.pizza_id = piz.pizza_id
JOIN pizza_types pzt ON piz.pizza_type_id = pzt.pizza_type_id
WHERE piz.size = 'S'
GROUP BY pzt.name
ORDER BY revenue DESC