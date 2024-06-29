/* 
Question: What are the top-paying data analyst jobs?
    -  Identify the top 15 highest paying Data Analyst roles that are available either remotely or in Portugal (current country of residence).
    -  Clean entries without valid salaries (nulls)
*/

SELECT
    *
FROM
    job_postings_fact
WHERE
    job_location LIKE ('Portugal', 'Anywhere')


;