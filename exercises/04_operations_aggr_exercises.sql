/* 
Operations Practice Problem 1: 
In the invoices_fact table add the hours_spent to the hours_rate. This could be used to prioritize tasks, higher values could indicate tasks that are both 
time-intensive and costly, therefore requiring early attention. 
*/


-- My Solution:
SELECT
	activity_id,
    hours_spent, 
    hours_rate,
    hours_rate + hours_spent AS project_cost
FROM
	invoices_fact
ORDER BY
	project_cost DESC ;


/* 
Operations Practice Problem 2: 
In the invoices_fact table divide the hours_spent by the hours_rate. Return the acitvity_id as well. This helps give us an efficiency ratio. A lower ratio 
could indicate a more cost-efficient task. 
*/


-- My Solution:
SELECT
	activity_id,
    hours_spent, 
    hours_rate,
    hours_spent / hours_rate AS efficiency_ratio
FROM
	invoices_fact
ORDER BY 
	efficiency_ratio ASC ;

-- Aggregate Exercises:

/* 
Aggregate Practice Problem 1: 
In the job_postings_fact table calculate te total sum of the average yearly salary (salary_year_avg) for all the job postings that are marked as 
fully remote (job_work_from_home = TRUE) and divide it by the total count of salary_year_avg. To get the total average yearly salary for fully remote jobs.
Ensure to only include job postings where a yearly salary is specified (salary_year_avg is not NULL)
*/


-- My Solution:
SELECT
    SUM(salary_year_avg) / COUNT(salary_year_avg) as average_year_salary
FROM
	job_postings_fact
WHERE
	job_work_from_home = TRUE AND
    (salary_year_avg NOT NULL) ;


/* 
Aggregate Practice Problem 2: 
In the job_postings_fact table count te total number of job postings that offer health insurance. Use the job_health_insurence column to determine if a job 
posting offers health insurance (TRUE means it does offer health insurence).
*/


-- My Solution:
SELECT
	COUNT(job_title_short)
FROM
	job_postings_fact 
WHERE
	job_health_insurance = TRUE ;



