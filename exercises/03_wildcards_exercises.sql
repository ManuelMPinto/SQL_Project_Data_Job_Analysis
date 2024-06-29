/* 
Wildcards
Practice Problem 1: 
In the company_dim table find all company names that include 'Tech' immediately followed by any single character. Return the name column
*/ 


-- My solution:
SELECT
	name
FROM
	company_dim
WHERE 
	name LIKE 'Tech%' ;


/* 
Wildcards
Practice Problem 2: 
Find all job postings in the job_postings_fact where the job_title is exactly "Engineer" an one character followed after the term. Get the job_id, job_title, and job_posted_date.
*/ 


-- My solution:
SELECT 
	* 
FROM 
	job_postings_fact
WHERE 
	job_title LIKE 'Engineer %' ;


-- Alias Exercise:

/* 
Alias Practice Problem 1:
From the job_postings_fact return the following columns: job_id, job_title_short, job_location, job_via, job_posted_date, and salary_year_avg. Also rename the following: 
job_via to job_posted_site and salary_year_avg to avg_yearly_salary
*/ 


-- My solution:
SELECT
	job_id, 
    job_title_short, 
    job_location, 
    job_via AS job_posted_site, 
    job_posted_date, 
    salary_year_avg AS avg_yearly_salary
FROM
	job_postings_fact