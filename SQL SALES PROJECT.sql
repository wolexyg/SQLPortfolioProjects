ALTER TABLE SERVICEDATA
ADD CONSTRAINT fk_branch_id
FOREIGN KEY(branch_id) REFERENCES branchdata(Branch_ID);
 
--Revenue by Region-Sum total from the service data table and group them by the region
-- from the branch data table to see which region generates the most
SELECT b.Region, SUM(s.total_revenue) AS TotalRevenue
FROM SERVICEDATA s
JOIN branchdata b ON s.branch_id = b.Branch_ID
GROUP BY b.Region
ORDER BY TotalRevenue DESC;

--2.	Revenue by Department:

SELECT department, SUM(total_revenue) AS TotalRevenue
FROM SERVICEDATA
GROUP BY department
ORDER BY TotalRevenue DESC;

--3.	Revenue by Customer

SELECT client_name, SUM(total_revenue) AS TotalRevenue
FROM SERVICEDATA
GROUP BY client_name
ORDER BY TotalRevenue DESC;


--KPIs Queries

--1.	Total Revenue:

SELECT SUM(total_revenue) AS TotalRevenue
FROM SERVICEDATA;

--2.	Total Hours:

SELECT SUM(hours) AS TotalHours
FROM SERVICEDATA;

--3.	Revenue by Region over Overall Revenue:

SELECT 
    department, 
    SUM(total_revenue) AS DepartmentRevenue,
    (SUM(total_revenue) / (SELECT SUM(total_revenue) FROM SERVICEDATA)) * 100 AS RevenuePercentage
FROM 
    SERVICEDATA
GROUP BY 
    department;

--4.	Month on Month Percentage Increase:

WITH MonthlyRevenue AS (
    SELECT 
        FORMAT(service_date, 'yyyy-MM') AS Month,
        SUM(total_revenue) AS Revenue
    FROM 
        SERVICEDATA
    GROUP BY 
        FORMAT(service_date, 'yyyy-MM')
),
RevenueComparison AS (
    SELECT 
        Month,
        Revenue,
        LAG(Revenue) OVER (ORDER BY Month) AS PreviousMonthRevenue
    FROM 
        MonthlyRevenue
)
SELECT 
    Month,
    Revenue,
    PreviousMonthRevenue,
    CASE WHEN PreviousMonthRevenue > 0 THEN ((Revenue - PreviousMonthRevenue) / PreviousMonthRevenue) * 100 ELSE NULL END AS RevenuePercentageIncrease
FROM 
    RevenueComparison
WHERE 
    PreviousMonthRevenue IS NOT NULL;

 --MODIFIED SQL QUERIES FOR PROBLEM STATEMENTS

--1.	Revenue by Region (Modified)
SELECT 
    b.Region, 
    s.service_date AS ServiceDate, 
    SUM(s.total_revenue) AS TotalRevenue
FROM dbo.SERVICEDATA s
JOIN dbo.branchdata b ON s.branch_id = b.branch_id
GROUP BY b.Region, s.service_date;

--2. Revenue by Department (Modified): 
SELECT 
    department, 
    SUM(total_revenue) AS TotalRevenue,
    service_date
FROM dbo.SERVICEDATA
GROUP BY department, service_date;

--3. Revenue by Customer (Modified):

SELECT 
    TOP 5 client_name, 
    SUM(total_revenue) AS TotalRevenue,
    service_date
FROM dbo.SERVICEDATA
GROUP BY client_name, service_date;



