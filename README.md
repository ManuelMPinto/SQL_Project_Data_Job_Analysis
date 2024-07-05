# Introduction
📊 Using a job market dataset consisting of job postings for various positions. Focusing specifically on data analyst positions, this project looks to explore the top-paying jobs, the most demanded skills and which ones combine high demand and high salary in the field of data analytics.

🔎 For the SQL queries, check them out here: [project_sql folder](/project_sql/)



## The questions I wanted to answer through my SQL queries were:

1. What are the top paying jobs for my role?
2. What are the skills required for these top-paying roles?
3. What are the most in-demand skills for my role?
4. What are the top skills based on salary for my role?
5. What are the most optimal skills to learn?

# Tools I Used

- **SQL:** Allowed me to query the database and discover critical insights to the project.
- **PostgreSQL:** Database management system I used in this project.
- **Visual Studio Code:** Where I wrote my queries and ran most processes.
- **Git & Github:** Version control and uploading/updating my SQL scripts and sharing them on my portfolio.

# The Analysis

I did a total number of 5 queries for this project, each one looking to learn more about specific aspects about the subject data.
Here's how I approached each question:

### 1. Top Paying Data/Business Analyst Jobs
To identify the top paying positions listed, I filtered to only be presented with data and business analyst positions located in my country of residence and remote jobs (Location = Anywhere). Also ordered them by average yearly salary.

```sql
SELECT
    job_id,
    job_title,
    job_title_short,
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
```

Breakdown of the top data business and data analyst jobs in 2023:
- **Wide Salary Range:** This top 15 paying roles span from $184,000 to $650,000 yearly salary indicating a big potencial in increasing earnings inside the field
- **Diverse Employers:** The employers presented are from various different fields, showing the diversity of industries looking for data and business analysts.
- **Job Title Diversity:** Its also noticeable that there's a lot of different names for positions specialized within data analytics.
- **Job Location:** Even though the query was presenting results for remote positions as well as positions in Portugal, in the top-payed positions there isn't a single one located in Portugal, which reflects the low-income when compared with other countries.

![Top Paying Roles](assets\query_1.png)
*Bar graph to present the salary of the top 15 salaries for data/business analysts; Visualization made using Tableau.*



### 2. Top Paying Skills
To identify the skills which are required for the top-paying jobs, I joined the job postings table and the skills data in order to get insights into what employers are looking for in high paying roles.

```sql
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
    LIMIT 7
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

```
![Top Paying Roles](assets\query_2.png)
*Bar graph to present the count of times each skill appears *
# What I learned

# Conclusions

