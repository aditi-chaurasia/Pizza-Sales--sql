-- Retrieve the total number of orders placed.
select count(order_id) as total_orders from pizzahut.orders;


-- Calculate the total revenue generated from pizza sales.
select round(sum(order_details.quantity * pizzas.price),2) as revenue
from order_details 
join pizzas
on  order_details.pizza_id=pizzas.pizza_id;

-- Identify the highest-priced pizza
select pizza_id,price from pizzas
order by price DESC limit 1;
-- group by pizza_id

-- Identify the most common pizza size ordered.
select size,Count(order_details.order_id) from pizzas
join order_details
on pizzas.pizza_id=order_details.pizza_id
group by size;


-- List the top 5 most ordered pizza types along with their quantities.
select name ,sum(quantity) from pizza_types
join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on pizzas.pizza_id=order_details.pizza_id
group by name
order by sum(quantity) DESC limit 5;


-- Join the necessary tables to find the total quantity of each pizza category ordered.
select category ,sum(quantity) as quantity from pizza_types
join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details
on pizzas.pizza_id=order_details.pizza_id
group by category;

-- Determine the distribution of orders by hour of the day.

select hour(order_time), count(order_id) from orders
group by hour(order_time); 


-- Join relevant tables to find the category-wise distribution of pizzas.
select category,count(name) from pizza_types
group by category;


-- Group the orders by date and calculate the average number of pizzas ordered per day.
select avg(quantity)  as average_number_of_pizzas_ordered_per_day
from 
(select order_date,sum(quantity)  as quantity from orders
join order_details
on orders.order_id=order_details.order_id
group by order_date) as data;
