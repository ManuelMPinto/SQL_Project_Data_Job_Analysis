/* 
Cases Practice Problem 1:
I want to categorize the salaries from each job posting. To see if it fits in my desired salary range.
    * Put salary into different buckets;
    * Define what's a high, standard, or low salary with your own conditions;
    * Why? It is easy to determine which job postings are worth looking at bassed on salary.
    Bucketing is a common practice in data analysis when viewing categories.
    * I only want to look at data analyst roles;
    * Order from highest to lowest.
*/


-- My Solution:

SELECT
    *,
    CASE
        WHEN salary_year_avg > 100000 THEN 'High'
        WHEN salary_year_avg < 45000 THEN 'Low'
        ELSE 'Standard'
    END AS pay_category
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
ORDER BY   
    salary_year_avg DESC

;