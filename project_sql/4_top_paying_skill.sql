/* 
What are the top skills based on salary for my role?

*/


SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS skill_average_salary
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON sjd.job_id  =  jpf.job_id
INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE
    job_title_short in ('Business Analyst', 'Data Analyst') 
    AND job_location in ('Portugal', 'Anywhere')
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    skill_average_salary DESC
LIMIT 15