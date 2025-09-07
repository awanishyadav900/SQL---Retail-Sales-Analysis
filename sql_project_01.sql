--Creating table
Drop table if exists retail_sales;
create table retail_sales(
         transactions_id int PRIMARY KEY,	
		 sale_date	date,
		 sale_time	time,
		 customer_id int,	
		 gender  varchar(10),
		 age  int,
		 category varchar(15),
		 quantiy int,	
		 price_per_unit	float,
		 cogs float,	
		 total_sale float

);
select*from retail_sales;

--inserting values
select*from retail_sales order by transactions_id limit 10;

--count total number of rows
select count(*) from retail_sales;

-- to see only one row
select age from retail_sales as Age;

select * from retail_sales
where age= 40;

-- DATA CLEAINING 
--to find the null values from a table
select * from retail_sales
where 
    transactions_id is null
	OR
	sale_date is null
	OR
	sale_time is null
	OR
	customer_id is null
	OR
	gender is null
	OR
	age is null 
	OR
	category is null
	OR
    quantiy is null
	OR
	price_per_unit is null
	OR
	cogs is null
	OR
	total_sale is null;

--Delete the null values
delete from retail_sales
where 
         transactions_id is null
	OR
	sale_date is null
	OR
	sale_time is null
	OR
	customer_id is null
	OR
	gender is null
	OR
	age is null 
	OR
	category is null
	OR
    quantiy is null
	OR
	price_per_unit is null
	OR
	cogs is null
	OR
	total_sale is null;

select*from retail_sales;

-- Data Exploration

--Total number of sales
select count(*) from retail_sales;

--How many unique customer  we have?
select count(distinct customer_id) as customer from retail_sales;

--How many unique category we have?
select distinct category from retail_sales;

-- Data Analysis & Business Key Problems & Answers
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

 --Answer
--Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05?
    select * from retail_sales as sales 
         where sale_date ='2022-11-05';

-- Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
  SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4;

--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.	
      SELECT  category,
	  sum(total_sale) as total_sales 
	  from retail_sales
	  group by category;
	  
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
     select
	 round(avg(age),2) as net_avg from retail_sales
	 where category='Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
    select* from retail_sales
     where total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
   select gender,category,
   count(transactions_id) as transactions
     from retail_sales 
	 group by gender,category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
 select
     year,
	 month,
	 avg_sale 
	 from(
select 
   extract(year from sale_date) as year,
   extract(month from sale_date) as month,
   avg(total_sale)as avg_sale,
   rank() over(partition by extract(year from sale_date)order by
   avg(total_sale)desc) as rank
   from retail_sales
   group by year,month) as t1
   where rank=1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales .

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
  select
     category,
	 count(distinct customer_id) as customer
	 from retail_sales
	 group by category;

 
