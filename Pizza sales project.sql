
select * from pizzas

select * from order_details


-- Retrieve the total number of orders placed.

SELECT COUNT(order_id) as Total_orders_placed from orders 



-- Calculate the total revenue generated from pizza sales.
                                                   
select round(sum(order_details.quantity * pizzas.price ),2) as total_generated_revenue 
from order_details
join pizzas
on order_details.pizza_id = pizzas.pizza_id


-- Identify the highest-priced pizza.

SELECT TOP 1 pizza_types.name as Pizza_name , ROUND(pizzas.price, 2) AS Highest_pizza_price
FROM pizza_types
JOIN pizzas 
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC;


SELECT TOP 1 pizza_types.name as Pizza_name 
FROM pizza_types
JOIN pizzas 
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC;

select * from order_details
select * from orders
select * from pizza_types
select * from pizzas



--- Identify the most common pizza size ordered.

select  top 1 pizzas.size as pizza_size , count(order_details.quantity) as Total_pizzas_ordered 
from pizzas 
join order_details
on pizzas.pizza_id=order_details.pizza_id
group by pizzas.size
order by  Total_pizzas_ordered desc 



--- List the top 5 most ordered pizza types 
--- along with their quantities

select TOP 5 pizza_types.name as Pizza_name , SUM(order_details.quantity) as Pizzas_ordered 
from pizza_types 
join pizzas 
on pizza_types.pizza_type_id = pizzas.pizza_type_id 
join order_details
on pizzas.pizza_id = order_details.pizza_id
GROUP BY  pizza_types.name 
ORDER BY Pizzas_ordered DESC 


-- Join the necessary tables 
-- to find the total quantity of each pizza category ordered.

select pizza_types.category as Pizzas_Category , sum(order_details.quantity) as Pizzas_Ordered 
from pizza_types
join pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
JOIN order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category
ORDER BY Pizzas_Ordered  DESC 


--- Determine the distribution of orders by hour of the day.

SELECT DATEPART(HOUR, time) AS hour_of_day, COUNT(order_id) AS Order_count
FROM orders
GROUP BY DATEPART(HOUR, time);


--- Join relevant tables 
--- to find the category-wise distribution of pizzas.
--- to find total count of pizzas in each category 

select category as Pizza_Category , count(name) as Pizzas_Count
from pizza_types
GROUP BY  category



--- Group the orders by date and 
--- calculate the average number of pizzas ordered per day.

select AVG(Order_placed) as Avg_orders_per_day 
from ( 
select orders.date , sum(order_details.quantity) as Order_placed
from orders
join order_details on orders.order_id = order_details.order_id 
group by orders.date ) as Orders_quantity 


--- Determine the top 3 most ordered pizza types based on revenue.

select top 3 pizza_types.name as Pizza_Names , sum(order_details.quantity * pizzas.price) as Revenue 
from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name 
order by Revenue desc 


--- Calculate the percentage contribution of each pizza type to total revenue.

SELECT pizza_types.category,
       ROUND(SUM(order_details.quantity * pizzas.price) / (
           SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2) as Total_price 
           FROM order_details 
           JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id
       ) * 100, 2) as Revenue
FROM pizza_types 
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY Revenue DESC;


--- Analyze the cumulative revenue generated over time and time means date 
1) 

select orders.date , 
round(SUM(order_details.quantity*pizzas.price),2) AS Revenue 
from order_details join pizzas on order_details.pizza_id = pizzas.pizza_id
join orders on order_details.order_id = orders.order_id
group by orders.date 


--- Analyze the cumulative revenue generated over time and time means date 

SELECT 
    order_date, 
    SUM(Revenue) OVER (ORDER BY order_date) AS Cum_Revenue  
FROM 
    (
    SELECT 
        orders.date AS order_date, 
        ROUND(SUM(order_details.quantity * pizzas.price), 2) AS Revenue 
    FROM 
        order_details 
    JOIN 
        pizzas ON order_details.pizza_id = pizzas.pizza_id
    JOIN 
        orders ON order_details.order_id = orders.order_id
    GROUP BY 
        orders.date
    ) AS Sales order by order_date 


	SELECT * FROM PIZZAS 

	select count(pizza_id) as Total_Quantity 
	from pizzas

-- 2.	Write a query to add/delete multiple cols in a table

-- to add columns 

alter table pizzas 
add dlvry_boy varchar(50) , contact float(50) 

-- to drop columns 

ALTER TABLE pizzas 
DROP COLUMN dlvry_boy,contact;

---- 3.	Write a query to find out the 2nd highest price pizza in a table in sql server 

select * from pizzas 
order by price desc 
offset 1 row 
fetch next 1 row only 

--- 4.	Find max price without using ORDER BY

select max(price) as Highest_pizza_price from pizzas



SELECT * FROM pizza_types

CREATE TABLE employees (
    id INT PRIMARY KEY,
    Emp_name VARCHAR(50),
    M_name VARCHAR(50),
    manager_id INT
);

INSERT INTO employees (id, Emp_name, M_name, manager_id)
VALUES
    (1, 'John', 'Doe', NULL),        -- Manager
    (2, 'Jane', 'Smith', 1),          -- Reports to John Doe
    (3, 'Alice', 'Johnson', 1),       -- Reports to John Doe
    (4, 'Michael', 'Brown', 1),       -- Reports to John Doe
    (5, 'Emily', 'Davis', 3),         -- Reports to Alice Johnson
    (6, 'William', 'Wilson', 3),      -- Reports to Alice Johnson
    (7, 'Sarah', 'Martinez', 2),      -- Reports to Jane Smith
    (8, 'David', 'Anderson', 2),      -- Reports to Jane Smith
    (9, 'Olivia', 'Taylor', 4),       -- Reports to Michael Brown
    (10, 'James', 'Jones', 4);        -- Reports to Michael Brown


SELECT * FROM employees

--- 5.	Find managers of all employees ---- use of self join 

select e1.Emp_name , e2.M_name from employees e1
join employees e2 
on e2.manager_id = e1.id


--- 6.	Use of wild cards
select * from pizzas