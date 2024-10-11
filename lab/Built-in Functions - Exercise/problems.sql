-- 1. Find Names of All employees by First Name
SELECT first_name, last_name
FROM employees
WHERE substring(first_name, 1, 2) = 'Sa'
ORDER BY employee_id;
-- 2. Find Names of All employees by Last Name
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '%ei%'
ORDER BY employee_id;

-- 3. Find First Names of All employees
SELECT first_name
FROM employees
WHERE department_id IN (3, 10)
AND YEAR(hire_date) BETWEEN 1995 AND 2005
ORDER BY employee_id;

-- 4. Find All employees Except Engineers
SELECT first_name, last_name
FROM employees
WHERE job_title NOT LIKE '%engineer%'
ORDER BY employee_id;

-- 5. Find towns with Name Length
SELECT name 
FROM towns
WHERE LENGTH(name) IN (5, 6)
ORDER BY name;

-- 6.  Find towns Starting With
SELECT town_id, name 
FROM towns
WHERE LEFT (name, 1) IN ('M', 'K', 'B', 'E')
ORDER BY name;

-- 7.  Find towns Not Starting With
SELECT town_id, name FROM towns
WHERE LEFT(name, 1) NOT IN ('R', 'B', 'D')
ORDER BY name;

-- 8. Create View employees Hired After 2000 Year
CREATE VIEW v_employees_hired_after_2000 AS
SELECT first_name, last_name, hire_date FROM employees
WHERE YEAR(hire_date) > 2000;

SELECT * FROM v_employees_hired_after_2000;

-- 9. Length of Last Name
SELECT first_name, last_name 
FROM employees
WHERE LENGTH(last_name) = 5
ORDER BY employee_id;

-- 10. countries Holding 'A' 3 or More Times
SELECT country_name, iso_code
FROM countries
WHERE country_name LIKE 'aaa'
ORDER BY iso_code;

-- 11.  Mix of Peak and River Names
SELECT peak_name, river_name, LOWER(CONCAT(peak_name, SUBSTRING(river_name,2))) AS mix
FROM peaks, rivers
WHERE RIGHT(peak_name, 1) = LEFT(river_name, 1)
order by mix;

-- 12. Games from 2011 and 2012 Year
SELECT name, DATE_FORMAT(start, '%Y-%m-%d') AS start
FROM games
WHERE YEAR(start) BETWEEN 2011 AND 2012
ORDER BY start, name
LIMIT 50;

-- 13.  User Email Providers
SELECT user_name, SUBSTRING_INDEX(email, '@', -1) AS email
FROM users
ORDER BY email, user_name;

-- 14.  Get Users with IP Address Like Pattern
SELECT user_name, ip_address
FROM users
WHERE ip_address LIKE '___.1%.%.___'
ORDER BY user_name;

-- 15.  Show All Games with Duration and Part of the Day
SELECT name, 
    CASE 
        WHEN HOUR(start) < 12 THEN 'Morning'
        WHEN TIME(start) < 18 THEN 'Afternoon'
        WHEN TIME(start) < 24 THEN 'Evening'
    END AS 'Part of the Day',
    CASE
        WHEN duration <= 3 THEN 'Extra Short'
        WHEN duration <= 6 THEN 'Short'
        WHEN duration <= 10 THEN 'Long'
        ELSE 'Extra Long'
    END AS Duration
FROM games;
ORDER BY name;
-- 16.  Orders Table
SELECT product_name, order_date, DATE_ADD(order_date, INTERVAL 3 DAY) AS pay_due, DATE_ADD(order_date, INTERVAL 1 MONTH) AS deliver_due
FROM orders;