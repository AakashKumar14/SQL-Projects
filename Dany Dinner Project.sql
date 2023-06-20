select * from members;
select * from menu;
select * from sales;


select customer_id from sales; -- column

select product_name, product_id from menu; -- Columns

SELECT TOP (5) [customer_id] -- Top N
      ,[order_date]
      ,[product_id]
  FROM [DannyDiner].[dbo].[sales]


  select product_name AS Product_Name, -- Aliasing
  product_id AS Product_ID 
  from menu;


  select product_name AS [Product Name], -- Aliasing in space
  product_id AS Product_ID 
  from menu;

  
  select * from menu -- Where: = Operator
  where price = 15


 select * from menu -- Where: > Operator
  where price > 10


 select * from menu -- Where: <> Operator
  where price <> 10


  -- Find out the products ordered by Customer A
  select *
  from sales 
  where customer_id = 'A';


 -- Between Operator
 select *
 from sales 
 where order_date between '2021-01-07' and '2021-01-11';


-- Like Operator % ( Find Pattern)

select * 
from menu 
where product_name like 's%';


select * 
from menu 
where product_name like '%n';


select * 
from menu 
where product_name like '%u%';


-- Not Like Operator % ( Find Pattern)

select * 
from menu 
where product_name not like '%u%';



-- In Operator ( to avoid Multiple OR and AND functions)

select * 
from menu 
where product_name in ( 'sushi' ,'curry', 'pizza');

-- Not IN

select * 
from menu 
where product_name not in ( 'sushi' ,'curry', 'pizza');

select * 
from menu 
where product_name not in ('*');

select * 
from menu 
where price not in (10);


-- IS NULL


-- Aggregator Functions

select 
sum(price) as Total_Price,
avg(price) as Total_Price,
max(price) as Total_Price,
min(price) as Total_Price
from menu ;


select count ( customer_id) AS Total_Customer
from sales ;

select count(distinct customer_id) AS Total_Customer
from sales ;


-- Group By

select
customer_id,
count ( customer_id) AS Total_Customer
from sales
Group by
customer_id;




-- Order By

select
customer_id,
order_date,
count ( customer_id) AS ID_Count
from sales
Group by
customer_id,
order_date
order by
customer_id


-- Having

select
customer_id,
count (customer_id) AS ID_Count
from sales
Group by
customer_id
having count (customer_id) > 3;




-- How many days Customer C visited the resturant ?

select 
customer_id,
count(distinct order_date) as Days_visited
from sales
where customer_id = 'C'
group by 
customer_id;



-- How many unique products customer C ordered in the resturant

select 
customer_id,
count(distinct product_id) as products_ordered
from sales
where customer_id = 'C'
group by 
customer_id;


select * from members;
select * from menu;
select * from sales;


-- Join or Inner Join
-- Order Date | Customer ID | Product Name


select
sal.order_date,
sal.customer_id,
men.product_name
From menu men
inner join sales sal
on men.product_id = sal.product_id;


-- Left Join

select
sal.order_date,
sal.customer_id,
men.product_name
From menu men
left join sales sal
on men.product_id = sal.product_id;



-- Order Date | Customer ID | Product Name | join date

select
sal.order_date,
sal.customer_id,
men.product_name,
mem.join_date
From menu men
left join sales sal
on men.product_id = sal.product_id
right Join members mem
on mem.customer_id = sal.customer_id;



select * from members;
select * from menu;
select * from sales;


-- How Much Customer spent their money during order date ??
-- Customer ID | Total_Price

select
sal.customer_id,
sum ( men.price ) As Total_Price
from
menu men
inner join sales sal
ON men.product_id = sal.product_id
group by
sal.customer_id;


-- How Much Total Amount each Customer has spent in the resturant product wise ??
-- Total Amount | Customer ID | Product Name


select
sal.customer_id,
men.product_name,
sum ( men.price ) As Total_Price
from
menu men
inner join sales sal
ON men.product_id = sal.product_id
group by
men.product_name,
sal.customer_id;


-- How Much Total Amount and Total Quantity of Products is related to each customer ?
-- Total Amount | Customer ID | Total Quantity


select
sal.customer_id,
men.product_name,
sum ( men.price ) As Total_Price,
count (sal.product_id) as Total_Products
from
menu men
inner join sales sal
ON men.product_id = sal.product_id
group by
men.product_name,
sal.customer_id;



-- How Much Total Amount and Total Quantity of Products is related to each customer  before they became a member?

select
sal.customer_id,
sum ( men.price ) As Total_Price,
count (sal.product_id) as Total_Products
from
menu men
inner join sales sal
ON men.product_id = sal.product_id
inner Join members mem 
On mem.customer_id = sal.customer_id
where  order_date < join_date 
group by
sal.customer_id;



-- Case Statement

-- Sushi = 20 points
-- Curry or Ramen = 10 Points
 -- Customer ID | Product_name | Points


 select * from members;
select * from menu;
select * from sales;

Select customer_id,
Product_name,
Case
	when product_name = 'sushi' then count (men.product_id) * 20
	else count (men.product_id) * 10
	End as Points
From menu men
inner join sales sal
ON men.product_id = sal.Product_id
Group By 
customer_id,
Product_name
Order BY
customer_id;


-- Windows Functions // Ordered Analytical Functions
-- over ()

select
sal.customer_id,
men.product_name,
men.price,
sum (men.price) over() AS Total_Price
From menu men
left join sales sal
on men.product_id = sal.product_id;


-- over () with Partition By

select
sal.customer_id,
men.product_name,
men.price,
sum (men.price) over(partition by sal.customer_id ) AS Total_Price
From menu men
left join sales sal
on men.product_id = sal.product_id;


-- over () with Order By

select
sal.customer_id,
men.product_name,
men.price,
sum (men.price) over(order by sal.customer_id ) AS Total_Price
From menu men
left join sales sal
on men.product_id = sal.product_id;



--Scenario 1 
 -- Customer ID | Product_name | Order date | Ranking By Date


 Select
sal.customer_id,
sal.order_date,
men.product_name,
Dense_rank() Over(Partition by sal.customer_id Order by sal.order_date) As Ranking
From menu men
join sales sal
on men.product_id = sal.product_id;


-- Sub Querry
-- Customer ID | Product_name 

Select
q1.customer_id,
q1.Product_name
From
(
 Select
sal.customer_id,
sal.order_date,
men.product_name,
Dense_rank() Over(Partition by sal.customer_id Order by sal.order_date) As Ranking
From menu men
join sales sal
on men.product_id = sal.product_id
) As q1
Where Ranking = 1;


-- CTE
-- Common Table Expression

with q1 as
(
Select
sal.customer_id,
sal.order_date,
men.product_name,
Dense_rank() Over(Partition by sal.customer_id Order by sal.order_date) As Ranking
From menu men
join sales sal
on men.product_id = sal.product_id
)
select 
q1.customer_id,
q1.Product_name
from q1
where Ranking = 1