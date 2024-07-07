/*
Question: What are the skills required for these top-paying roles?
    -   Using the top 10 highest paying positions form the previous query
    -   Adding the specific skills required for these roles
*/

WITH highest_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        cd.name AS company_name,
        salary_year_avg
    FROM
        job_postings_fact AS jpf
    LEFT JOIN   company_dim AS cd ON cd.company_id = jpf.company_id
    WHERE
        job_location IN ('Portugal', 'Anywhere')
        AND job_title_short in ('Business Analyst','Data Analyst')
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
) 

SELECT 
    hpj.*,
    skills
FROM 
    highest_paying_jobs AS  hpj 
INNER JOIN skills_job_dim AS sjd ON sjd.job_id  =  hpj.job_id
INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
ORDER BY 
    salary_year_avg DESC

/* 
Breaking down the result from t he query, the most demanded skills for data analysts in the 15 highest paying jobs are:
SQL, Python and SQL leading with each having a count of 5.
Excel is the fourth most common skill, listed 3 times.
Other skills like R (2 times) Pandas (2 times) are less demanded, followed by all the others with one listing each.
*/

