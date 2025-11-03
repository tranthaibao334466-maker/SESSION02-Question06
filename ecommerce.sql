-- E-Commerce Management System

CREATE TABLE ecommerce.Users(
    ID SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role VARCHAR(20) CHECK (role IN ('Customer', 'Admin'))
);

CREATE TABLE ecommerce.Categories(
    ID SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE ecommerce.Products(
    ID SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) CHECK (price > 0),
    stock INT CHECK (stock >= 0),
    category_id INT REFERENCES ecommerce.Categories(ID)
);

CREATE TABLE ecommerce.Orders(
    ID SERIAL PRIMARY KEY,
    user_id INT REFERENCES ecommerce.Users(ID),
    order_date DATE NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE ecommerce.OrederDetails(
    ID SERIAL PRIMARY KEY,
    order_id INT REFERENCES ecommerce.Orders(ID),
    product_id INT REFERENCES ecommerce.Products(ID),
    quantity INT CHECK (quantity > 0),
    price_each NUMERIC(10,2) CHECK (price_each > 0) 
);

CREATE TABLE ecommerce.Payments(
    ID SERIAL PRIMARY KEY,
    order_id INT REFERENCES ecommerce.Orders(ID),
    amount NUMERIC(10,2) CHECK (amount >= 0),
    payment_date DATE NOT NULL,
    method VARCHAR(30) CHECK (method IN ('Credit Card', 'Momo', 'Bank Transfer','Cash'))
);