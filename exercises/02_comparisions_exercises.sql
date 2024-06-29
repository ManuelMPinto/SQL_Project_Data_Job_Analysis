--Exercises made to practice comparisions:

/* 
COMPARISIONS
Practice Problem 1: 
In the job_postings_fact table get the job_id, job_title_short, job_location, job_via, and salary_year_avg columns. Only return rows where the job location 
is in 'Tampa, FL'. 
*/ 


-- My solution:
SELECT 
	job_id, 
    job_title_short, 
    job_location, 
    job_via,
    salary_year_avg
FROM 
	job_postings_fact
WHERE 
	job_location == 'Tampa, FL' ;

/* 
COMPARISONS
Practice Problem 2: 
In the job_postings_fact table get the job_id, job_title_short, job_location, job_via, and salary_year_avg columns. Only return 'Full-Time' jobs.
*/ 


-- My solution:
SELECT
	job_id, 
    job_title_short, 
    job_location, 
    job_via, 
    job_schedule_type,
    salary_year_avg
FROM
	job_postings_fact
WHERE
	job_schedule_type == 'Full-time' ;


/* 
COMPARISONS
Practice Problem 3: 
In the job_postings_fact table get the job_id, job_title_short, job_location, job_via, and salary_year_avg columns. Only look at jobs that are not 
'Part-Time jobs.
*/ 


-- My solution:
SELECT
	job_id, 
    job_title_short, 
    job_location, 
    job_via, 
    job_schedule_type,
    salary_year_avg
FROM
	job_postings_fact
WHERE NOT
	job_schedule_type == 'Part-time' ;
	
/* 
COMPARISONS
Practice Problem 4: 
In the job_postings_fact table get the job_id, job_title_short, job_location, job_via, and salary_year_avg columns.
Only look at jobs that are not posted 'via Linkedin'.
*/ 


-- My solution:

SELECT
	job_id, 
    job_title_short, 
    job_location,
    job_via,
    salary_year_avg
FROM
	job_postings_fact
WHERE NOT
	job_via = 'via LinkedIn' 


;

/* 
COMPARISONS
Practice Problem 5: 
In the job_postings_fact table only get jobs that have an average yearly salary of $65,000 or greater. Also get the job_id, job_title_short, job_location, 
job_via, and salary_year_avg columns.
*/ 


-- My solution:

SELECT
	job_id, 
    job_title_short, 
    job_location, 
    job_via,
    salary_year_avg
FROM
	job_postings_fact 
WHERE 
	salary_year_avg > 65000
ORDER BY
	salary_year_avg ASC 


;

/* 
COMPARISONS
Practice Problem 6: 
In the job_postings__fact table only get jobs that have an average yearly salary greater than $55,000. Also get the job_id, job_title_short, job_location 
job_via, and salary_year_avg columns.
*/ 


-- My solution:

SELECT
	job_id, 
    job_title_short, 
    job_location, 
    job_via, 
    salary_year_avg
FROM
	job_postings_fact
WHERE
	salary_year_avg > 55000
ORDER BY
	salary_year_avg ASC 


;

/* 
COMPARISONS
Practice Problem 7: 
In the job_postings__fact table only get jobs that have an average yearly salary less than $110,000. Also get the job_id, job_title_short, job_location 
job_via, and salary_year_avg columns.
*/ 


-- My solution:

SELECT
	job_id, 
    job_title_short, 
    job_location, 
    job_via, 
    salary_year_avg
FROM
	job_postings_fact
WHERE
	salary_year_avg < 110000
ORDER BY
	salary_year_avg DESC


;