-- Створення бази даних GoodsDW
CREATE DATABASE GoodsDW;
GO

USE GoodsDW;
GO

-- Таблиця вимірів для товарів
CREATE TABLE Dim_Goods (
    goods_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    unit_measure VARCHAR(50) NOT NULL,
    years_expiration FLOAT NOT NULL,
    purchase_price DECIMAL(10, 2) NOT NULL,
    sale_price DECIMAL(10, 2) NOT NULL,
    goods_key BIGINT NOT NULL
);

-- Таблиця вимірів для осіб (клієнтів та постачальників)
CREATE TABLE Dim_Person (
    person_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(60) NOT NULL,
    category VARCHAR(50) NOT NULL,
    discount_percent DECIMAL(5, 2) NOT NULL,
    person_key BIGINT NOT NULL
);

-- Таблиця вимірів для дат
CREATE TABLE Dim_Date (
    date_id INT IDENTITY(1,1) PRIMARY KEY,
    date DATE NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL
);

-- Фактова таблиця, що об'єднує всі операції, оплати та інші необхідні дані
CREATE TABLE Fact_Goods (
    fact_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    goods_id BIGINT,                    -- ID товару
    person_id BIGINT,                   -- ID особи (клієнт/постачальник)
    date_id INT,                        -- ID дати операції
    operation_type VARCHAR(50),         -- Тип операції (Purchase, Sale, Write-off, Payment)
    amount INT,                         -- Кількість товару
    total_value DECIMAL(15, 2),         -- Загальна сума операції (amount * ціна)
    payment_amount DECIMAL(15, 2),      -- Сума оплати
    payment_type VARCHAR(50) NULL,           -- Тип оплати (To Provider, From Customer)
    debt DECIMAL(10, 2),                -- Борг клієнта (тільки для операцій з клієнтами)
    FOREIGN KEY (goods_id) REFERENCES Dim_Goods(goods_id),
    FOREIGN KEY (person_id) REFERENCES Dim_Person(person_id),
    FOREIGN KEY (date_id) REFERENCES Dim_Date(date_id)
);
GO
