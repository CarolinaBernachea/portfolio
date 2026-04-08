/*
========================================
PROJECT 2
Delivery Analytics — Geolocation Dashboard
========================================

This project simulates a delivery analytics platform focused on geospatial data.

It enables analysis of:
- Orders by location (latitude / longitude)
- Order distribution across cities or zones
- Demand patterns over time
- Identification of high-activity and low-activity areas

**PROJECT OBJECTIVE**

To answer business questions such as:
- Which areas concentrate the highest number of orders?
- Which zones generate the highest revenue?
- How does demand vary by location?
- Are there underserved or low-activity areas?
- How do orders evolve over time?

-- Focus: geospatial analytics applied to delivery operations

*/ 

-- =====================================
-- DATABASE CREATION
-- =====================================

CREATE DATABASE delivery_db;
GO

USE delivery_db;

-- =====================================
-- TABLES
-- =====================================

-- customers
CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
	name VARCHAR(100),
	city VARCHAR(50),
	latitude DECIMAL(9,6),
	longitude DECIMAL(9,6)
);

-- orders
CREATE TABLE orders (
	order_id INT PRIMARY KEY,
	customer_id INT,
	order_date DATE,
	total_amount DECIMAL(10,2),
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- =====================================
-- DATA INSERTS
-- =====================================

INSERT INTO customers VALUES
(1, 'Juan Perez', 'Montevideo', -34.9011, -56.1645),
(2, 'Maria Lopez', 'Montevideo', -34.9033, -56.1882),
(3, 'Carlos Diaz', 'Montevideo', -34.8895, -56.1500),
(4, 'Ana Gomez', 'Montevideo', -34.9200, -56.1700),
(5, 'Luis Torres', 'Montevideo', -34.9050, -56.1400);
(6, 'Sofia Ramirez', 'Montevideo', -34.9100, -56.2000),
(7, 'Diego Fernandez', 'Montevideo', -34.8800, -56.1600),
(8, 'Lucia Martinez', 'Montevideo', -34.8950, -56.1800),
(9, 'Pedro Silva', 'Montevideo', -34.9150, -56.1550),
(10, 'Valentina Cruz', 'Montevideo', -34.9000, -56.1300),
(11, 'Martin Lopez', 'Montevideo', -34.8700, -56.1700),
(12, 'Camila Torres', 'Montevideo', -34.9050, -56.2100),
(13, 'Jorge Diaz', 'Montevideo', -34.9200, -56.1450),
(14, 'Florencia Ruiz', 'Montevideo', -34.8900, -56.1900),
(15, 'Nicolas Castro', 'Montevideo', -34.8750, -56.1400);

INSERT INTO orders VALUES
(1, 1, '2024-01-10', 15.50),
(2, 2, '2024-01-12', 22.00),
(3, 3, '2024-02-05', 18.75),
(4, 1, '2024-02-10', 30.00),
(5, 4, '2024-03-01', 12.00),
(6, 5, '2024-03-15', 25.00);
(7, 2, '2023-11-15', 18.50),
(8, 3, '2023-12-20', 25.00),
(9, 4, '2024-01-05', 12.75),
(10, 5, '2024-01-18', 30.20),
(11, 1, '2024-02-10', 22.40),
(12, 6, '2024-03-02', 15.90),
(13, 7, '2024-03-25', 40.00),
(14, 8, '2024-04-10', 19.30),
(15, 9, '2024-05-01', 27.80),
(16, 10, '2024-06-12', 33.00),
(17, 11, '2024-07-22', 21.00),
(18, 12, '2024-08-14', 45.60),
(19, 13, '2024-09-03', 17.20),
(20, 14, '2024-10-11', 29.90),
(21, 15, '2024-11-27', 38.75),
(22, 6, '2024-12-05', 26.40),
(23, 7, '2025-01-09', 14.00),
(24, 8, '2025-02-17', 31.50),
(25, 9, '2025-03-21', 22.00),
(26, 10, '2025-04-02', 48.30),
(27, 11, '2025-05-15', 36.80),
(28, 12, '2025-06-28', 19.90),
(29, 13, '2025-07-19', 27.00),
(30, 14, '2025-08-23', 34.10),
(31, 15, '2025-09-30', 41.00),
(32, 1, '2025-10-12', 23.50),
(33, 2, '2025-11-07', 16.75),
(34, 3, '2025-12-18', 39.20),
(35, 4, '2026-01-10', 28.00),
(36, 5, '2026-02-14', 32.60),
(37, 6, '2026-03-03', 20.50),
(38, 7, '2026-03-25', 44.90),
(39, 8, '2026-04-01', 18.80),
(40, 1, '2026-04-02', 12.00),
(41, 1, '2026-04-03', 18.00),
(42, 1, '2026-04-04', 22.00),
(43, 2, '2026-04-02', 10.00),
(44, 3, '2026-04-01', 50.00),
(45, 3, '2026-04-02', 45.00),
(46, 4, '2026-03-28', 15.00),
(47, 5, '2026-04-05', 60.00),
(48, 5, '2026-04-06', 55.00),
(49, 5, '2026-04-07', 40.00),
(50, 6, '2026-04-03', 12.00),
(51, 7, '2026-04-04', 70.00),
(52, 7, '2026-04-05', 80.00),
(53, 8, '2026-04-01', 20.00),
(54, 9, '2026-04-02', 18.00),
(55, 10, '2026-04-06', 90.00);

-- ====================================
-- UPDATES POST 1ST TESTS
-- ====================================

UPDATE customers SET city = 'Canelones' WHERE customer_id IN (2, 5, 9);
UPDATE customers SET city = 'Maldonado' WHERE customer_id IN (3, 7, 12);
UPDATE customers SET city = 'Colonia' WHERE customer_id IN (4, 8);
UPDATE customers SET city = 'Salto' WHERE customer_id IN (10, 14);

-- Canelones
UPDATE customers SET latitude = -34.5228, longitude = -56.2778 WHERE city = 'Canelones';

-- Maldonado
UPDATE customers SET latitude = -34.9010, longitude = -54.9500 WHERE city = 'Maldonado';

-- Colonia
UPDATE customers SET latitude = -34.4626, longitude = -57.8398 WHERE city = 'Colonia';

-- Salto
UPDATE customers SET latitude = -31.3833, longitude = -57.9667 WHERE city = 'Salto';

-- =====================================
-- QUERIES
-- =====================================

-- Revenue by City
SELECT
	c.city,
	COUNT(o.order_id) AS total_orders,
	SUM(o.total_amount) AS total_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- Revenue by Location
SELECT
	c.city,
	COUNT(o.order_id) AS total_orders,
	SUM(o.total_amount) AS total_revenue
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY
	c.city
ORDER BY total_revenue DESC;

-- Sales Trend Over Time
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY 
    YEAR(order_date),
    MONTH(order_date)
ORDER BY 
    year DESC,
    month;

-- TOP Clients
SELECT
	c.name,
	COUNT(o.order_id) AS total_orders,
	SUM(o.total_amount) AS total_spent
FROM orders o 
LEFT JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.name
ORDER BY total_spent DESC; 