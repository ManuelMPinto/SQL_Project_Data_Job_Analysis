/* 
Subqueries/CTE Practice Problem 1:
Find the companies that have the most job openings.
    - Get the total number of job postings per company id.
    - Return the total number of jobs with the company name.
*/


-- My Solution:

WITH  company_counts AS
    (
    SELECT
        company_id,
        COUNT(company_id) AS company_count
    FROM
        job_postings_fact
    GROUP BY
        company_id
    ORDER BY
        company_id ASC
    )
SELECT
    name,
    cc.company_count
FROM 
    company_dim AS cd
LEFT JOIN company_counts AS cc 
    ON cc.company_id = cd.company_id
ORDER BY
    cc.company_count DESC


;


/* 
Subqueries/CTE Practice Problem 2:
Determine the size category ('Small', 'Medium', or 'Large') for each company by first identifying the number of job postings
they have. Use the subquery to calculate the total job postings per company. A company is considered 'Small' if it has less
than 10 job postings, 'Medium' if the number of postings is between 10 and 50, and 'Large' if it has more than 50 job postings.
Implement a subquery to aggregate job counts per company before classifying them based on size.
*/


-- My Solution:

SELECT
    cd.company_id,
    cd.name,
    jpf.count,
    CASE
        WHEN count < 10 THEN 'Small'
        WHEN count > 50 THEN 'Large'
        ELSE 'Medium'
    END AS company_size
FROM 
    (
        SELECT
            company_id,
            COUNT(*) AS count
        FROM
            job_postings_fact
        GROUP BY
            company_id
        ORDER BY    
            company_id ASC
    ) AS jpf
RIGHT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
ORDER BY
    count DESC


;