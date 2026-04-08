/*

PROYECTO 1 
Retail Sales Analysis

Simulamos un negocio chico tipo super de barrio

Vamos a mostrar:
- Ventas
- Productos
- Stock
- Comportamiento de clientes

**OBJETIVO DEL PROYECTO**

Poder responder a:
¿Qué productos se venden más?
¿Qué días se vende más?
¿Qué categoría deja más plata?
¿Hay productos con bajo movimiento?

*/ 

-- =====================================
-- DATABASE CREATION
-- =====================================

CREATE DATABASE retail_db;
GO

USE retail_db;

-- =====================================
-- TABLES
-- =====================================

-- categories
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- products

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- customers

CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
	name VARCHAR(100),
	city VARCHAR(50)
);

-- sales

CREATE TABLE sales (
	sale_id INT PRIMARY KEY,
	customer_id INT,
	sale_date DATETIME,
	total_amount DECIMAL(10,2),
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- sales items

CREATE TABLE sales_items (
	id INT PRIMARY KEY,
	sale_id INT,
	product_id INT,
	quantity INT,
	price DECIMAL(10,2),
	FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
	FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- =====================================
-- DATA INSERTS
-- =====================================

INSERT INTO categories VALUES
(1, 'Beverages'),
(2, 'Food'),
(3, 'Cleaning');

INSERT INTO products VALUES
(1, 'Coca Cola', 1, 2.50),
(2, 'Mineral Water', 1, 1.20),
(3, 'Rice', 2, 3.00),
(4, 'Pasta', 2, 2.80),
(5, 'Laundry Detergent', 3, 1.90);

INSERT INTO customers VALUES
(1, 'Juan Perez', 'CABA'),
(2, 'Maria Lopez', 'CABA'),
(3, 'Carlos Diaz', 'Ciudadela');

INSERT INTO sales VALUES
(1, 1, '2024-01-01', 5.00),
(2, 2, '2024-01-02', 6.50),
(3, 3, '2024-01-02', 3.00);

INSERT INTO sales_items VALUES
(1, 1, 1, 2, 2.50),
(2, 2, 3, 1, 3.00),
(3, 2, 4, 1, 3.50),
(4, 3, 2, 2, 1.50);

INSERT INTO sales VALUES
(4, 1, '2023-11-15', 10.00),
(5, 2, '2023-12-20', 8.50),
(6, 1, '2024-03-10', 12.00),
(7, 3, '2024-06-05', 7.80),
(8, 2, '2025-01-12', 15.00),
(9, 1, '2025-02-18', 9.20);

INSERT INTO sales_items VALUES
(5, 4, 1, 4, 2.50),
(6, 5, 3, 2, 3.00),
(7, 6, 4, 3, 2.80),
(8, 7, 2, 5, 1.20),
(9, 8, 1, 6, 2.50),
(10, 9, 5, 3, 1.90);

-- =====================================
-- QUERIES
-- =====================================

-- Sales by product
SELECT
    p.name,
    SUM(si.quantity) AS total_sold
FROM sales_items si
JOIN products p ON si.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC;

-- Sales by category
SELECT
    c.name,
    SUM(si.quantity * si.price) AS total_revenue
FROM sales_items si
JOIN products p ON si.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.name
ORDER BY total_revenue DESC;

-- Sales by day
SELECT
    CAST(sale_date AS DATE) AS date,
    SUM(total_amount) AS total_sales
FROM sales
GROUP BY CAST(sale_date AS DATE)
ORDER BY date;
