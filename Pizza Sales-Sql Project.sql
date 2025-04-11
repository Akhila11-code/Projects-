create database pizzahut;
use pizzahut;

create table orders(
order_id int primary key not null,
order_date date not null,
order_time time not null
);

#1 Retrieve the total number of orders placed.

SELECT COUNT(order_id) AS total_orders FROM orders;

#2 calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
#3 Identify the highest priced pizza .

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

#4 Identify the most common pizza size ordered.

SELECT 
    pizzas.size,
  COUNT(order_details.order_details_id) AS order_count
FROM
    pizzas
    JOIN 
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

#5 List the top 5 most ordered pizza types along with their quantities.

select pizza_types.name,
sum(order_details.quantity) as quantity
from pizza_types join pizzas 
on pizza_types.pizza_type_id = pizzas.pizza_type_id 
join order_details 
on order_details.pizza_id = pizzas.pizza_id 
group by pizza_types.name order by quantity desc limit 5;

#6 Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

#7 Determine the distribution of orders by hour of the day.

select hour(order_time) as hour, count(order_id) as order_count from orders
group by hour(order_time);

#8 Join relevant tables to find the category-wise distribution of pizzas.

select category, count(name) from pizza_types 
group by category;

#9 Group the orders by date and calculate the average number of pizzas ordered per day.

  select round(avg(quantity),0) from 
  (select orders.order_date, sum(order_details.quantity) as quantity
  from orders join order_details 
  on orders.order_id = order_details.order_id
  group by orders.order_date) as order_quantity;
  
 #10 Determine the top 3 most ordered pizza types based on revenue.
 select pizza_types.name,
sum( order_details.quantity * pizzas.price) as revenue
 from pizza_types join pizzas 
 on pizzas.pizza_type_id = pizza_types.pizza_type_id 
 join order_details
 on order_details.pizza_id = pizzas.pizza_id
 group by pizza_types.name
 order by revenue desc limit 3;
 
 #11 Calculate the percentage contribution of each pizza type to total revenue.

 select pizza_types.category,
(sum( order_details.quantity * pizzas.price) / (SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales 
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id) )*100 as revenue
 from pizza_types join pizzas 
 on pizzas.pizza_type_id = pizza_types.pizza_type_id 
 join order_details
 on order_details.pizza_id = pizzas.pizza_id
 group by pizza_types.category
 order by revenue desc;