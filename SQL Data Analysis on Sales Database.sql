select * from production.products

---Finding the sales volume and revenues generated
select
	ord.order_id,
	CONCAT(cus.first_name,' ',cus.last_name),
	cus.city,
	cus.state,
	ord.order_date,
	SUM(ite.quantity) AS 'total_units',
	SUM(ite.quantity*ite.list_price) AS 'Revenue'
FROM sales.orders ord
JOIN sales.customers cus
on ord.customer_id=cus.customer_id 
JOIN sales.order_items ite
on ord.order_id=ite.order_id
group by
	ord.order_id,
	CONCAT(cus.first_name,' ',cus.last_name),
	cus.city,
	cus.state,
	ord.order_date

----Getting the product purchased alongside sales volume and revenue
select
	ord.order_id,
	CONCAT(cus.first_name,' ',cus.last_name)AS 'Customers',
	cus.city,
	cus.state,
	ord.order_date,
	SUM(ite.quantity) AS 'total_units',
	SUM(ite.quantity*ite.list_price) AS 'Revenue',
	pro.product_name
FROM sales.orders ord
JOIN sales.customers cus
on ord.customer_id=cus.customer_id 
JOIN sales.order_items ite
on ord.order_id=ite.order_id
JOIN production.products pro
on ite.product_id=pro.product_id
group by
	ord.order_id,
	CONCAT(cus.first_name,' ',cus.last_name),
	cus.city,
	cus.state,
	ord.order_date,
	pro.product_name
---Retrieving the category of the product alonside product_name and revenue
select
	ord.order_id,
	CONCAT(cus.first_name,' ',cus.last_name)AS 'Customers',
	cus.city,
	cus.state,
	ord.order_date,
	SUM(ite.quantity) AS 'total_units',
	SUM(ite.quantity*ite.list_price) AS 'Revenue',
	pro.product_name,
	cat.category_name
FROM sales.orders ord
JOIN sales.customers cus
on ord.customer_id=cus.customer_id 
JOIN sales.order_items ite
on ord.order_id=ite.order_id
JOIN production.products pro
on ite.product_id=pro.product_id
JOIN production.categories cat
on pro.category_id=cat.category_id
group by
	ord.order_id,
	CONCAT(cus.first_name,' ',cus.last_name),
	cus.city,
	cus.state,
	ord.order_date,
	pro.product_name,
	cat.category_name

-----The store at which the sales took place.
select
	ord.order_id,
	CONCAT(cus.first_name,' ',cus.last_name)AS 'Customers',
	cus.city,
	cus.state,
	ord.order_date,
	SUM(ite.quantity) AS 'total_units',
	SUM(ite.quantity*ite.list_price) AS 'Revenue',
	pro.product_name,
	cat.category_name,
	sto.store_name
FROM sales.orders ord
JOIN sales.customers cus
on ord.customer_id=cus.customer_id 
JOIN sales.order_items ite
on ord.order_id=ite.order_id
JOIN production.products pro
on ite.product_id=pro.product_id
JOIN production.categories cat
on pro.category_id=cat.category_id
JOIN sales.stores sto
on ord.store_id=sto.store_id
group by
	ord.order_id,
	CONCAT(cus.first_name,' ',cus.last_name),
	cus.city,
	cus.state,
	ord.order_date,
	pro.product_name,
	cat.category_name,
	sto.store_name
---Retrieving the information of the sales rep that made the sales
select
	ord.order_id,
	CONCAT(cus.first_name,' ',cus.last_name)AS 'Customers',
	cus.city,
	cus.state,
	ord.order_date,
	SUM(ite.quantity) AS 'total_units',
	SUM(ite.quantity*ite.list_price) AS 'Revenue',
	pro.product_name,
	cat.category_name,
	sto.store_name,
	CONCAT(sta.first_name,' ',sta.last_name) AS 'Sales_rep'
FROM sales.orders ord
JOIN sales.customers cus
on ord.customer_id=cus.customer_id 
JOIN sales.order_items ite
on ord.order_id=ite.order_id
JOIN production.products pro
on ite.product_id=pro.product_id
JOIN production.categories cat
on pro.category_id=cat.category_id
JOIN sales.stores sto
on ord.store_id=sto.store_id
JOIN sales.staffs sta
on ord.staff_id=sta.staff_id
group by
	ord.order_id,
	CONCAT(cus.first_name,' ',cus.last_name),
	cus.city,
	cus.state,
	ord.order_date,
	pro.product_name,
	cat.category_name,
	sto.store_name,
	CONCAT(sta.first_name,' ',sta.last_name)

--Selecting the brand name
select
	ord.order_id,
	CONCAT(cus.first_name,' ',cus.last_name)AS 'Customers',
	cus.city,
	cus.state,
	ord.order_date,
	SUM(ite.quantity) AS 'total_units',
	SUM(ite.quantity*ite.list_price) AS 'Revenue',
	pro.product_name,
	cat.category_name,
	bra.brand_name,
	sto.store_name,
	CONCAT(sta.first_name,' ',sta.last_name) AS 'Sales_rep'
FROM sales.orders ord
JOIN sales.customers cus
on ord.customer_id=cus.customer_id 
JOIN sales.order_items ite
on ord.order_id=ite.order_id
JOIN production.products pro
on ite.product_id=pro.product_id
JOIN production.categories cat
on pro.category_id=cat.category_id
JOIN production.brands bra
on pro.brand_id=bra.brand_id
JOIN sales.stores sto
on ord.store_id=sto.store_id
JOIN sales.staffs sta
on ord.staff_id=sta.staff_id
group by
	ord.order_id,
	CONCAT(cus.first_name,' ',cus.last_name),
	cus.city,
	cus.state,
	ord.order_date,
	pro.product_name,
	cat.category_name,
	bra.brand_name,
	sto.store_name,
	CONCAT(sta.first_name,' ',sta.last_name)