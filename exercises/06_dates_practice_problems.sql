/* 
Dates Practice Problem 1:
Write a query to find the average salary both yearly (salary_year_avg) and hourly (salary_hour_avg) for job postings
that were posted after June 1, 2023.
Group the results by job schedule type.
*/ 


-- My Solution:
SELECT
    job_schedule_type,
    AVG(salary_hour_avg) AS average_hourly,
    AVG(salary_year_avg) AS average_yearly
FROM
    job_postings_fact
WHERE
    job_posted_date > '2023-06-01'
    AND job_schedule_type IS NOT NULL
GROUP BY
    job_schedule_type
HAVING
    AVG(salary_hour_avg) IS NOT NULL
    AND AVG(salary_year_avg) IS NOT NULL
ORDER BY
    job_schedule_type
;


/* 
Dates Practice Problem 2:
Write a query to count the number of job postings for each month in 2023, adjusting the job_posted_date to be in
'America/NewYork' time zone before extracting the month.
Assume the job_posted_date is stored in UTC. Group by and order by the month.
*/ 


-- My Solution:
SELECT
    EXTRACT(MONTH FROM date_ast) AS month,
    COUNT(job_id)
FROM 
    (
    SELECT 
        *,
        job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'AST' AS date_ast
    FROM 
        job_postings_fact
    )
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM date_ast) = 2023
GROUP BY 
    month
ORDER BY
    month ASC


;


/* 
Dates Practice Problem 3:
Write a query to find companies (include company name) that have posted job offering health insurance, where
these postings were made in the second quarter of 2023. Use date extraction to filter by quarter.
*/ 


-- My Solution:

SELECT
    jpf.company_id,
    cd.name
FROM
    job_postings_fact AS jpf
LEFT JOIN 
    company_dim AS cd ON jpf.company_id = cd.company_id
WHERE
    jpf.job_health_insurance = TRUE
    AND EXTRACT(QUARTER FROM job_posted_date) = 2
GROUP BY
    cd.name,
    jpf.company_id
ORDER BY
    jpf.company_id


;