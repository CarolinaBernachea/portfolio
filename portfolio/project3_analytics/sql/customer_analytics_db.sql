/*
========================================
PROJECT 3
Customer Intelligence & Segmentation
========================================

This project simulates a customer analytics platform focused on behavior segmentation.

It enables analysis of:
- Customer purchase frequency
- Total revenue per customer
- Customer activity over time
- Identification of high-value and at-risk customers
- Behavioral segmentation (VIP, Regular, Low, At Risk)

**PROJECT OBJECTIVE**

To answer business questions such as:
- Who are the most valuable customers?
- Which customers are inactive or at risk?
- How is revenue distributed across customer segments?
- Which cities have the highest-value customers?
- How does customer behavior evolve over time?

-- Focus: customer analytics and segmentation for business decision-making

*/


-- =====================================
-- DATABASE CREATION
-- =====================================

CREATE DATABASE customer_analytics_db;
GO

USE customer_analytics_db;
GO

-- =====================================
-- TABLES
-- =====================================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    registration_date DATE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


-- =====================================
-- DATA INSERTS
-- =====================================

INSERT INTO customers VALUES
(1, 'Juan Perez', 'Montevideo', '2023-01-10'),
(2, 'Maria Lopez', 'Montevideo', '2023-03-15'),
(3, 'Carlos Diaz', 'Canelones', '2023-02-20'),
(4, 'Ana Torres', 'Maldonado', '2023-04-05'),
(5, 'Luis Gomez', 'Salto', '2023-01-25'),
(6, 'Sofia Ruiz', 'Montevideo', '2023-05-12'),
(7, 'Pedro Silva', 'Canelones', '2023-06-18'),
(8, 'Lucia Fernandez', 'Maldonado', '2023-07-22'),
(9, 'Diego Morales', 'Montevideo', '2025-12-01'),
(10, 'Valentina Perez', 'Canelones', '2026-01-15'),
(11, 'Martin Suarez', 'Salto', '2025-11-20'),
(12, 'Camila Rodriguez', 'Maldonado', '2026-02-10');
(13, 'Nicolas Cabrera', 'Rivera', '2023-02-10'),
(14, 'Florencia Acosta', 'Colonia', '2023-05-15'),
(15, 'Gonzalo Pereira', 'Rocha', '2023-08-20'),
(16, 'Luciana Mendez', 'Rivera', '2024-01-12'),
(17, 'Bruno Silva', 'Colonia', '2024-03-18'),
(18, 'Carla Techera', 'Rocha', '2024-06-25');

INSERT INTO orders VALUES
(1, 1, '2024-01-10', 120),
(2, 1, '2024-02-15', 250),
(3, 1, '2024-03-10', 300),
(4, 2, '2024-02-05', 80),
(5, 2, '2024-03-01', 90),
(6, 3, '2024-01-20', 500),
(7, 3, '2024-03-22', 700),
(8, 4, '2024-02-11', 50),
(9, 5, '2024-01-05', 1000),
(10, 5, '2024-02-07', 1200),
(11, 5, '2024-03-10', 1500),
(12, 6, '2024-03-15', 200),
(13, 7, '2024-01-18', 150),
(14, 7, '2024-02-20', 180),
(15, 8, '2024-03-25', 60),
(16, 8, '2024-04-01', 20),
(17, 1, '2026-02-15', 900),
(18, 1, '2026-03-10', 1000),
(19, 2, '2026-02-01', 400),
(20, 2, '2026-03-01', 450),
(21, 6, '2026-03-20', 50),
(22, 8, '2026-04-01', 60),
(23, 1, '2026-04-10', 750),
(24, 1, '2026-05-12', 820),
(25, 1, '2026-06-18', 910),
(26, 2, '2026-04-02', 300),
(27, 2, '2026-05-10', 280),
(28, 3, '2026-04-15', 900),
(29, 3, '2026-05-20', 950),
(30, 5, '2026-04-05', 1200),
(31, 5, '2026-05-15', 1400),
(32, 6, '2026-04-10', 300),
(33, 6, '2026-05-01', 350),
(34, 7, '2026-06-01', 200),
(35, 8, '2026-05-01', 90),
(36, 8, '2026-06-01', 70),
(44, 13, '2023-03-01', 120),
(45, 14, '2023-06-10', 300),
(46, 15, '2023-09-05', 80),
(47, 13, '2024-02-15', 200),
(48, 14, '2024-07-01', 450),
(49, 16, '2024-03-10', 150),
(50, 17, '2024-05-22', 600),
(51, 18, '2024-08-18', 90),
(52, 13, '2025-01-10', 300),
(53, 14, '2025-04-12', 500),
(54, 15, '2025-06-20', 120),
(55, 16, '2025-02-14', 400),
(56, 17, '2025-07-30', 700),
(57, 18, '2025-09-05', 150);

INSERT INTO orders VALUES
(58, 13, '2026-03-01', 600),
(59, 14, '2026-04-10', 800),
(60, 15, '2026-05-15', 200),
(61, 16, '2026-02-10', 350),
(62, 17, '2026-06-01', 900),
(63, 18, '2026-07-20', 250);

-- ====================================
-- UPDATES POST 1ST TESTS (if necessary)
-- ====================================

UPDATE customers
SET city = 'Lavalleja'
WHERE city = 'San Jose';

-- =====================================
-- QUERIES
-- =====================================


-- Customer Aggregation

SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_spent,
    MAX(o.order_date) AS last_order_date,
    AVG(o.amount) AS avg_order_value
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.city;

-- Customer Segmentation

SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_spent,
    MAX(o.order_date) AS last_order_date,

    CASE 
        WHEN SUM(o.amount) >= 2000 AND COUNT(o.order_id) >= 3 THEN 'VIP'
        WHEN SUM(o.amount) >= 800 THEN 'Regular'
        WHEN MAX(o.order_date) < DATEADD(DAY, -60, GETDATE()) THEN 'At Risk'
        ELSE 'Low Value'
    END AS segment

FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.city;