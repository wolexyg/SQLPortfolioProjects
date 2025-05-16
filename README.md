# SQLPortfolioProject

# Project 1-Pizza Sales Analysis    
## Problem Statement 
The primary goal of this project is to analyze Walmart’s sales data to gain insights into the factors influencing sales across its various branches.
<<mg src="https://i.ibb.co/HL4Y4D2S/Pizza-Sales-Analysis.jpg" alt="Pizza-Sales-Analysis" border="0">
## KEY FEATURES:         
-- Time Based Order Analysis.   
-- Orders Management.      
-- Revenue Analysis.        
-- Most Popular Pizzas Based On Price, Order, Category.      

## PROJECT GOALS:     
-- 1. Understand Customer Behavior.     
-- 2. Optimize Sales Strategies.     
-- 3. Improve Operational Efficiency.         
-- 4.  Drive Revenue Growth.         

## DATA DESCRIPTION:           
This document outlines the schema for the tables used in a pizza ordering system database. The database includes 4 csv format datasheets- order_details, orders, pizzas. Pizza_types.      


## KEY PERFORMANCE INDICATORS (KPI):     
-- Total Revenue      
--  Number of Orders       
--  Avg. Order Value        
--  Most Ordered (Quantity)          
--  Top Revenue (Types)       
--  Order Distribution (Hour)        
--   Popular Pizza Size        
--   Category Revenue         
--   Cumulative Revenue (Time)        


## DATA INSIGHTS:         
· High Sales: $817K revenue from 21K+ orders.       
· Daily Average: 138 pizzas ordered daily.       
· Peak Hours: Lunch (12-1 PM), early evening (4-7 PM), late night.       
· Top Categories: Classic (most revenue & units), Supreme (second).        
· Most Ordered Pizza: Classic Deluxe.      
· Top Revenue Pizzas: Thai Chicken & Barbecue Chicken.      
· Preferred Size: Large (L).       
· Key Revenue Categories: Classic, Supreme, Chicken, Veggie.       
· Chicken Potential: Growth despite fewer options.       
· Pricing Range: Greek (high), Brie Carre (low).      
· XXL Underperforming: Low order volume.        
· Positive Trend: Consistent revenue growth.        

## RECOMMENDATIONS:       
-- Optimize Inventory: Stock Popular: Ensure enough Classic, Thai Chicken, Barbecue Chicken (all sizes) and Large size.       
-- Promote Strategically: Target off-peak times, focus on Classic, Thai Chicken, Barbecue Chicken. Highlight Chicken category.   
-- Optimize Staffing: Match staff to peak hours (lunch, evening).         
-- Review Products: Re-evaluate/discontinue XXL. Consider more Chicken options.       
-- Engage Customers: Use Classic and Large popularity in marketing.       


















## Installation

Install my-project with npm

```bash
  npm install my-project
  cd my-project
```
# Project 2-RFM Analysis on Sales Data Sample

Analysis on sales revenue and customer segmentation analysis using RFM in Microsoft SQL Server with Sales sample data originally downloaded from Kaggle.com
RFM means Recency,Frequency and Monetary.Highlights of the analysis includes amongst others Data Cleaning,RFM Analysis,Using CASE Statements,Window functions,Group by,order by and Having clause functions.The major Data analysis explored on the dataset include;             
1.-Grouping sales by productline             
2.--SALES ACROSS THE YEAR                    
3. REASONS WHY THERE WERE LOW SALES IN 2005            
4.-FINDING THE BEST MONTH FOR SALES IN A PARTICULAR YEAR             
5 -The product generated the highest sales in November        
6--The  best customer using RFM Analysis            
7.The products that are most often sold together           
8.Retrieving the productcode for the orders


This dataset was created to explore the SQL Data Analysis of Sales Sample Data downloaded from www.kaggle.com using RFM Analysis

