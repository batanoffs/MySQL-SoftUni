CREATE TABLE people (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
    name VARCHAR(200) NOT NULL,
    picture TEXT,
    height DOUBLE NOT NULL,
    weight DOUBLE NOT NULL,
    height DOUBLE(10, 2),
    weight DOUBLE(10, 2),
    gender CHAR(1) NOT NULL,
    birthdate DATE NOT NULL,
    biography TEXT
);

INSERT INTO
    people
VALUES
    (1, 'Gosho', 'TEST', 1.9, 90, 'm', '1990-01-01', '123'),
    (2, 'Stamat', 'TEST', 1.9, 90, 'm', '1990-01-01', '123'),
    (3, 'Ivan', 'TEST', 1.9, 90, 'm', '1990-01-01', '123'),
    (4, 'Gosho', 'TEST', 1.9, 90, 'm', '1990-01-01', '123'),
    (5, 'Maria', 'TEST', 1.9, 90, 'f', '1990-01-01', '123');

CREATE DATABASE car_rental;

USE car_rental;

CREATE TABLE categories (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
    category VARCHAR(50),
    daily_rate DOUBLE(10, 2),
    weekly_rate DOUBLE(10, 2),
    monthly_rate DOUBLE(10, 2),
    weekend_rate DOUBLE(10, 2)
);

CREATE TABLE cars (
    id INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
    plate_number VARCHAR(10),
    make VARCHAR(50),
    model VARCHAR(50),
    car_year DATE,
    category_id INT,
    doors INT,
    picture BLOB,
    car_condition VARCHAR(50),
    available BOOLEAN
);

CREATE TABLE employees (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    title VARCHAR(50),
    notes TEXT
);

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
    driver_licence_number VARCHAR(50),
    full_name VARCHAR(50),
    address VARCHAR(50),
    city VARCHAR(50),
    zip_code INT,
    notes TEXT
);

CREATE TABLE rental_orders (
    id INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
    employee_id INT,
    customer_id INT,
    car_id INT,
    car_condition VARCHAR(50),
    tank_level DOUBLE(5, 2),
    kilometrage_start INT,
    kilometrage_end INT,
    total_kilometrage INT,
    start_date DATE,
    end_date DATE,
    total_days INT,
    rate_applied DOUBLE(5, 2),
    tax_rate DOUBLE(5, 2),
    order_status VARCHAR(50),
    notes TEXT
);

INSERT INTO
    categories (category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
VALUES
    ('test', 10, 20, 30, 40),
    ('test2', 15, 30, 45, 60),
    ('test3', 20, 40, 60, 80);

INSERT INTO
    cars (plate_number, make, model, car_year, category_id, doors, picture, car_condition, available)
VALUES
    ('test', 'test', 'test', '2020-01-01', 1, 4, 'test', 'test', TRUE),
    ('test2', 'test2', 'test2', '2020-01-01', 2, 4, 'test', 'test', TRUE),
    ('test3', 'test3', 'test3', '2020-01-01', 3, 4, 'test', 'test', TRUE);

INSERT INTO
    employees (first_name, last_name, title, notes)
VALUES
    ('test', 'test', 'test', 'test'),
    ('test2', 'test2', 'test2', 'test2'),
    ('test3', 'test3', 'test3', 'test3');

INSERT INTO
    customers (driver_licence_number, full_name, address, city, zip_code, notes)
VALUES
    ('test', 'test', 'test', 'test', 1, 'test'),
    ('test2', 'test2', 'test2', 'test2', 2, 'test2'),
    ('test3', 'test3', 'test3', 'test3', 3, 'test3');

INSERT INTO
    rental_orders (
        employee_id,
        customer_id,
        car_id,
        car_condition,
        tank_level,
        kilometrage_start,
        kilometrage_end,
        total_kilometrage,
        start_date,
        end_date,
        total_days,
        rate_applied,
        tax_rate,
        order_status,
        notes
    )
VALUES
    (1, 1, 1, 'test', 1, 1, 1, 1, '2020-01-01', '2020-01-01', 1, 1, 1, 'test', 'test'),
    (2, 2, 2, 'test2', 2, 2, 2, 2, '2020-01-01', '2020-01-01', 2, 2, 2, 'test2', 'test2'),
    (3, 3, 3, 'test3', 3, 3, 3, 3, '2020-01-01', '2020-01-01', 3, 3, 3, 'test3', 'test3');