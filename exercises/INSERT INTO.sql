INSERT INTO 
job_applied
    (job_id,
    application_sent_date,
    custom_resume,
    resume_file_name,
    cover_letter_sent,
    cover_letter_file_name,
    status)
VALUES  (1,
        '2024-02-01',
        true,
        'resume_01.pdf',
        true,
        'cover_letter_01.pdf',
        'submitted'),
        (2,
        '2024-02-01',
        false,
        'default_resume.pdf',
        false,
        NULL,
        'submitted'),
        (3,
        '2024-02-01',
        false,
        'default_resume.pdf',
        true,
        'cover_letter_03.pdf',
        'submitted'),
        (4,
        '2024-02-02',
        true,
        'resume_04.pdf',
        true,
        'cover_letter_02.pdf',
        'submitted')


;
--ALTER TABLE is useful to Add, rename, alter and drop columns.
ALTER TABLE job_applied
    ADD contact VARCHAR(50);

-- UPDATE useful to alter already existing data
UPDATE job_applied 
SET contact = 'Erlich Bachman'
WHERE job_id = 1;

UPDATE job_applied 
SET contact = 'Dinesh Chugtai'
WHERE job_id = 2;

UPDATE job_applied 
SET contact = 'Bertram Gilfgoyle'
WHERE job_id = 3;

UPDATE job_applied 
SET contact = 'Jian Yang'
WHERE job_id = 4;

UPDATE job_applied 
SET contact = 'Big Head'
WHERE job_id = 5;

SELECT * 
FROM job_applied;

ALTER TABLE job_applied 
RENAME COLUMN contact TO contact_name;

-- ALTER COLUMN - used to modify the properties of an existing column in a table

ALTER TABLE job_applied 
ALTER COLUMN contact_name TYPE TEXT;

--DROP COLUMN deletes column
ALTER TABLE job_applied 
DROP COLUMN contact_name;

DROP TABLE job_applied;