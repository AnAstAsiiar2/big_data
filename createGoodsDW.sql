-- ��������� ���� ����� GoodsDW
CREATE DATABASE GoodsDW;
GO

USE GoodsDW;
GO

-- ������� ����� ��� ������
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

-- ������� ����� ��� ��� (�볺��� �� �������������)
CREATE TABLE Dim_Person (
    person_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(60) NOT NULL,
    category VARCHAR(50) NOT NULL,
    discount_percent DECIMAL(5, 2) NOT NULL,
    person_key BIGINT NOT NULL
);

-- ������� ����� ��� ���
CREATE TABLE Dim_Date (
    date_id INT IDENTITY(1,1) PRIMARY KEY,
    date DATE NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL
);

-- ������� �������, �� ��'���� �� ��������, ������ �� ���� �������� ���
CREATE TABLE Fact_Goods (
    fact_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    goods_id BIGINT,                    -- ID ������
    person_id BIGINT,                   -- ID ����� (�볺��/������������)
    date_id INT,                        -- ID ���� ��������
    operation_type VARCHAR(50),         -- ��� �������� (Purchase, Sale, Write-off, Payment)
    amount INT,                         -- ʳ������ ������
    total_value DECIMAL(15, 2),         -- �������� ���� �������� (amount * ����)
    payment_amount DECIMAL(15, 2),      -- ���� ������
    payment_type VARCHAR(50) NULL,           -- ��� ������ (To Provider, From Customer)
    debt DECIMAL(10, 2),                -- ���� �볺��� (����� ��� �������� � �볺�����)
    FOREIGN KEY (goods_id) REFERENCES Dim_Goods(goods_id),
    FOREIGN KEY (person_id) REFERENCES Dim_Person(person_id),
    FOREIGN KEY (date_id) REFERENCES Dim_Date(date_id)
);
GO
