/* 
UNION Practice Problem 1:
* Get the corresponding skill and skill type for each job posting in q1
* Includes those without any skills, too.
* Why? Look at the skills and the type for each job in the first quarter that has a salary > 70000 €
*/ 


-- My Solution:

SELECT
    job_title_short,
    skill_id,
    type,
    salary_year_avg
FROM
    jan_2023_jobs AS jj
LEFT JOIN
    skills_job_dim AS sjd ON jj.job_id = sjd.job_id
LEFT JOIN
    skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE
    salary_year_avg > 70000

UNION

SELECT
    *
FROM
    feb_2023_jobs AS fj
LEFT JOIN
    skills_job_dim AS sjd ON fj.job_id = sjd.job_id
LEFT JOIN
    skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE
    salary_year_avg > 70000

UNION

SELECT
    *
FROM
    mar_2023_jobs AS mj
LEFT JOIN
    skills_job_dim AS sjd ON mj.job_id = sjd.job_id
LEFT JOIN
    skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE
    salary_year_avg > 70000
;