# Project 3-Cleaning and Exploring SBA Data
# Overview
Here is an SQL Data Analysis of the USA Small Business Administration(SBA).As part of their Covid-19 relief assistance to small businesses,they offered a paycheck
protection program which is a loan they gave out to small businesses to help them pay their workforce.They made some datasets available related to that program which can be downloaded from www.data.sba.gov/dataset/   I will be cleaning and exploring the data to derive meaningful insight in Microsoft
SQL Server.






## Installation

Install my-project with npm

```bash
  npm install my-project
  cd my-project
```

# Project 4 Title-Online Book Store Data Analysis Using MySQL

This project involved a deep dive into bookstore sales data, leveraging MySQL's powerful analytical features and strategic SQL queries (including joins) to uncover valuable insights for making informed business decisions.              

▶️ KEY FEATURES:         

1. Time-Based Order Analysis       
2. Customer Order Management      
3. Revenue Stream Analysis        
4. Top-Selling Books by Genre, Price, and Quantity        
5. Stock Level Assessment          

▶️ PROJECT GOALS:        

1. Understand Customer Preferences       
2. Optimize Sales and Marketing Strategies      
3. Improve Inventory Management       
4. Drive Revenue Growth        

▶️ DATA DESCRIPTION:              
This analysis utilized 3 datasets in CSV format, detailing customer details, order details, book information.      

▶️ KEY PERFORMANCE INDICATORS (KPI):          

1. Total Revenue        
2. Number of Orders        
3. Average Order Value      
4. Most Ordered Books (Quantity)     
5. Top Revenue Generating Books      
6. Order Distribution (Monthly/Seasonal)       
7. Popular Book Genres       
8. Customer Loyalty Rate (Repeat Orders)      
9. Remaining Stock Levels       
10 Top Spending Customers         

▶️ DATA INSIGHTS:         

· Strong Revenue: Achieved a significant total revenue from all book sales.        
· Popular Fiction: Fiction books are the top-selling genre, indicating high customer demand.      
· Seasonal Peak: November 2023 experienced a notable spike in sales, highlighting seasonal trends.        
· Canadian Engagement: A substantial portion of the customer base resides in Canada, presenting regional marketing opportunities.    
· Loyal Base: Several customers placed multiple orders, demonstrating strong loyalty.        
· High-Value Potential: High-value orders and bulk purchases suggest potential for loyalty programs and discounts.      
· Top Spenders: Identified key customers with the highest total spending.       

▶️ RECOMMENDATIONS:      

· Prioritize Fiction: Ensure ample stock and targeted promotions for fiction titles.       
· Capitalize on November: Plan specific marketing campaigns to leverage the November sales surge.      
· Engage Canadian Customers: Develop tailored marketing strategies for the Canadian market.      
· Implement Loyalty Rewards: Introduce a loyalty program to incentivize repeat purchases.       
· Optimize Inventory (Fiction): Maintain sufficient stock levels of popular fiction books.       
· Recognize Top Customers: Consider personalized offers or engagement strategies for high-spending customers.       



Install my-project with npm


# Project 5-Walmart Data Analysis: End-to-End SQL + Python Project 
# Project Scope:
Perform in-depth sales analysis to uncover business insights that highlight performance trends and identify growth opportunities and recommend data-driven strategies for improving product sales. The main goal of this project is to gain insights sales data, exploring the various factors that influence sales across different branches.

# About Data
This project's data was obtained from the Kaggle Walmart Sales Forecasting Competition and it encompasses sales transactions from three Walmart branches situated in Mandalay, Yangon, and Naypyitaw, respectively.

The data contains 17 columns and 1000 rows:

