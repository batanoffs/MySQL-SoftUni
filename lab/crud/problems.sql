select * from departments
order by department_id;

select name from depapartments
order by department_id;

select first_name, last_name, salary from employees
order by employee_id;

select first_name, middle_name, last_name from employees
order by employee_id;

select concat(first_name,'.', last_name, '@softuni.bg') as `full_ email_address` from employees;

select distinct salary from employees;

select * from employees
where job_title="Sales Representative"
order by employee_id;

select first_name, last_name, job_title from employees
where salary between 20000 and 30000
order by employee_id;

select concat(first_name, ' ', middle_name, ' ', last_name) as `full_name` from employees
where salary in (25000, 14000, 12500, 23600);

select first_name, last_name from employees
where manager_id is null;

select first_name, last_name, salary from employees
where salary > 50000
order by salary desc;

select first_name, last_name from employees
order by salary desc
limit 5;

select first_name, last_name from employees
where department_id <> 4;

select * from employees
order by salary desc, first_name asc, last_name desc, middle_name asc, employee_id;

create view v_employees_salaries as
select first_name, last_name, salary from employees;

create view v_employees_job_titles as
select concat(first_name, if(middle_name is null, '', concat(' ', middle_name)), ' ', last_name) as full_name, job_title
from employees;

select distinct job_title
from employees
order by job_title;

select * from projects
order by start_date, name, project_id
limit 10;

select first_name, last_name, hire_date from employees
order by hire_date desc
limit 7;

update employees
set salary = salary * 1.12
where department_id in (1, 2, 4, 11);

select salary from employees;

select peak_name from peaks
order by peak_name;


select country_name, population
from countries
where continent_code = 'EU'
order by population desc, country_name asc
limit 30;


select country_name, country_code,
    case
        when currency_code = 'EUR' then 'Euro'
        else 'Not Euro'
    end as currency
from countries
order by country_name;


select name
from characters
order by name asc;


