-- CREATE DATABASE hrdataanalysis

select * from humandata;

ALTER TABLE c
CHANGE COLUMN ï»¿id emp_id varchar(255) null;

DESCRIBE humandata;

SELECT * FROM humandata;

Set sql_safe_updates = 0;

UPDATE humandata
SET birthdate = CASE 
WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
ELSE null
END;

SELECT birthdate FROM humandata;

ALTER TABLE humandata
MODIFY COLUMN birthdate DATE;


UPDATE humandata
SET hire_date = CASE 
    WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%Y-%m-%d%' THEN hire_date
    ELSE null
END;


UPDATE humandata
SET termdate = date (str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

ALTER TABLE humandata
MODIFY COLUMN termdate DATE;

SELECT * FROM humandata;

ALTER TABLE humandata
MODIFY COLUMN hire_date DATE;


ALTER TABLE humandata ADD COLUMN age INT;

UPDATE humandata
SET age = timestampdiff(year, birthdate, curdate());

select birthdate, age from humandata;

select 
	MIN(age) AS youngest,
    MAX(age) as oldest
from humandata;


select count(*) from humandata where age < 18;


-- Questions
-- 1. what is the gender breakdown of employees in the company?
select gender, count(*) as count from humandata
where age >= 18 and termdate = ''
group by gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?

select race, count(*) as count from humandata
where age >= 18 and termdate = ''
group by race
order by count(*);

-- 3. What is the age distribution of employees in the company?

select min(age) as yougest, max(age) as oldest from humandata
where age >= 18 and termdate ='';

select 
    case
		when age >= 18 and age <= 24 then '18-24'
        when age >=25 and age <= 34 then '25-34'
        when age >= 35 and age <= 44 then '35-44'
        when age >= 45 and age <= 54 then '45-54'
        when age >= 55 and age <= 64 then '55-64'
        else '65+'
        end as age_group, gender,
        count(*) as count
        from humandata
        where age >= 18 and termdate =''
        group by age_group, gender
        order by age_group, gender;
        
-- 4. How many employees work at headquarters versus remote locations?

select location, count(*) as count
from humandata
where age >= 18 and termdate = ''
group by location;
        
-- 5. What is the average length of employment for employees who have been terminated?

select avg(datediff(termdate, hire_date))/365 as avg_length_employment  from humandata;

-- 6. How does the gender distribution vary across departments and job titles?
select department, gender, count(*) as count
from humandata
where age >=18 and termdate = ''
group by department, gender
order by department;

-- 7. What is the distribution of job titles across the company?

select jobtitle, count(*) as count from humandata
where age >=18 and termdate = ''
group by jobtitle;

-- 8. Which department has the highest turnover rate?

select department,
		total_count,
        terminated_count,
        terminated_count/total_count as termination_rate
        from( Select department, count(*) as total_count,
        sum(case when termdate <>'' and termdate<= curdate() then 1 else 0  end) as terminated_count
        from humandata
        where age >= 18
        group by department) as subquery
        order by terminated_count desc;
        
        
-- 9. What is the distribution of employees across locations by city and state?

select location_city, location_state, count(*) from humandata
where age>18 and termdate =''
group by location_city, location_state
order by count(*) desc;



-- 10. How has the company's employee count changed over time based on hire and term dates?

select * from humandata;
select 
		year, hires, 
		terminations, hires-terminations as net_changes,
        round((hires-terminations)/hires*100,2) as net_change_percent
from (Select year(hire_date) as year, count(*) as hires, 
	sum(case when termdate <>'' and termdate <= curdate() then 1 else 0 end) as terminations
from  humandata
where age >= 18
group by year(hire_date)) as subquery
order by year asc;


select department, round(avg(datediff(termdate,hire_date)/365),0) as avg_tenure
from humandata
where termdate <=  curdate() and termdate ='' and age>=18
group by department

/*Brief description of the comments under each section of the provided SQL code:

Database Creation and Initial Data Query:

Creates a database named hrdataanalysis.
Queries all data from a table named humandata.
Column Modification for Employee ID:

Modifies the table by changing the data type of the id column to VARCHAR(255).
Description and Data Display:

Describes the structure of the humandata table.
Displays all data from the humandata table.
Disabling Safe Updates:

Sets sql_safe_updates to 0 to allow updates without specifying a key in the WHERE clause.
Date Format Normalization for Birthdate:

Updates the birthdate column by converting various date formats to the standard format.
Date Format Normalization for Hire Date:

Updates the hire_date column, similar to the birthdate normalization.
Converts the termdate column to a DATE type.
Adding and Calculating Age:

Adds a new column age to the table.
Populates the age column using the difference between the current date and the birthdate.
Age Distribution and Statistics:

Displays the minimum and maximum age of employees.
Groups employees into age categories and presents the count within each category.
Various Queries for Demographic Analysis:

Breakdown of gender and race/ethnicity.
Distribution of employees across different age groups and genders.
Number of employees at headquarters versus remote locations.
Employee Turnover Analysis:

Calculates the average length of employment for terminated employees.
Examines gender distribution across departments and job titles.
Analyzes the distribution of job titles and turnover rates by department.
Explores the distribution of employees across locations (city and state).
Examines changes in employee count over time based on hire and term dates.*/
        
        
        





