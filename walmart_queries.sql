 Walmart Project Queries - MySQL

-- Create database
CREATE DATABASE IF NOT EXISTS walmart_sales;

use walmart_sales;

-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);



-- ======================================================================
--   -----------------------  Feature Engineering  ----------------------- 
-- ======================================================================
SET SQL_SAFE_UPDATES = 0;
-- ================
-- 1. Time_of_day
-- ================
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
	CASE 
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
		WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
		ELSE "Evening" 
	END);

-- ================
-- 2.Day_name
-- ================

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);


-- ================
-- 2.Month_name
-- ================

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name=MONTHNAME(date);

-- ===================================================================
-- ----------------Exploratory Data Analysis (EDA)----------------------
-- ===================================================================

-- Generic Question

-- How many unique cities does the data have?

select count(distinct city) from sales;

-- 2.In which city is each branch situated?

select distinct city, branch from sales;

-- ===================================================================
-- ----------------Product Analysis----------------------
-- ===================================================================

-- How many distinct product lines are there in the dataset?

select count(distinct product_line) from sales;

-- -- 2.What is the most common payment method?

select payment, count(*) as common_payment_method
from sales
group by payment
order by common_payment_method desc limit 1;

-- 3.What is the most selling product line?

select product_line, round(sum(total),2) as most_selling_product
from sales
group by product_line
order by most_selling_product desc limit 1;

-- 4.What is the least selling product line?

select product_line, sum(total) as least_selling_product
from sales
group by product_line
order by least_selling_product asc limit 1;

-- 5.What is the total revenue by month?

select month_name, sum(total) as total_revenue
from sales
group by month_name order by total_revenue desc;

-- 6.Which month recorded the highest Cost of Goods Sold (COGS)?

select month_name, sum(cogs) as total_cogs from sales
group by month_name order by total_cogs desc limit 1;

-- 7.Which product line generated the highest revenue?

select product_line, sum(total) as total_revenue
from sales
group by product_line order by total_revenue desc limit 1;

-- 8.Which city has the highest revenue?

select city, sum(total) as total_revenue
from sales
group by city order by total_revenue desc limit 1;

-- 9.Which product line incurred the highest VAT?

select product_line, round(avg(tax_pct),2) as Avg_VAT
from sales 
group by product_line order by Avg_VAT desc limit 1;

-- 10. Which branch sold more products than average product sold?

WITH branch_sales AS (
    SELECT branch, SUM(quantity) AS total_quantity
    FROM sales
    GROUP BY branch
)
SELECT 
    branch, 
    total_quantity
FROM branch_sales
WHERE total_quantity > (SELECT AVG(total_quantity) FROM branch_sales);

-- What is the most common product line by gender?

select product_line, gender, count(gender) as total_count 
from sales group by product_line, gender
order by total_count desc;

-- What is the average rating of each product line?

select product_line, round(avg(rating),2) as Avg_rating
from sales
group by product_line
order by Avg_rating desc;


-- ======================================================================
--   -----------------------  Sales Analysis  ----------------------- 
-- ======================================================================

-- Number of sales made in each time of the day per weekday

select day_name, time_of_day, count(invoice_id) as total_sales
from sales
group by day_name, time_of_day
Having day_name not in ('Sunday','Saturday')
order by day_name asc;

-- Identify the customer type that generates the highest revenue.

select customer_type, sum(total) as total_revenue
from sales
group by customer_type
order by total_revenue desc limit 1;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?

select city, round(avg(tax_pct),2) as VAT
from sales
group by city
order by VAT desc;

-- ======================================================================
--   -----------------------  Customer Analysis  ----------------------- 
-- ======================================================================

-- Which customer type buys the most?
select customer_type, count(*) as total_purchases
from sales
group by customer_type 
order by total_purchases desc;

-- What is the gender of most of the customers?

SELECT
	gender, COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?

SELECT branch, gender, COUNT(*) as gender_cnt
FROM sales
GROUP BY branch, gender
ORDER BY branch;

-- Which time of the day do customers give most ratings?

select time_of_day, round(avg(rating),2) as Avg_rating
from sales
group by time_of_day;

-- Which time of the day do customers give most ratings per branch?

select branch, time_of_day, round(avg(rating),2) as Avg_rating
from sales
group by branch, time_of_day
order by Avg_rating desc;

-- Which day of the week has the best avg ratings?

select day_name, avg(rating) as Avg_Rating
from sales
group by day_name
order by Avg_Rating desc;

 -- Which day of the week has the best average ratings per branch? 
 select day_name, branch, avg(rating) as Avg_Rating
from sales
group by day_name, branch
order by day_name, branch;

-- ==============================
-- ADVANCED ANALYTICS
-- ==============================

-- Which product line has the highest profit margin % (gross income ÷ cogs)?

SELECT product_line, round(avg(gross_income),2) as Avg_Gross_Margin
from sales group by product_line
order by Avg_Gross_Margin desc;


-- Which product line shows the most variation in sales across different times of the day?

SELECT 
    product_line,
    round(STDDEV(quantity),2) AS sales_variability
FROM sales
GROUP BY product_line
ORDER BY sales_variability DESC;

-- Month-over-Month Revenue Growth

WITH monthly_sales AS (
    SELECT 
        month_name, 
        SUM(total) AS monthly_sales
    FROM sales
    GROUP BY month_name
)

SELECT 
    month_name,
    monthly_sales,
    LAG(monthly_sales) OVER (ORDER BY FIELD(month_name, 'January', 'February', 'March')) AS prev_month_revenue
FROM monthly_sales;

-- Which branch has the highest average revenue per invoice?

SELECT 
    branch, round(AVG(total),2) AS avg_revenue_per_invoice
FROM sales
GROUP BY branch
ORDER BY avg_revenue_per_invoice DESC;


-- Which branch has the highest average profit per Invoice by customer

select branch, customer_type, round(avg(gross_income),2) as Avg_profit_per_Invoice
from sales
group by branch, customer_type
order by Avg_profit_per_Invoice desc;

-- Which day of the week has the highest average profit per invoice
-- (comapre daily gross income per sale)

select day_name, round(avg(gross_income),2) as Avg_gross_profit
from sales
group by day_name
order by Avg_gross_profit desc;

-- Which branch has the fastest-moving inventory (highest quantity sold relative to number of invoices)?

select branch, avg(quantity) as Avg_Quantity_sold
from sales
group by branch
order by Avg_Quantity_sold desc;

-- Which product line is most sensitive to time_of_day 
-- (i.e., shows the most variation in sales across different times)?

select product_line, time_of_day, round(avg(total),2) as Avg_sales
from sales
group by product_line, time_of_day
order by product_line, time_of_day, Avg_sales desc;

-- Is there a correlation between high ratings and higher gross income?

SELECT 
    product_line,
    round(AVG(rating),2) AS avg_rating,
    round(AVG(gross_income),2) AS avg_gross_income
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;
