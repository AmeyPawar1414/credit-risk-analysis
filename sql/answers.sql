USE credit_risk_db;

-- ================================================
-- CREDIT RISK ANALYSIS - Business SQL Queries
-- Dataset: Home Credit Default Risk (307,511 rows)
-- ================================================

-- Q1: What is the overall default rate?
SELECT 
    COUNT(*) AS total_applicants,
    SUM(TARGET) AS total_defaults,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2) AS default_rate_pct
FROM application_train;

-- Q2: Default rate by gender
SELECT 
    CODE_GENDER,
    COUNT(*) AS total,
    SUM(TARGET) AS defaults,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2) AS default_rate_pct
FROM application_train
GROUP BY CODE_GENDER
ORDER BY default_rate_pct DESC;

-- Q3: Default rate by loan type
SELECT 
    NAME_CONTRACT_TYPE,
    COUNT(*) AS total,
    SUM(TARGET) AS defaults,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2) AS default_rate_pct
FROM application_train
GROUP BY NAME_CONTRACT_TYPE
ORDER BY default_rate_pct DESC;

-- Q4: Which income type has highest default rate?
SELECT 
    NAME_INCOME_TYPE,
    COUNT(*) AS total,
    SUM(TARGET) AS defaults,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2) AS default_rate_pct
FROM application_train
GROUP BY NAME_INCOME_TYPE
ORDER BY default_rate_pct DESC;

-- Q5: Default rate by education level
SELECT 
    NAME_EDUCATION_TYPE,
    COUNT(*) AS total,
    SUM(TARGET) AS defaults,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2) AS default_rate_pct
FROM application_train
GROUP BY NAME_EDUCATION_TYPE
ORDER BY default_rate_pct DESC;

-- Q6: Average loan amount for defaulters vs non-defaulters
SELECT 
    TARGET,
    ROUND(AVG(AMT_CREDIT), 2) AS avg_loan_amount,
    ROUND(AVG(AMT_INCOME_TOTAL), 2) AS avg_income,
    ROUND(AVG(AMT_CREDIT) / NULLIF(AVG(AMT_INCOME_TOTAL), 0), 2) AS debt_to_income_ratio
FROM application_train
GROUP BY TARGET;

-- Q7: Default rate by age group
SELECT 
    CASE 
        WHEN FLOOR(ABS(DAYS_BIRTH) / 365) BETWEEN 20 AND 30 THEN '20-30'
        WHEN FLOOR(ABS(DAYS_BIRTH) / 365) BETWEEN 31 AND 40 THEN '31-40'
        WHEN FLOOR(ABS(DAYS_BIRTH) / 365) BETWEEN 41 AND 50 THEN '41-50'
        WHEN FLOOR(ABS(DAYS_BIRTH) / 365) BETWEEN 51 AND 60 THEN '51-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total,
    SUM(TARGET) AS defaults,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2) AS default_rate_pct
FROM application_train
GROUP BY 
    CASE 
        WHEN FLOOR(ABS(DAYS_BIRTH) / 365) BETWEEN 20 AND 30 THEN '20-30'
        WHEN FLOOR(ABS(DAYS_BIRTH) / 365) BETWEEN 31 AND 40 THEN '31-40'
        WHEN FLOOR(ABS(DAYS_BIRTH) / 365) BETWEEN 41 AND 50 THEN '41-50'
        WHEN FLOOR(ABS(DAYS_BIRTH) / 365) BETWEEN 51 AND 60 THEN '51-60'
        ELSE '60+'
    END
ORDER BY default_rate_pct DESC;

-- Q8: Does owning a car or property reduce default risk?
SELECT 
    FLAG_OWN_CAR,
    FLAG_OWN_REALTY,
    COUNT(*) AS total,
    SUM(TARGET) AS defaults,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2) AS default_rate_pct
FROM application_train
GROUP BY FLAG_OWN_CAR, FLAG_OWN_REALTY
ORDER BY default_rate_pct DESC;

-- Q9: Top 10 occupations with highest default rate
SELECT TOP 10
    OCCUPATION_TYPE,
    COUNT(*) AS total,
    SUM(TARGET) AS defaults,
    ROUND(SUM(TARGET) * 100.0 / COUNT(*), 2) AS default_rate_pct
FROM application_train
WHERE OCCUPATION_TYPE IS NOT NULL
GROUP BY OCCUPATION_TYPE
ORDER BY default_rate_pct DESC;

-- Q10: High risk segment — low income, high loan, no property
SELECT 
    COUNT(*) AS high_risk_applicants,
    ROUND(AVG(CAST(TARGET AS FLOAT)) * 100, 2) AS default_rate_pct,
    ROUND(AVG(AMT_CREDIT), 2) AS avg_loan,
    ROUND(AVG(AMT_INCOME_TOTAL), 2) AS avg_income
FROM application_train
WHERE 
    AMT_INCOME_TOTAL < 150000
    AND AMT_CREDIT > 500000
    AND FLAG_OWN_REALTY = 'N';