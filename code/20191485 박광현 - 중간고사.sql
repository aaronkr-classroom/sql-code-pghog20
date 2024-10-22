-- 1.테이블 생성하기 (4개)
-- 2.조인문 사용하기 (3개)
-- 3.SELECT문 사용해서 테이블 출력하기(3개)


-- 첫 번째 테이블: 고객 (Customer) - 고객정보를 담고있는 테이블
CREATE TABLE Customer (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20)
);

--고객 테이블에 값 추가
INSERT INTO Customer (FirstName, LastName, Email, PhoneNumber) 
VALUES 
('John', 'Doe', 'john.doe@example.com', '123-456-7890'),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210');

-- 두 번째 테이블: 제품 (Product) - 제품정보 저장 테이블
CREATE TABLE Product (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    Stock INT
);

--제품 테이블에 값추가
INSERT INTO Product (ProductName, Price, Stock) 
VALUES 
('Laptop', 1500.00, 100),
('Smartphone', 800.00, 50),
('Headphones', 200.00, 150);

-- 세 번째 테이블: 주문 (Order) - 주문정보(고객, 날짜, 총금액)을 담은 테이블
CREATE TABLE "Order" (
    OrderID SERIAL PRIMARY KEY,
    CustomerID INT REFERENCES Customer(CustomerID),
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2)
);

--주문 테이블에 값추가
INSERT INTO "Order" (CustomerID, OrderDate, TotalAmount) 
VALUES 
(1, '2024-10-01', 2300.00),
(2, '2024-10-02', 1000.00);

-- 네 번째 테이블: 주문 상세 (OrderDetail) -각 주문의 제품 상세 정보를 저장하며, 하나의 주문에 여러 제품이 있을 수 있습니다.
CREATE TABLE OrderDetail (
    OrderDetailID SERIAL PRIMARY KEY,
    OrderID INT REFERENCES "Order"(OrderID),
    ProductID INT REFERENCES Product(ProductID),
    Quantity INT,
    UnitPrice DECIMAL(10, 2)
);

--주문상세 테이블에 값추가
INSERT INTO OrderDetail (OrderID, ProductID, Quantity, UnitPrice) 
VALUES 
(1, 1, 1, 1500.00),  -- 첫 번째 주문에 1개의 Laptop 구매
(1, 3, 4, 200.00),   -- 첫 번째 주문에 4개의 Headphones 구매
(2, 2, 1, 800.00);   -- 두 번째 주문에 1개의 Smartphone 구매

--고객과 주문을 조인
SELECT 
    Customer.CustomerID,
    Customer.FirstName,
    Customer.LastName,
    "Order".OrderID,
    "Order".OrderDate,
    "Order".TotalAmount
FROM 
    Customer
JOIN 
    "Order" ON Customer.CustomerID = "Order".CustomerID;


--주문과 주문상세를 조인
SELECT 
    "Order".OrderID,
    "Order".OrderDate,
    OrderDetail.OrderDetailID,
    OrderDetail.ProductID,
    OrderDetail.Quantity,
    OrderDetail.UnitPrice
FROM 
    "Order"
JOIN 
    OrderDetail ON "Order".OrderID = OrderDetail.OrderID;



--주문상세와 제품을 조인
SELECT 
    OrderDetail.OrderDetailID,
    Product.ProductName,
    Product.Price,
    OrderDetail.Quantity,
    OrderDetail.UnitPrice
FROM 
    OrderDetail
JOIN 
    Product ON OrderDetail.ProductID = Product.ProductID;


--특정 고객의 정보 조회
SELECT 
    FirstName, 
    LastName, 
    Email
FROM 
    Customer
WHERE 
    CustomerID = 1;

--제품 재고가 50개 이상인 제품 조회
SELECT 
    ProductName, 
    Price
FROM 
    Product
WHERE 
    Stock >= 50;


--특정 주문의 주문 상세 조회
SELECT 
    OrderDetailID, 
    ProductID, 
    Quantity, 
    UnitPrice
FROM 
    OrderDetail
WHERE 
    OrderID = 1;