CREATE DATABASE Student_Burnout;
USE Student_Burnout;

SET GLOBAL local_infile = 1;

CREATE TABLE students (
    age INT,
    gender VARCHAR(10),
    academic_year INT,
    study_hours_per_day FLOAT,
    exam_pressure FLOAT,
    academic_performance FLOAT,
    stress_level FLOAT,
    anxiety_score FLOAT,
    depression_score FLOAT,
    sleep_hours FLOAT,
    physical_activity FLOAT,
    social_support FLOAT,
    screen_time FLOAT,
    internet_usage FLOAT,
    financial_stress FLOAT,
    family_expectation FLOAT,
    burnout_score FLOAT,
    mental_health_index FLOAT,
    risk_level VARCHAR(20),
    dropout_risk FLOAT
);

LOAD DATA LOCAL INFILE 'C:\\Users\\Yug Trivedi\\........csv'
INTO TABLE students
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Total Students Record
SELECT COUNT(*) AS student_records FROM students;

-- ***************************************************************  Burnout KPIs ****************************************************************************************
-- Avg burnout score
SELECT ROUND(AVG(burnout_score),2) AS avg_burnout_score FROM students;

-- Burnout level distribution
SELECT 
	risk_level,
    COUNT(*) AS distrubutions
FROM students 
GROUP BY risk_level ORDER BY risk_level DESC;
	
-- % Burnout students
SELECT 
	risk_level, 
    ROUND(COUNT(*)/(SELECT COUNT(*) FROM students), 2) * 100  AS perct_distrubutions
FROM students GROUP BY risk_level;

-- Burnout by gender
SELECT 
	gender,
    risk_level,
	COUNT(*) AS burnout, ROUND(COUNT(*)/(SELECT COUNT(*) FROM students), 2) * 100  AS perct_distrubutions
FROM students GROUP BY gender, risk_level;

-- Burnout by age
SELECT 
	age,
    risk_level,
	COUNT(*) AS burnout, ROUND(COUNT(*)/(SELECT COUNT(*) FROM students), 2) * 100  AS perct_distrubutions
FROM students GROUP BY age, risk_level ORDER BY age;

-- Burnout by academic yr
SELECT 
	academic_year, 
    risk_level,
	COUNT(*) AS burnout, ROUND(COUNT(*)/(SELECT COUNT(*) FROM students), 2) * 100  AS perct_distrubutions
FROM students GROUP BY academic_year, risk_level ORDER BY academic_year;

-- ****************************************************************** Academic KPIs *************************************************************************************
-- Avg CGPA by burnout level
SELECT 
	risk_level, 
    ROUND(AVG(academic_performance), 2) AS avg_academic_percentage
FROM students
GROUP BY risk_level;

-- Study time vs burnout
SELECT 
	ROUND(study_hours_per_day) AS study_hours, 
	COUNT(*) AS burn_out_people FROM students 
GROUP BY ROUND(study_hours_per_day) ORDER BY burn_out_people DESC;

-- Dropout people
SELECT 
	ROUND(dropout_risk) AS dropout_risk, 
	COUNT(*) AS burn_out_people 
FROM students
GROUP BY ROUND(dropout_risk) ORDER BY burn_out_people DESC;

-- Avg. dropout according to burnoout level
SELECT 
	risk_level, 
	ROUND(AVG(dropout_risk), 2) AS avg_dropout_risk
FROM students 
GROUP BY risk_level ORDER BY avg_dropout_risk DESC;

-- ******************************************************************* Mental Health KPIs **************************************************************************
-- Avg anxiety by burnout level
SELECT 
	risk_level, 
	ROUND(AVG(anxiety_score), 2) AS avg_anxiety_score 
FROM students 
GROUP BY risk_level ORDER BY avg_anxiety_score DESC;

-- Avg depression by burnout level
SELECT 
	risk_level, 
	ROUND(AVG(depression_score), 2) AS avg_depression_score
FROM students 
GROUP BY risk_level ORDER BY avg_depression_score DESC;

-- Avg stress level by burnout
SELECT 
	risk_level, 
	ROUND(AVG(stress_level), 2) AS avg_stress_level
FROM students 
GROUP BY risk_level ORDER BY avg_stress_level DESC;

-- ******************************************************************** Lifestyle KPIs ***********************************************************************************
-- Sleep duration according to burnout risk
SELECT 
  CASE 
    WHEN age BETWEEN 18 AND 20 THEN '18-20'
    WHEN age BETWEEN 21 AND 23 THEN '21-23'
    WHEN age BETWEEN 24 AND 26 THEN '24-26'
    ELSE '27+'
  END AS age_group,
  risk_level,
  ROUND(AVG(sleep_hours),2) AS avg_sleep_hrs
FROM students
GROUP BY age_group, risk_level
ORDER BY age_group, risk_level;

-- Physical activity hrs accordint to burnout risk
SELECT 
  CASE 
    WHEN age BETWEEN 18 AND 20 THEN '18-20'
    WHEN age BETWEEN 21 AND 23 THEN '21-23'
    WHEN age BETWEEN 24 AND 26 THEN '24-26'
    ELSE '27+'
  END AS age_group,
  risk_level,
  ROUND(AVG(physical_activity),2) AS avg_physical_activity
FROM students
GROUP BY age_group, risk_level
ORDER BY age_group, risk_level;

-- Screen time vs burnout
SELECT 
  CASE 
    WHEN age BETWEEN 18 AND 20 THEN '18-20'
    WHEN age BETWEEN 21 AND 23 THEN '21-23'
    WHEN age BETWEEN 24 AND 26 THEN '24-26'
    ELSE '27+'
  END AS age_group,
  risk_level,
  ROUND(AVG(screen_time),2) AS avg_screen_time
FROM students
GROUP BY age_group, risk_level
ORDER BY age_group, risk_level;

-- ******************************************************************** Demographic KPIs *******************************************************************************
-- Social stress according to age group
SELECT 
  CASE 
    WHEN age BETWEEN 18 AND 20 THEN '18-20'
    WHEN age BETWEEN 21 AND 23 THEN '21-23'
    WHEN age BETWEEN 24 AND 26 THEN '24-26'
    ELSE '27+'
  END AS age_group,
  risk_level,
  ROUND(AVG(social_support),2) AS avg_social_support
FROM students
GROUP BY age_group, risk_level
ORDER BY age_group, risk_level;

-- Financial stress according to age group
SELECT 
  CASE 
    WHEN age BETWEEN 18 AND 20 THEN '18-20'
    WHEN age BETWEEN 21 AND 23 THEN '21-23'
    WHEN age BETWEEN 24 AND 26 THEN '24-26'
    ELSE '27+'
  END AS age_group,
  risk_level,
  ROUND(AVG(financial_stress),2) AS avg_financial_stress
FROM students
GROUP BY age_group, risk_level
ORDER BY age_group, risk_level;
	