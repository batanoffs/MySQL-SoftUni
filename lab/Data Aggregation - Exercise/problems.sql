-- 1.  Records' Count
SELECT COUNT(*) AS count
FROM gringotts;

-- 2.  Longest Magic Wand
SELECT MAX(size) AS longest_magic_wand
FROM wands;

-- 3. Longest Magic Wand Per Deposit Groups
SELECT deposit_group, MAX(magic_wand_size) AS longest_magic_wand
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY longest_magic_wand, deposit_group;

-- 4. Smallest Deposit Group Per Magic Wand Size
SELECT deposit_group FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY AVG(magic_wand_size)
LIMIT 1;

-- 5.  Deposits Sum
SELECT deposit_group, SUM(deposit_amount) AS total_sum
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY total_sum;

-- 6. Deposits Sum for Ollivander Family
SELECT deposit_group, SUM(deposit_amount) AS total_sum
FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
ORDER BY deposit_group;

-- 7.  deposits Filter
SELECT deposit_group, SUM(deposit_amount) AS total_sum
FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
HAVING SUM(deposit_amount) < 150000
ORDER BY total_sum DESC;

-- 8. Deposit Charge
SELECT deposit_group, magic_wand_creator, MIN(deposit_charge) AS min_deposit_charge
FROM wizzard_deposits
GROUP BY deposit_group, magic_wand_creator
ORDER BY magic_wand_creator, deposit_group;

-- 9. Age Groups
SELECT 
case 
    when age <= 10 then '[0-10]'
    when age <= 20 then '[11-20]'
    when age <= 30 then '[21-30]'
    when age <= 40 then '[31-40]'
    when age <= 50 then '[41-50]'
    when age <= 60 then '[51-60]'
    when age > 60 then '[61+]'
end as age_group,
COUNT(*) AS wizard_count
FROM wizzard_deposits
GROUP BY age_group;

-- 10. First Letter
SELECT SUBSTRING(first_name, 1, 1) AS first_letter
FROM wizzard_deposits
WHERE deposit_group = 'Troll Chest'
GROUP BY first_letter
ORDER BY first_letter;

-- 11. Average Interest
SELECT deposit_group, is_deposit_expired, AVG(interest_rate) AS average_interest
FROM wizzard_deposits
WHERE start_date > '1985-01-01'
GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group DESC, is_deposit_expired;

-- 12.  Employees Minimum Salaries
SELECT department_id, MIN(salary) AS minimum_salary
FROM employees
WHERE department_id IN (2, 5, 7) AND hire_date > '2000-01-01'
GROUP BY department_id
ORDER BY department_id;
-- 13.  Employees Average Salaries
create table high_paid_employees
select * from employees
where salary > 30000;

delete from high_paid_employees
where manager_id = 42;

update high_paid_employees
set salary = salary + 5000
where department_id = 1;

select department_id, AVG(salary) as avg_salary from high_paid_employees
group by department_id
order by department_id;

-- 14. Employees Maximum Salaries
SELECT department_id, MAX(salary) AS max_salary
FROM employees
WHERE salary NOT BETWEEN 30000 AND 70000
GROUP BY department_id
ORDER BY department_id;

-- 15.  Employees Count Salaries
SELECT COUNT(*) AS count
FROM employees
WHERE manager_id IS NULL;

-- 16. 3rd Highest Salary
SELECT department_id, MAX(salary) AS third_highest_salary
FROM (
	SELECT department_id, salary, DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank
	FROM employees
) AS salary_rank
WHERE rank = 3
GROUP BY department_id
ORDER BY department_id;

-- 17.  Salary Challenge
SELECT first_name, last_name, department_id
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = employees.department_id)
ORDER BY department_id, employee_id
LIMIT 10;

-- 18.  Departments Total Salaries
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
ORDER BY department_id;
