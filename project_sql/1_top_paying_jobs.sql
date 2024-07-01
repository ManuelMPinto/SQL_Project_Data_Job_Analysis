/* 
Question: What are the top-paying data/business analyst jobs?
    -  Identify the top 15 highest paying Data and Business Analyst roles that are available either remotely or in Portugal (current country of residence).
    -  Clean entries without valid salaries (nulls)
*/


SELECT
    job_id,
    job_title,
    cd.name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date :: DATE
FROM
    job_postings_fact AS jpf
LEFT JOIN   company_dim AS cd ON cd.company_id = jpf.company_id
WHERE
    job_location IN ('Portugal', 'Anywhere')
    AND job_title_short in ('Business Analyst','Data Analyst')
    AND salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 15


;
