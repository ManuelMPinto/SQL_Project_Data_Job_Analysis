/*
Question: What are the most optimal skills to learn?
        Optimal: High Demand AND High Paying
    -  As on the other queries, focus was directed at data/business positions 
    -  Located in Portugal or "Anywhere"
    -  Combine results from last two queries to get a more complete picture on the best skills

Tried two approaches to practice: One using CTE's to benefit from the last two queries, just changing minor details and one without CTE to simplify the query:
*/

-- Using CTE's:

WITH skills_demand AS (
    SELECT
        sd.skill_id,
        sd.skills,
        COUNT(sjd.job_id) AS demand_count
    FROM
        job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd ON sjd.job_id  =  jpf.job_id
    INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
    WHERE
        job_title_short in ('Business Analyst','Data Analyst')
        AND job_location in ('Portugal', 'Anywhere')
        AND salary_year_avg IS NOT NULL
    GROUP BY
        sd.skill_id

), average_salary AS (
    SELECT
        sd.skill_id,
        sd.skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd ON sjd.job_id  =  jpf.job_id
    INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
    WHERE
        job_title_short in ('Business Analyst', 'Data Analyst') 
        AND job_location in ('Portugal', 'Anywhere')
        AND salary_year_avg IS NOT NULL
    GROUP BY
        sd.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand   
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 20
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 15


;

-- Simplifying without CTE

SELECT
    sd.skill_id,
    sd.skills,
    COUNT(sjd.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON sjd.job_id = jpf.job_id
INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE
    job_title_short in ('Business Analyst', 'Data Analyst') 
    AND job_location in ('Portugal', 'Anywhere')
    AND salary_year_avg IS NOT NULL
GROUP BY
    sd.skill_id
HAVING
    COUNT(sjd.job_id) > 20
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 15


;