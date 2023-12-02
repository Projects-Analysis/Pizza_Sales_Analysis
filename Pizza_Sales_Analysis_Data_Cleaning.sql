CREATE DATABASE PIZZA DB

--- OPEN THE DATASET TO VIEW ITS CONTENT 
SELECT *
FROM pizza_sales


                --- THE KPI'S ----

--- TOTAL REVENUE 
SELECT ROUND(SUM(total_price),0) AS Total_Revenue 
FROM pizza_sales



--- AVERAGE ORDER VALUE 
SELECT ROUND(SUM(total_price)/ COUNT (DISTINCT order_id),0) AS Average_Order
FROM pizza_sales



--- TOTAL PIZZA SOLD 
SELECT SUM(quantity) AS Total_Pizza_Sold 
FROM pizza_sales


--- TOTAL ORDERS 
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales


--- AVERAGE PIZZA PER ORDER 
SELECT CAST(CAST(SUM(quantity)AS decimal(10,2))/ 
CAST(COUNT (DISTINCT order_id) AS decimal(10,2)) AS decimal(10,2)) AS Average_Pizza_Order
FROM pizza_sales


                  --- CHARTS REQUIREMENT---

--- (1) DAILY TREND FOR TOTAL ORDERS
SELECT DATENAME(DW,order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
GROUP BY DATENAME(DW,order_date)
ORDER BY Total_Orders DESC 


--- (2) HOURLY TREND FOR TOTAL ORDERS
SELECT DATEPART(HOUR,order_time) AS Order_Hours , COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATEPART(HOUR,order_time)
ORDER BY DATEPART(HOUR,order_time)


--- (3) PERCENTAGE OF SALES BY PIZZA CATEGORY 
SELECT pizza_category, ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales),0) AS PCT_Sales_Pizza_Category
FROM pizza_sales
GROUP BY pizza_category
ORDER BY PCT_Sales_Pizza_Category DESC

--- (4) PERCENTAGE OF SALES BY PIZZA SIZE
SELECT pizza_size,CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT_Sales_Pizza_Size
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT_Sales_Pizza_Size DESC



--- (5) TOTAL PIZZA SOLD BY PIZZA CATEGORY 
SELECT pizza_category, SUM(quantity) AS Total_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Sold DESC

--- (6) TOP 5 BEST SELLER BY TOTAL PIZZA SOLD 
SELECT TOP 5 pizza_name, SUM(quantity) AS Pizza_Sold 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY Pizza_Sold DESC


--- (7) BOTTOM 5 WORST SELLER BY TOTAL PIZZA SOLD 
SELECT TOP 5 pizza_name, SUM(quantity) AS Pizza_Sold 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY Pizza_Sold ASC 