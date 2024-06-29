/*
NULL values Practice Problem 1:
We're going to chek thay all skills have a category assigned to it. This can be used for validating data.
So, take out all skills from the skills_dim table that don't have a type classification assigned to them. Return the skill_id and skills.
*/ 


-- My Solution:
SELECT 
	* 
FROM
	skills_dim
WHERE
	type IS NOT NULL ;


/*
NULL values Practice Problem 2:
Identify all job postings that have neither an annual average salary (salary_year_avg) nor an hourly average salary (salary_hour_avg) in the 
job_postings_fact table. Return the job_id, job_title, salary_year_avg, salary_hour_avg. This can be useful to look at postings where there's no compensation.
*/ 


-- My Solution:
SELECT 
	job_id, 
    job_title, 
    salary_year_avg, 
    salary_hour_avg
FROM
	job_postings_fact
WHERE
	salary_year_avg IS NULL
    AND salary_hour_avg IS NULL ;


-- Join Exercises:

/* 
Joins Practice Problem 1:
Retrieve the list of job titles (job_title) and the corresponding company names (name) for all job postings that mention "Data Scientist" 
in the job title. Use the job_postings_fact and company_dim tables for this query. 
*/ 


-- My Solution:

SELECT
	jpf.company_id,
    jpf.job_title,
    cd.name as company_name
FROM
	job_postings_fact AS jpf
INNER JOIN 
	company_dim AS cd ON jpf.company_id = cd.company_id
WHERE
	jpf.job_title LIKE '%Data Scientist%' 


;

/* 
Joins Practice Problem 2:
Fetch all job postings, including their job titles (job_title) and the names of the skills required (skills), even if no skills are listed for a job. 
Ensure that the job is located in "New York" and offers "Health Insurance". Use the job_postings_fact, skills_job_dim, and skills_dim tables.
*/ 


-- My Solution:

SELECT
	jpf.job_id,
    jpf.job_title,
    jpf.job_location, 
    jpf.job_health_insurance,
    sjd.skill_id, 
    sd.skills
FROM
	job_postings_fact AS jpf
LEFT JOIN
	skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN
	skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
	jpf.job_location = 'New York'
    AND jpf.job_health_insurance = TRUE


;