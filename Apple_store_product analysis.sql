SELECT * FROM products;					
SELECT * FROM customers;
SELECT * FROM orders;


-- Q1. Find out total sales per year  ?

select YEAR(o.order_date) as order_year,
sum(o.quantity_ordered) as total_quantity_sold,
sum(price*o.quantity_ordered) as toatal_price
from orders as o
join products as p
on 
o.product_id = p.product_id
group by year(order_date)


-- Q.2 Best selling products and their sale?

select p.product_name,
sum(o.quantity_ordered) as total_quantity_sold,
sum(p.price* o.quantity_ordered) as total_sales
from orders as o
join 
products as p 
on
o.product_id = p.product_id
group by p.product_name 
order by total_sales desc
-- Q.3 How many customer does we have ?

select count(distinct customer_id) as total_no_cutomer 
from customers

-- Q.4 Find out total orders placed by each customer 
select o.customer_id,
c.customer_name ,
count(o.quantity_ordered) as total_no_order
 from orders as o
 join 
 customers as c
 on
 o.customer_id = c.customer_id
 group by o.customer_id,c.customer_name
 order by o.customer_id desc



SELECT customer_id, COUNT(quantity_ordered) as total_no_order
FROM orders
GROUP BY customer_id
ORDER BY customer_id DESC;


-- Q.5 Find out total no of orders 

select count(*) from orders



-- Q.6 Find out best selling month and compare with previous month 
-- Step 1: CTE to aggregate sales data by month
with Monthlysales as (
select year(o.order_date) as Years,
	   MONTH(o.order_date) as months,
	   sum(p.price *quantity_ordered) as total_sales
	   from orders as o
	   join
	   products as p
	   on 
	   o.product_id = o.product_id
	   group by year(o.order_date),MONTH(o.order_date)
	    
	   ),
-- Step 2: CTE to find the best-selling month
Bestsellingmonth as (
select top 10
years,months,total_sales
from Monthlysales
order by total_sales )

-- Step 3: Join the CTEs to compare with the previous month

select 
bsm.years,
bsm.months,
bsm.total_sales as curerrentmonthsales,
prev.total_sales as previousmonthsales,
(bsm.total_sales - prev.total_sales) as differnce
	
from 
Bestsellingmonth as bsm
lEFT JOIN 
    MonthlySales prev 
ON 
    bsm.Years = prev.Years 
    AND bsm.Months = prev.Months + 1;


-- Q.7 Count of payment cash vs credit card?	

select payment_type ,count( payment_type) as total_count from  orders
group by payment_type 



-- Q.8 Find out best selling category?

select p.product_category ,
count(o.quantity_ordered) as total_sales 
from products as  p 
join 
orders as o
on
o.product_id = p.product_id
group by product_category


-- Q.9 Customer who placed most orders?

select 
c.customer_id,
c.customer_name,
count(o.quantity_ordered) as most_orders
from orders as o
join 
customers as c
on 
c.customer_id = o.customer_id
group by c.customer_name,c.customer_id
order by most_orders desc	


-- Q.10 Best selling product where payment type is cash.

select 
p.product_name,
o.payment_type,
count(o.quantity_ordered) as total_orders
from products as p
join 
orders o 
on 
o.product_id = p.product_id
where o.payment_type = 'cash'
group by p.product_name,o.payment_type
order by total_orders

SELECT 
    p.product_name,
    o.payment_type,
    COUNT(o.quantity_ordered) AS total_orders
FROM 
    products AS p
JOIN 
    orders AS o 
    ON o.product_id = p.product_id
WHERE 
    o.payment_type = 'cash'
GROUP BY 
    p.product_name, 
    o.payment_type
ORDER BY 
    total_orders;








