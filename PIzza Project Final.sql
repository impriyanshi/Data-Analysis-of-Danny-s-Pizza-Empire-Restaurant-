# Table: Runners 
Create table runners(
runner_id integer,
registration_date date
)

select * from runners;

insert into runners(runner_id, registration_date) values
  (1, '2021-01-01runnersrunners'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');
  
  
  
# Table: Customer Orders
CREATE TABLE customer_orders (
  order_id INTEGER,
  customer_id INTEGER,
  pizza_id INTEGER,
  exclusions VARCHAR(4),
  extras VARCHAR(4),
  order_time TIMESTAMP
)

Select * from customer_orders;

INSERT INTO customer_orders
  (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');
  
  
  
  # Table: Runner Orders
  CREATE TABLE runner_orders (
  order_id INTEGER,
  runner_id INTEGER,
  pickup_time VARCHAR(19),
  distance VARCHAR(7),
  duration VARCHAR(10),
  cancellation VARCHAR(23)
)

select * from runner_orders;

INSERT INTO runner_orders
  (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES
(
  '1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');
  
  
  
# Table: Pizza names
CREATE TABLE pizza_names (
  pizza_id INTEGER,
  pizza_name TEXT
)

select * from pizza_names;

INSERT INTO pizza_names
  (pizza_id, pizza_name)
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');
  
  
  

# Table: Pizaa recipes
CREATE TABLE pizza_recipes (
  pizza_id INTEGER,
  toppings TEXT
)

select * from pizza_recipes;

INSERT INTO pizza_recipes
  (pizza_id, toppings)
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');
  


# Table: Pizza Toppings
CREATE TABLE pizza_toppings (
  topping_id INTEGER,
  topping_name TEXT
);

select * from pizza_toppings;

INSERT INTO pizza_toppings
  (topping_id, topping_name)
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');
  
  
  
  
  

  # INSPECT THE DATA
  
  # To list all the tables present in the database
  show tables;
  
  # Show all the contents of all the tables
  select * from runners;
  Select * from customer_orders;
  select * from runner_orders;
  select * from pizza_names;
  select * from pizza_recipes;
  select * from pizza_toppings;
  
  
  

  # DATA CLEANING
  # The tables(customer_orders and runner_orders) have ‘null’ and NULL or NA 
  # which needs to be cleaned before using them for analysis.
  # Thus, the ‘null’ and NULL or NA value in each table were replaced by empty or ’ ’
  UPDATE customer_orders set exclusions = ' ' WHERE exclusions = 'null' or exclusions IS NULL;
  UPDATE customer_orders SET extras = '' WHERE extras = 'null' or extras IS NULL;
  Select * from customer_orders;
  
  UPDATE runner_orders SET pickup_time = '' WHERE pickup_time = 'null' or pickup_time IS NULL;
  UPDATE runner_orders SET distance = '' WHERE distance = 'null' or distance IS NULL;
  UPDATE runner_orders SET duration = '' WHERE duration = 'null' or duration IS NULL;
  UPDATE runner_orders SET cancellation = '' WHERE cancellation = 'null' or cancellation IS NULL;
  Select * from runner_orders;
  
  
  
  
# QUESTIONS
  
# 1. How many pizzas were ordered?
  select count(order_id) as `Total Pizzas Ordered` from customer_orders;
  
  
# 2. How many unique customer orders were made?
  select count(distinct(order_id)) as `Total Unique Customer Orders` from customer_orders;
  
  
# 3. How many successful orders were delivered by each runner?
  select runner_id, count(order_id) from runner_orders where pickup_time <> '' group by runner_id;
  
  
# 4. How many of each type of pizza was delivered?
  select pn.pizza_name, count(co.order_id) as `Pizzas Delivered` from 
  customer_orders as co join runner_orders as ro on co.order_id = ro.order_id
  join pizza_names as pn on pn.pizza_id = co.pizza_id
  where pickup_time <> ''
  group by pn.pizza_name;
  
  
# 5. How many Vegetarian and Meatlovers were ordered by each customer?
  select customer_id, pn.pizza_name, count(co.order_id) as `Pizzas Delivered` from 
  customer_orders as co join runner_orders as ro on co.order_id = ro.order_id
  join pizza_names as pn on pn.pizza_id = co.pizza_id
  where pickup_time <> ''
  group by pn.pizza_name, customer_id order by customer_id;
  
  
  
# 6. What was the maximum number of pizzas delivered in a single order?
  With max_num_pizzas as (
  select count(co.pizza_id) as pizza_count, co.order_id 
  from customer_orders as co 
  join runner_orders as ro
  on ro.order_id = co.order_id
  where ro.pickup_time <> '' group by co.order_id
  )
  select max(pizza_count) as Maximum_Pizza_Count from max_num_pizzas;
  
  

# 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
   Select co.customer_id ,
   sum(case when co.exclusions = '' and co.extras = '' then 1 else 0 end) as orders_no_change,
   sum(case when co.exclusions <> '' or co.extras <> '' then 1 else 0 end) as orders_change
   from customer_orders as co 
   join runner_orders as ro on co.order_id = ro.order_id
   where duration <> ''
   group by co.customer_id
   order by co.customer_id;
   

# 8. How many pizzas were delivered that had both exclusions and extras?
  select count(co.order_id) 
  from customer_orders as co 
  join runner_orders as ro 
  on co.order_id = ro.order_id
  where pickup_time <> '' and  exclusions <> ''and extras <> '';


# 9. What was the total volume of pizzas ordered for each hour of the day?
  select count(pizza_id), hour(order_time) as hour_order_time
  from customer_orders group by hour_order_time order by hour_order_time;


# 10. What was the volume of orders for each day of the week?
  select count(pizza_id), dayofweek(order_time) as day_order_time
  from customer_orders group by day_order_time order by day_order_time;
  


  

  
  
  
  
  
  
  
  
  
  