select * from [dbo].[SALES DATA SAMPLE]

----Checking unique sales
select distinct status from [dbo].[SALES DATA SAMPLE]
select distinct YEAR_ID from [dbo].[SALES DATA SAMPLE]
select distinct PRODUCTLINE from [dbo].[SALES DATA SAMPLE]
select distinct COUNTRY from [dbo].[SALES DATA SAMPLE]
select distinct DEALSIZE from [dbo].[SALES DATA SAMPLE]
select distinct TERRITORY from [dbo].[SALES DATA SAMPLE]

---ANALYSIS
--Grouping sales by productline
select PRODUCTLINE,sum(sales)Revenue
from [dbo].[SALES DATA SAMPLE]
group by PRODUCTLINE
ORDER BY 2 DESC

---SALES ACROSS THE YEAR
select year_id,sum(sales) Revenue
from [dbo].[SALES DATA SAMPLE]
group by year_id
order by 2 desc

---REASONS WHY THERE WERE LOW SALES IN 2005
select distinct month_id
from [dbo].[SALES DATA SAMPLE]
where year_id='2005'---They only operated for 5 months
--checking the sales generated from deal sizes
select DEALSIZE,sum(sales) Revenue
from [dbo].[SALES DATA SAMPLE]
group by DEALSIZE
order by 2 desc

 ----FINDING THE BEST MONTH FOR SALES IN A PARTICULAR YEAR
 select month_id,sum(sales)Revenue,count(ORDERNUMBER) Frequency
 from [dbo].[SALES DATA SAMPLE]
 where year_id='2003'---change the year_id to get for 2004 and 2005
 group by month_id
 order by 2 desc--November is the best month for sales for 2003 and 2004
 ---What product generated the highest sales in November?
 select month_id,productline,sum(sales)Revenue
 from [dbo].[SALES DATA SAMPLE]
 where year_id='2003' and MONTH_ID='11'
 group by month_id,productline
 order by 3 desc---Classic cars is the product that generated the highest sales in November
 ----Who is our best customer?we do this by using the rfm
 ---rfm is Recency,Frequency,Monetary and it is an indexing technique that uses past purchase behaviour to segment customers
 ---It is using achieved by using three key metrics;
 ---Recency How long ago  their last purchase was i.e their last order date
 ----Frequency How oftern they purchase i.e count of total orders
 -----Monetary value how much they spent i.e total spent
 
 select
		CUSTOMERNAME,
		sum(sales) MonetaryValue,
		Avg(sales) AvgMonetaryValue,
		COUNT(ORDERNUMBER) Frequency,
		max(ORDERDATE) last_order_date
from [dbo].[SALES DATA SAMPLE]
group by CUSTOMERNAME
ORDER BY Frequency DESC

---To put in the a better way

select
		CUSTOMERNAME,
		sum(sales) MonetaryValue,
		Avg(sales) AvgMonetaryValue,
		COUNT(ORDERNUMBER) Frequency,
		max(ORDERDATE) last_order_date,
		(select max(ORDERDATE) from [dbo].[SALES DATA SAMPLE]) max_order_date,
		DATEDIFF(DD,max(ORDERDATE),(select max(ORDERDATE) from [dbo].[SALES DATA SAMPLE])) Recency
from [dbo].[SALES DATA SAMPLE]
group by CUSTOMERNAME
--Grouping this datasets into 4 different groups using NTILE
DROP TABLE IF EXISTS #rfm
with rfm as
(
	select
		CUSTOMERNAME,
		sum(sales) MonetaryValue,
		Avg(sales) AvgMonetaryValue,
		COUNT(ORDERNUMBER) Frequency,
		max(ORDERDATE) last_order_date,
		(select max(ORDERDATE) from [dbo].[SALES DATA SAMPLE]) max_order_date,
		DATEDIFF(DD,max(ORDERDATE),(select max(ORDERDATE) from [dbo].[SALES DATA SAMPLE])) Recency
	from [SQL PortfolioProject].[dbo].[SALES DATA SAMPLE]
	group by CUSTOMERNAME
),
rfm_calc as
(
	select r.*,
		NTILE(4) OVER (order by Recency)rfm_recency,
		NTILE(4) OVER (order by Frequency)rfm_frequency,
		NTILE(4) OVER (order by MonetaryValue)rfm_monetary
	from rfm r
)
select 
	c.*, rfm_recency+ rfm_frequency+ rfm_monetary as rfm_cell,
	cast(rfm_recency as varchar)+cast(rfm_frequency as varchar)+cast(rfm_monetary as varchar)rfm_cell_string
into #rfm
from rfm_calc c
---Using CASE Statements
select CUSTOMERNAME, rfm_recency, rfm_frequency, rfm_monetary,
	case
		when rfm_cell_string in (111,112,121,122,123,132,211,212,114,141) then 'lost customers'
		when rfm_cell_string in (133,134,143,244,334,343,344,144) then 'Customers that have not purchased recently'
		when rfm_cell_string in (311,411,331) then 'new customers'
		when rfm_cell_string in (222,223,233,322) then 'potential churners'
		when rfm_cell_string in (323,333,321,422,332,432) then 'High value customers'
		when rfm_cell_string in (433,434,443,444) then 'loyal customers'
	end rfm_segment
from #rfm 

---The products that are most often sold together
	select ORDERNUMBER
	from(
	select ORDERNUMBER,count(*) m
	from [SQL PortfolioProject].[dbo].[SALES DATA SAMPLE]
	where STATUS='shipped'
	group by ORDERNUMBER
	)m
	where m=2
----Retrieving the productcode for the orders
	select ','+ PRODUCTCODE
	from [dbo].[SALES DATA SAMPLE]
	where ORDERNUMBER IN
	(

	select ORDERNUMBER
		from(
		select ORDERNUMBER,count(*) m
		from [SQL PortfolioProject].[dbo].[SALES DATA SAMPLE]
		where STATUS='shipped'
		group by ORDERNUMBER
		)m
		where m=2
		)

	

