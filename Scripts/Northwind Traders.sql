-- Create a user for future steps
-- This creates a brand new user for your Power BI project
-- Choose a password you will definitely remember!
CREATE USER 'northwind_admin'@'localhost' IDENTIFIED BY 'Analytics2026!';

-- Give this new user full power over your new database
GRANT ALL PRIVILEGES ON northwind_db.* TO 'northwind_admin'@'localhost';

-- Apply the changes
FLUSH PRIVILEGES;

-- Checking the current user
SELECT current_user();
SELECT user, host, account_locked, password_last_changed 
FROM mysql.user
WHERE user = 'northwind_admin';



-- Using the database
USE northwind_db;

-- 1. Create Categories (No dependencies)
CREATE TABLE IF NOT EXISTS categories (
    categoryID INT PRIMARY KEY,
    categoryName VARCHAR(255),
    description TEXT
);

-- 2. Create Shippers (No dependencies)
CREATE TABLE IF NOT EXISTS shippers (
    shipperID INT PRIMARY KEY,
    companyName VARCHAR(255)
);

-- 3. Create Customers (customerID is a String in your CSV)
CREATE TABLE IF NOT EXISTS customers (
    customerID VARCHAR(10) PRIMARY KEY,
    companyName VARCHAR(255),
    contactName VARCHAR(255),
    contactTitle VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100)
);

-- 4. Create Employees
CREATE TABLE IF NOT EXISTS employees (
    employeeID INT PRIMARY KEY,
    employeeName VARCHAR(255),
    title VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100),
    reportsTo INT
);

-- 5. Create Products (Depends on Categories)
CREATE TABLE IF NOT EXISTS products (
    productID INT PRIMARY KEY,
    productName VARCHAR(255),
    quantityPerUnit VARCHAR(255),
    unitPrice DECIMAL(10, 2),
    discontinued INT,
    categoryID INT,
    FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);

-- 6. Create Orders (Depends on Customers, Employees, Shippers)
CREATE TABLE IF NOT EXISTS orders (
    orderID INT PRIMARY KEY,
    customerID VARCHAR(10),
    employeeID INT,
    orderDate DATE,
    requiredDate DATE,
    shippedDate DATE,
    shipperID INT,
    freight DECIMAL(10, 2),
    FOREIGN KEY (customerID) REFERENCES customers(customerID),
    FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
    FOREIGN KEY (shipperID) REFERENCES shippers(shipperID)
);

-- 7. Create Order Details (Depends on Orders and Products)
CREATE TABLE IF NOT EXISTS order_details (
    orderID INT,
    productID INT,
    unitPrice DECIMAL(10, 2),
    quantity INT,
    discount DECIMAL(10, 2),
    PRIMARY KEY (orderID, productID),
    FOREIGN KEY (orderID) REFERENCES orders(orderID),
    FOREIGN KEY (productID) REFERENCES products(productID)
);

-- NEXT PHASE
USE northwind_db;

-- 1. Categories
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/categories.csv' 
INTO TABLE categories
CHARACTER SET latin1 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 2. Shippers
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/shippers.csv' 
INTO TABLE shippers 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 3. Customers
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv' 
INTO TABLE customers
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 4. Employees
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employees.csv' 
INTO TABLE employees 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(employeeID, employeeName, title, city, country, @vreportsTo)
SET reportsTo = NULLIF(@vreportsTo, '');

-- 5. Products
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products.csv' 
INTO TABLE products 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 6. Orders
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv' 
INTO TABLE orders
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(orderID, customerID, employeeID, orderDate, requiredDate, @vshippedDate, shipperID, freight)
SET shippedDate = NULLIF(@vshippedDate, '');

-- 7. Order Details
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_details.csv' 
INTO TABLE order_details 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

USE northwind_db;

-- Delete data in reverse order of dependencies
SET FOREIGN_KEY_CHECKS = 0; -- Temporarily turn off the "Safety" to clean up
TRUNCATE TABLE order_details;
TRUNCATE TABLE orders;
TRUNCATE TABLE products;
SET FOREIGN_KEY_CHECKS = 1; -- Turn the "Safety" back on

-- Show counts of tables which were shown as 0
SELECT COUNT(*) as prd FROM products;
SELECT COUNT(*) as ord FROM orders;
SELECT COUNT(*) as ordeta FROM order_details;