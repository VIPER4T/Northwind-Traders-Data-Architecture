-- Confirm you are using the correct account
SELECT CURRENT_USER();

-- Confirm you can see all the data
SELECT COUNT(*) from categories;

-- Check the day greater than 12
SELECT OrderDate 
FROM orders 
WHERE DAY(OrderDate) > 12 
LIMIT 5;

-- Checking dayname and monthname in the date format
SELECT 
    OrderDate AS Raw_Date,
    DAYNAME(OrderDate) AS Day_Name,
    MONTHNAME(OrderDate) AS Month_Name
FROM orders
WHERE OrderDate = '2011-07-04' 
LIMIT 1;

SELECT 
    OrderDate, 
    MONTH(OrderDate) AS Month_Num, 
    DAY(OrderDate) AS Day_Num 
FROM orders 
LIMIT 10;

-- Validating Foreign Key integrity between Orders and Order_Details
SELECT 
    COUNT(od.orderID) AS total_rows,
    SUM(od.unitPrice * od.quantity * (1 - od.discount)) AS validated_revenue
FROM northwind_db.order_details od
JOIN northwind_db.orders o ON od.orderID = o.orderID;

SELECT 
    COUNT(od.orderID) AS total_rows,
    SUM(od.unitPrice * od.quantity) AS validated_revenue
FROM northwind_db.order_details od
JOIN northwind_db.orders o ON od.orderID = o.orderID;