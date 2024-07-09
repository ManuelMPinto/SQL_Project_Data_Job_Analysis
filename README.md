# Introduction
📊 Using a job market dataset consisting of job postings for various positions. Focusing specifically on data analyst positions, this project looks to explore the top-paying jobs, the most demanded skills and which ones combine high demand and high salary in the field of data analytics.

🔎 For the SQL queries, check them out [here](/project_sql/):



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

![Top-Paying Roles](https://github.com/ManuelMPinto/SQL_Project_Data_Job_Analysis/blob/1c62c1853a0759469f62a194e341640246f22ac7/assets/query_1.png)
*Bar graph to present the salary of the top 15 salaries for data/business analysts; Visualization made using Tableau.*



### 2. Top-Paying Skills
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

```


Breaking down the result from the query, the most demanded skills for data analysts in the 10 highest paying jobs are:

**SQL, Python and SQL:** leading with each having a count of 5.

**Excel:** is the fourth most common skill, listed 3 times.

Other skills like R (2 times) Pandas (2 times) are less demanded, followed by all the others with one listing each.

![Skills in Top-Paying Roles](https://github.com/ManuelMPinto/SQL_Project_Data_Job_Analysis/blob/1c62c1853a0759469f62a194e341640246f22ac7/assets/query_2.png)
*Bar graph to present the count of times each skill appears in the top 10 salaries for data/business analysts; Visualization made using Tableau.*

### 3. Most demanded skills
From the entire dataset, to identify the skills which appear the most in the job postings, focusing on the top 10 demanded skills.

```sql
SELECT
    skills,
    COUNT(sjd.job_id) AS skill_demand_count
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON sjd.job_id  =  jpf.job_id
INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE
    job_title_short in ('Business Analyst','Data Analyst')
    AND job_location in ('Portugal', 'Anywhere')
GROUP BY
    skills
ORDER BY
    skill_demand_count DESC
LIMIT 10

```

The breakdown of the most demanded skills in job postings of 2023:

**SQL** and **Excel** are fundamental and the most sought out skills in the dataset, extremely important for data processing and manipulation.

Directly followed by **Python**, **Tableau**, **Power BI** and **R**, which again, are fundamental and some of the most popular tools for ******Data Visualization**** and **Programming** in the world of ******Data Analytics**

The next skills presented consist on varied tools around **Data Visualization/Presentation** and **Cloud Computing**, with considerably lower number of job postings demanding them.

| **Skills** | **Demand Count**|
| :--------- | :----|
| SQL        | 8716 |
| Excel      | 5680 |
| Python     | 4980 |
| Tableau    | 4529 |
| Power BI   | 3247 |
| R          | 2424 |
| SAS        | 2112 |
| PowerPoint | 1077 |
| Azure      | 1043 |
| Looker     | 1025 |

*Table showing the top 10 most demanded skills in data/business analyst job postings.*

### 4. Top-Paying Skills
To explore the average salaries associated with different skills revealed which skills are better compensated.

```sql
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
LIMIT 10

```

The breakdown of the highest paying skills for **Data/Business Analysts**:

- **High Salaries for Big Data and Machine Learning Tools:** Employers pay higher salaries for positions involving tools to work with Big Data (**PySpark**,**Couchbase**) and Machine Learning tools (**DataRobot**, **Jupyter**).
- **Niche tools:** tools that are not so common/more specialized tend to have a higher compensation because of the lack of people able to use them.


| **Skills** | **Average Salary ($/year)**|
| :--------  | ------: |
| PySpark    | 208 172 |
| Bitbucket  | 189 155 |
| GDPR       | 165 000 |
| Watson     | 160 515 |
| Couchbase  | 160 515 |
| DataRobot  | 155 486 |
| GitLab     | 154 500 |
| Swift      | 153 750 |
| Jupyter    | 152 777 |
| Chef       | 152 500 |                    

*Table showing the highest average salaries from the top 10 payed skills in Data/Business Analysts.*

### 5. Most Optimal Skills
Combining insights from both the demand and salary data from the previous queries, this last query is focused on finding skills that are both high-demand and have high salaries.

```sql
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
```

| **Skill ID** | **Skills** | **Demand Count** | **Avg Salary** |
|:---------|:------------|:-------------|------------:|
| 80       | Snowflake   | 38           | 112 989     |
| 74       | Azure       | 36           | 112 310     |
| 97       | Hadoop      | 25           | 111 849     |
| 8        | Go          | 30           | 111 121     |
| 76       | AWS         | 32           | 108 317     |
| 185      | Looker      | 55           | 106 476     |
| 79       | Oracle      | 43           | 103 877     |
| 233      | Jira        | 22           | 103 403     |
| 1        | Python      | 259          | 102 828     |
| 4        | Java        | 21           | 102 258     |
| 5        | R           | 156          | 101 223     |
| 182      | Tableau     | 259          | 99 783      |
| 61       | SQL Server  | 39           | 99 672      |
| 186      | SAS         | 70           | 98 908      |
| 7        | SAS         | 70           | 98 908      |

*Table showing the top 15 most optimal skills for Data/Business Analysts in 2023.*

**Note:** SAS appearing twice with different ID's, further information needed to conlcude why.

The breakdown of the highest paying skills for **Data/Business Analysts**:

- **High-Demand Programming Languages**: **Python** and **R** stand out by having a very high demand and also a very high compensation. Despite having such a high demand they are still very well compensated skills which might indicate that they are not only highly valued but also widely available.
- **Data Visualization Tools:** the same goes for Tableau, which is another tool with very high demand and maintains a high compensation. Also **Looker**, with a fairly high demand and very high salaries.
- **Cloud Computing and Database Tools:** again, as seen previously, cloud computing and its tools are fairly sought out and very well payed as **Snowflake**, **Azure**, **AWS**, **SAS** and **BigQuery**.


# What I Learned
With this project and all the exercises done located over on the [exercises folder](https://github.com/ManuelMPinto/SQL_Project_Data_Job_Analysis/blob/1c62c1853a0759469f62a194e341640246f22ac7/exercises), I further improved on the basics I learned in the Google Data Analyst Certificate:
- **Complex Query Building:** touched new concepts, new functions and ways of achieving the results I want in more complex ways;
- **Analytical Thinking:** puzzle-solving my way to finding answers to questions about this particular set and bringing forward insight over it all.
- **Tableau Practice:** further explored Tableau to create some visualizations about the data.
- **Project Presentation:** Learned valuable lessons in the way I present my projects and my findings. This project gave me some confidence in how to approach projects going forward and how to navigate different data types and datasets.

# Conclusions

### Insights
From the analysis, generally we can conclude:
1. **Top-Paying Jobs:** All the highest-paying positions are remote, with positions in Portugal being considerably less compensated.
2. **Skills for Top-Paying Jobs:** High-paying jobs require knowledge in SQL, further highlighting the importance in being proficient in this skill.
3. **Most Demanded Skills:** The most sought out skill is also SQL, again making it an essential skill to learn for job-seekers.
4. **Skills With Highest Salaries**: The best compensated skills are very specialized probably because of the lack of people available to use them effectively.
5. **Optimal Skills:** As highlighted in the previous bullet-points, SQL is outstandingly the most-optimal skill to learn, combining a high-demand and high salary.

### Closing Statement
This project turned out to be an invaluable learning opportunity not only on SQL, but also the whole Data Analysis process, familiarizing me further with the language, but also all the tools used (like VStudio Code, Tableau, PostgreSQL). As the theme of this dataset is so relevant to someone like me who's searching for new job opportunities, practicing my knowledge while also getting valuable insights on the job market was a win-win scenario. Look forward to further improve on the skills touched on this project and others!
