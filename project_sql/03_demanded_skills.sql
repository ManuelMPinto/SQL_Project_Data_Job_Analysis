/*
Question: What are the most in_demand skills for my role?
    -  Join job postings similar to query 2
    -  Identify the top  in-demand skills for data/business analyst.
    -  Focus on all job postings.
*/

SELECT
    skills,
    COUNT(sjd.job_id) AS skill_demand_count
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON sjd.job_id  =  jpf.job_id
INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE
    job_title_short in ('Business Analyst','Data Analyst') AND
    job_location in ('Portugal', 'Anywhere')
GROUP BY
    skills
ORDER BY
    skill_demand_count DESC
LIMIT 10


;
