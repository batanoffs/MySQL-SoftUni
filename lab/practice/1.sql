-- 1 Table design
drop database summer_olympics;
create database summer_olympics;

use summer_olympics;

create table countries (
    id int primary key auto_increment,
    name varchar(40) not null unique
);

create table sports (
    id int primary key auto_increment,
    name varchar(20) not null unique
);

create table disciplines (
    id int primary key auto_increment,
    name varchar(40) not null unique,
    sport_id int not null,
    foreign key (sport_id) references sports(id)
);

create table athletes (
    id int primary key auto_increment,
    first_name varchar(40) not null,
    last_name varchar(40) not null,
    age int,
    country_id int not null,
    foreign key (country_id) references countries(id)
);

create table medals (
    id int primary key auto_increment,
    type varchar(10) not null unique
);

create table disciplines_athletes_medals (
    discipline_id int not null,
    athlete_id int not null,
    medal_id int not null,
    primary key (discipline_id, athlete_id),
    foreign key (discipline_id) references disciplines(id),
    foreign key (athlete_id) references athletes(id),
    foreign key (medal_id) references medals(id),
    unique (discipline_id, medal_id)
);

-- 2 Data Manipulation Language

INSERT INTO athletes (first_name, last_name, age, country_id)
SELECT 
    UPPER(first_name),
    CONCAT(last_name, ' comes from ', name),
    age + countries.id,
    countries.id
FROM athletes
JOIN countries ON countries.id = country_id
WHERE countries.name LIKE 'A%';

UPDATE disciplines
SET name = REPLACE(name, 'weight', '')
WHERE name LIKE '%weight%';

DELETE FROM athletes WHERE age > 35;


-- 3 Querying

SELECT id, name FROM countries c
WHERE c.id NOT IN (SELECT country_id FROM athletes)
ORDER BY c.name DESC
LIMIT 15;

-- 

SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS full_name,
    a.age
FROM athletes a
JOIN disciplines_athletes_medals dam ON a.id = dam.athlete_id
WHERE a.age = (SELECT MIN(age) FROM athletes WHERE id IN (SELECT athlete_id FROM disciplines_athletes_medals))
ORDER BY a.id ASC
LIMIT 2;

-- 

SELECT 
    a.id,
    a.first_name,
    a.last_name
FROM athletes a
WHERE a.id NOT IN (SELECT athlete_id FROM disciplines_athletes_medals)
ORDER BY a.id ASC;

-- 8

SELECT 
    a.id,
    a.first_name,
    a.last_name,
    COUNT(dam.medal_id) AS medals_count,
    d.name AS sport
FROM athletes a
JOIN disciplines_athletes_medals dam ON a.id = dam.athlete_id
JOIN disciplines d ON dam.discipline_id = d.id
GROUP BY a.id, a.first_name, a.last_name, d.name
ORDER BY medals_count DESC, a.first_name ASC
LIMIT 10;

-- 9

SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS full_name,
    CASE
        WHEN a.age <= 18 THEN 'Teenager'
        WHEN a.age BETWEEN 19 AND 25 THEN 'Young adult'
        ELSE 'Adult'
    END AS age_group
FROM athletes a
ORDER BY a.age DESC, a.first_name ASC;

DELIMITER $$

CREATE FUNCTION udf_total_medals_count_by_country(name VARCHAR(40))
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE count_of_medals INT;
    SELECT COUNT(dam.medal_id)
    INTO count_of_medals
    FROM athletes a
    JOIN disciplines_athletes_medals dam ON a.id = dam.athlete_id
    JOIN countries c ON a.country_id = c.id
    WHERE c.name = name;
    RETURN count_of_medals;
END$$

DELIMITER ;

SELECT c.name, udf_total_medals_count_by_country('Bahamas') AS count_of_medals
FROM countries c
WHERE c.name = 'Bahamas';