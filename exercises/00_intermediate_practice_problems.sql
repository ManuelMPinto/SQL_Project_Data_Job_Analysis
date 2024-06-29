/*
While the other exercises are somewhat specific about their "themes", these exercises are more broad and have generally a higher degree of complexity:
The others are meant to be around a specific concept, these work as "End of Chapter" exercises.
*/

/*
Intermediate Practice Problem 1:
Get job details for both 'Data Analyst' or 'Business Analyst' positions
    * For 'Data Analyst', I want jobs only > €100k
    * For 'Business Analyst', I only want jobs > €70k
Only include jobs located in either:
    * 'Boston, MA'
    * 'Anywhere' (i.e, Remote Jobs)
*/ 


-- My Solution:
SELECT
	job_title_short,    
    job_location,
    job_via,
    salary_year_avg
FROM
	job_postings_fact
WHERE
	job_location IN ('Boston, MA', 'Anywhere') AND
    ( 
     (job_title_short = 'Data Analyst' 
      AND salary_year_avg > 100000) OR 
     (job_title_short = 'Business Analyst' 
      AND salary_year_avg > 70000)
    ) 


;

/*
Intermediate Practice Problem 2:
Look for non-senior data analyst or business analyst roles:
   * Only get job titles that include either 'Data' or 'Business' 
   * Also include those with 'Analyst' in any part of the title 
   * Don't include any jobs with 'Senior' followed by any character
Get the job title, location and average yearly salary
*/ 


-- My Solution:
SELECT
	job_title AS 'Job Title', 
    job_location AS 'Job Location',
    salary_year_avg AS 'Yearly Salary'
FROM
	job_postings_fact
WHERE
	job_title NOT LIKE 'Senior%' AND
    (job_title LIKE '%Data%'
    OR job_title LIKE '%Business%') AND
    job_title LIKE '%Analyst%'


;


/*
Intermediate Practice Problem 3:
Calculate the current month's total earnings per project
Calculate a scenario where the hourly rate increases by 5$
Why?
	* See the difference if we raised the hourly rate
    * Figure out what's reasonable raise
*/ 


-- My Solution:
SELECT
	project_id,
    SUM(hours_spent * hours_rate) AS project_original_cost,
    SUM(hours_spent * (hours_rate + 5)) AS project_projected_cost
FROM
	invoices_fact
GROUP BY
	project_id 


;

/* 
Intermediate Practice Problem 4:
Find the average salary and number of job postings for each skill for this: 

Hint: Use LEFT JOIN to combine skills_dim, skills_job_dim, and job_postings_fact tables.

Why? Understand the demand and pay for skills.
*/ 


-- My Solution:
SELECT
	sd.skill_id,
    sd.skills AS skill_name,
    COUNT(jpf.job_id) AS number_job_postings,
    AVG(jpf.salary_year_avg) AS salary_average_skill   
FROM
	skills_dim AS sd
LEFT JOIN
	skills_job_dim AS sjd 
    	ON sd.skill_id = sjd.skill_id
LEFT JOIN
	job_postings_fact AS jpf
    	ON sjd.job_id = jpf.job_id
GROUP BY
	sd.skills
ORDER BY
	salary_average_skill DESC 


;

/* 
Intermediate Practice Problem 5:
Create three tables:
    * Jan 2023 jobs;
    * Feb 2023 jobs;
    * Mar 2023 jobs
DISCLAIMER:
This will be used in another practice problem below.
Hints:
    * Use "CREATE TABLE table_name AS" syntax to create your table
    * Look at a way to filter ou only specific months (EXTRACT)
*/ 


-- My Solution:


--January
CREATE TABLE public.jan_2023_jobs AS 
    SELECT
        *
    FROM
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 1
        AND EXTRACT(YEAR FROM job_posted_date) = 2023
;
 --February
CREATE TABLE public.feb_2023_jobs AS 
    SELECT
        *
    FROM
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 2
        AND EXTRACT(YEAR FROM job_posted_date) = 2023
;
 --March
CREATE TABLE public.mar_2023_jobs AS 
    SELECT
        *
    FROM
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 3
        AND EXTRACT(YEAR FROM job_posted_date) = 2023

;

/* 
Intermediate Practice Problem 6:
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill.
*/ 


-- My Solution:

WITH jc AS
    (
    SELECT
        skill_id,
        COUNT(*) AS job_count
    FROM
        skills_job_dim AS sjd
    INNER JOIN
        job_postings_fact as jpf ON jpf.job_id = sjd.job_id
    WHERE
        jpf.job_location = 'Anywhere' AND
        jpf.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
    )
SELECT
    jc.skill_id, 
    skills,
    job_count
FROM
    jc
INNER JOIN
    skills_dim AS sd
        ON jc.skill_id = sd.skill_id
ORDER BY
    job_count DESC
LIMIT 5

;

/* 
Intermediate Practice Problem 7:
Find job postings from the first quarter that have a salary greater than 70000€
    - Combine job posting tables from the first quarter of 2023 (Jan-Mar)
    - Get job postings with an average yearly salary > 70000€
*/ 


-- My Solution:

SELECT
    job_title_short,
    job_location,
    job_via,
    job_posted_date :: DATE,
    salary_year_avg
FROM
    (
        SELECT *
        FROM jan_2023_jobs
        UNION ALL
        SELECT *
        FROM feb_2023_jobs
        UNION ALL
        SELECT *
        FROM mar_2023_jobs
    ) AS quarter1_job_postings
WHERE
    salary_year_avg > 70000
ORDER BY
    quarter1_job_postings.salary_year_avg DESC

;