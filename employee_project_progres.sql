--Employees Trends Analysis--
'https://github.com/swaapnaa/SQL-PROJECTS/blob/main/Analyzing%20Employee%20Trends/Analyzing%20Employee%20Trends.sql'
----creating structure employee--


CREATE TABLE IF NOT EXISTS employees_detail
(
emp_no	varchar(50),
gender	varchar(50),
marital_status	varchar(50),
age_band	varchar(50),
age	varchar(50),
department	varchar(50),
education	varchar(50),
education_field	varchar(50),
job_role	varchar(50),
business_travel	varchar(50),
employee_count	int,
attrition	varchar(20),
attrition_label	varchar(50),
job_satisfaction	int,
active_employee	int
);


select * from employees_detail;

--- 1. Count the number of employees in each department---
select department, count(*) as total_emp
from employees_detail
group by department
order by total_emp;

"HR"	63
"Sales"	446
"R&D"	961

--- 2. Calculate the average age for each department ---
--Change type varchar(50) to int------
ALTER table employees_detail
ALTER COLUMN age TYPE int USING age::integer;

select department, round(avg(age),0) as avg_age
from employees_detail
group by department
order by avg_age;

---- 3. Identify the most common job roles in each department ---
select department, job_role, count(*) as role_count
from employees_detail
group by department, job_role
order by department, role_count desc;
"HR"	"Human Resources"	52
"HR"	"Manager"	11
"R&D"	"Research Scientist"	292
"R&D"	"Laboratory Technician"	259
"R&D"	"Manufacturing Director"	145
"R&D"	"Healthcare Representative"	131
"R&D"	"Research Director"	80
"R&D"	"Manager"	54
"Sales"	"Sales Executive"	326
"Sales"	"Sales Representative"	83
"Sales"	"Manager"	37

--- 4. Calculate the average job satisfaction for each education level ---
select education, round(avg(job_satisfaction),2) as avg_JS
from employees_detail
group by education;

"Master's Degree"	2.79
"Associates Degree"	2.77
"Doctoral Degree"	2.67
"High School"	2.80
"Bachelor's Degree"	2.65

--- 5. Determine the average age for employees with different levels of job satisfaction ---
select job_satisfaction, round(avg(age),2) as avg_age
from employees_detail
group by job_satisfaction;
1	36.92
3	37.02
2	36.99
4	36.80

--- 6. Calculate the attrition rate for each age band ---

select age_band,sum(CASE when attrition = 'Yes' Then 1 else 0 end) /count(*) * 100 as 	attrition_rate 
from employees_detail
group by age_band;

--- 7. Identify the departments with the highest and lowest average job satisfaction ---
select department, round(AVG(job_satisfaction),2) as avg_JS
from employees_detail
group by department
order by avg_JS desc, department
limit 1;

"Sales"	2.75

--- 8. Find the age band with the highest attrition rate among employees with a specific education level---
SELECT education, age_band, SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100 AS attrition_rate
FROM employees_detail
GROUP BY education, age_band
ORDER BY attrition_rate DESC
LIMIT 5;

"Doctoral Degree"	"Over 55"	0

--- 9. Find the education level with the highest average job satisfaction among employees who travel frequently ---
select education, round(avg(job_satisfaction),2) as avg_JS
from employees_detail
where business_travel = 'Travel_Frequently'
group by education
order by avg_JS desc
limit 5;
"Associates Degree"	3.11
"High School"	3.08
"Doctoral Degree"	2.90
"Master's Degree"	2.85
"Bachelor's Degree"	2.52

--- 10. Identify the age band with the highest average job satisfaction among married employees ----

select age_band, round(avg(job_satisfaction),2) as avg_JS
from employees_detail
where marital_status = 'Married'
group by age_band
order by avg_JS desc
limit 5;

"Under 25"	2.77
"45 - 54"	2.76
"25 - 34"	2.72
"35 - 44"	2.71
"Over 55"	2.53