# 1. One-To-One Relationship
CREATE TABLE passports (
    passport_id INT PRIMARY KEY AUTO_INCREMENT,
    passport_number VARCHAR(8) UNIQUE
);

CREATE TABLE people (
    person_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30),
    salary DECIMAL(16,2),
    passport_id INT UNIQUE,
    FOREIGN KEY (passport_id)
    REFERENCES passports(passport_id)
);

INSERT INTO passports VALUES 
    (102, 'K65LO4R7'),
    (103, 'ZE657QP2'),
    (101, 'N34FG21B');

INSERT INTO people VALUES 
    (1, 'Roberto', 43300.00, 102),
    (2, 'Tom', 56100.00, 103),
    (3, 'Yana', 60200.00, 101);

# 2. One-To-Many Relationship
CREATE TABLE manufacturers (
    manufacturer_id INT PRIMARY KEY,
    name VARCHAR(50),
    established_on DATE
);

INSERT INTO manufacturers VALUES
    (1, 'BMW', '1916-03-01'),
    (2, 'Tesla', '2003-01-01'),
    (3, 'Lada', '1966-05-01');

CREATE TABLE models (
    model_id INT PRIMARY KEY,
    name VARCHAR(50),
    manufacturer_id INT,
    FOREIGN KEY (manufacturer_id)
    REFERENCES manufacturers(manufacturer_id)
);

ALTER TABLE models
ADD CONSTRAINT fk_models_manufacturers
FOREIGN KEY (manufacturer_id)
REFERENCES manufacturers(manufacturer_id);

# 3. Many-To-Many Relationship
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE exams (
    exam_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE students_exams (
    student_id INT,
    exam_id INT,
    PRIMARY KEY (student_id, exam_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
);

INSERT INTO students (student_id, name)
VALUES
    (1, 'Mila'),
    (2, 'Toni'),
    (3, 'Ron');

INSERT INTO exams (exam_id, name)
VALUES
    (101, 'Spring MVC'),
    (102, 'Neo4j'),
    (103, 'Oracle 11g');

INSERT INTO students_exams (student_id, exam_id)
VALUES
    (1, 101),
    (1, 102),
    (2, 101),
    (3, 103),
    (2, 102),
    (2, 103);

# 4. Self-Referencing
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT
);

ALTER TABLE teachers
ADD CONSTRAINT fk_teachers_teachers
FOREIGN KEY (name)
REFERENCES teachers(name);

# 5. Online Store Database
CREATE DATABASE online_store;

USE online_store;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE
);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);

# 6. University Database
CREATE DATABASE university;

USE university;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE student_courses (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id)
);

ALTER TABLE student_courses
ADD CONSTRAINT fk_student_courses_students
FOREIGN KEY (student_id)
REFERENCES students(student_id);

ALTER TABLE student_courses
ADD CONSTRAINT fk_student_courses_courses
FOREIGN KEY (course_id)
REFERENCES courses(course_id);

# 7. SoftUni Design
CREATE DATABASE softuni;

USE softuni;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    manager_id INT
);

ALTER TABLE employees
ADD CONSTRAINT fk_employees_employees
FOREIGN KEY (manager_id)
REFERENCES employees(employee_id);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT
);

ALTER TABLE departments
ADD CONSTRAINT fk_departments_employees
FOREIGN KEY (manager_id)
REFERENCES employees(employee_id);

# 8. Geography Design
CREATE DATABASE geography;

USE geography;

CREATE TABLE countries (
    country_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE mountains (
    mountain_id INT PRIMARY KEY,
    name VARCHAR(50),
    country_id INT
);

ALTER TABLE mountains
ADD CONSTRAINT fk_mountains_countries
FOREIGN KEY (country_id)
REFERENCES countries(country_id);

CREATE TABLE peaks (
    peak_id INT PRIMARY KEY,
    name VARCHAR(50),
    elevation INT,
    mountain_id INT
);

ALTER TABLE peaks
ADD CONSTRAINT fk_peaks_mountains
FOREIGN KEY (mountain_id)
REFERENCES mountains(mountain_id);

# 9. Peaks in Rila
SELECT m.name AS mountain_range, p.name AS peak_name, p.elevation AS peak_elevation
FROM mountains m
JOIN peaks p ON m.mountain_id = p.mountain_id
WHERE m.name = 'Rila'
ORDER BY p.elevation DESC;