The data contains 17 columns and 1000 rows:
| Column            | Description                                   | Data Type        |
|-------------------|-----------------------------------------------|------------------|
| invoice_id        | Invoice of the sales made                     | VARCHAR(30)      |
| branch            | Branch at which sales were made               | VARCHAR(5)       |
| city              | The location of the branch                    | VARCHAR(30)      |
| customer_type     | The type of the customer                       | VARCHAR(30)      |
| gender            | Gender of the customer making purchase        | VARCHAR(10)      |
| product_line      | Product line of the product sold               | VARCHAR(100)     |
| unit_price        | The price of each product                     | DECIMAL(10, 2)   |
| quantity          | The amount of the product sold                 | INT              |
| VAT               | The amount of tax on the purchase             | FLOAT(6, 4)      |
| total             | The total cost of the purchase                | DECIMAL(12, 4)   |
| date              | The date on which the purchase was made       | DATETIME         |
| time              | The time at which the purchase was made       | TIME             |
| payment           | The total amount paid                         | DECIMAL(10, 2)   |
| cogs              | Cost Of Goods sold                            | DECIMAL(10, 2)   |
| gross_margin_pct  | Gross margin percentage                       | FLOAT(11, 9)     |
| gross_income      | Gross Income                                  | DECIMAL(12, 4)   |
| rating            | Rating                                        | FLOAT(2, 1)      |


## Analysis Flow:
1. Product Analysis
Analyzed product line performance to identify top contributors to revenue and profit, while highlighting areas for strategic improvement.

2. Sales Analysis
Evaluated sales trends across time, branches, and payment channels to assess the effectiveness of sales strategies and uncover opportunities for revenue growth.

3. Customer Analysis
Segmented customers to understand buying behavior, analyze revenue contribution by segment, and uncover actionable insights to optimize customer engagement and profitability.

## Approach Used
1. Data Wrangling

During this initial phase, the data is examined to detect any NULL or missing values, and strategies for data replacement are implemented to address and substitute these values effectively.

## Build a database
Create a table and insert the data.
Select columns with null values in them. Null values are not present in our database because, in creating the tables, NOT NULL was specified for each field, effectively filtering out any null values.             
## 2. Feature Engineering               

## Derived new columns from existing data for time-based analysis:

time_of_day: Categorized transactions into Morning, Afternoon, and Evening to analyze peak sales periods during the day.

day_name: Extracted weekday names to identify branch activity trends across the week.

month_name: Extracted month names to evaluate monthly sales and profitability performance.            

## 3. Exploratory Data Analysis (EDA)

## Business Questions to Answer
Generic Questions        
-- How many distinct cities are present in the dataset?                    
-- In which city is each branch situated?                     
## Product Analysis              
-- How many distinct product lines are there in the dataset?                
-- What is the most common payment method?                
-- What is the most selling product line?               
-- What is the total revenue by month?                    
-- Which month recorded the highest Cost of Goods Sold (COGS)?              
-- Which product line generated the highest revenue?             
-- Which city has the highest revenue?             
-- Which product line incurred the highest VAT?                   
## Retrieve each product line and add a column product_category, indicating 'Good' or 'Bad,' based on whether its sales are above the average.                     
-- Which branch sold more products than average product sold?         
-- What is the most common product line by gender?           
-- What is the average rating of each product line?           
## Sales Analysis    
-- Number of sales made in each time of the day per weekday          
-- Identify the customer type that generates the highest revenue.      
-- Which city has the largest tax percent/ VAT (Value Added Tax)?         
-- Which customer type pays the most VAT?        
## Customer Analysis
-- How many unique customer types does the data have?       
-- How many unique payment methods does the data have?      
-- Which is the most common customer type?        
-- Which customer type buys the most?         
-- What is the gender of most of the customers?        
-- What is the gender distribution per branch?        
-- Which time of the day do customers give most ratings?      
-- Which time of the day do customers give most ratings per branch?      
-- Which day of the week has the best avg ratings?       
-- Which day of the week has the best average ratings per branch?     
# Advanced Analytics
-- Is there a correlation between high ratings and higher gross income?      
-- Which product line is most sensitive to time_of_day (i.e. shows the most variation in sales across different times)?        
-- Which branch has the fastest-moving inventory (highest quantity sold relative to number of invoices)?           
## Month-over-Month Revenue Growth
-- Which product line shows the most variation in sales across different times of the day?       
-- Which product line has the highest profit margin %       


```bash
  npm install my-project
  cd my-project
```
    
