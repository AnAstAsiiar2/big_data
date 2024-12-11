-- Create the database
CREATE DATABASE Goods;
GO

USE Goods;
GO

-- Table for storing goods information
CREATE TABLE Goods (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    unit_measure VARCHAR(50) NOT NULL,
    years_expiration FLOAT NOT NULL,
    purchase_price DECIMAL(10, 2) NOT NULL,
    sale_price DECIMAL(10, 2) NOT NULL
);

-- Table for storing person information (common for both customers and providers)
CREATE TABLE Person (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(60) NOT NULL,
    category VARCHAR(50) NOT NULL,
    discount_percent DECIMAL(5, 2) NOT NULL
);

-- Table for storing operations related to goods
CREATE TABLE Operations (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    date DATE NOT NULL,
    product_id BIGINT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Goods(id) ON DELETE CASCADE
);

-- Table for providers
CREATE TABLE Provider (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    person_id BIGINT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES Person(id) ON DELETE CASCADE
);

-- Table for customers
CREATE TABLE Customer (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    person_id BIGINT NOT NULL,
    debt DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES Person(id) ON DELETE CASCADE
);

-- Table for payments to providers
CREATE TABLE Payment_To_Provider (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    operation_id BIGINT NOT NULL,
    provider_id BIGINT NOT NULL,
    FOREIGN KEY (operation_id) REFERENCES Operations(id) ON DELETE CASCADE,
    FOREIGN KEY (provider_id) REFERENCES Provider(id) ON DELETE CASCADE
);

-- Table for payments from customers
CREATE TABLE Payment_From_Customer (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    operation_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    FOREIGN KEY (operation_id) REFERENCES Operations(id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES Customer(id) ON DELETE CASCADE
);
GO
