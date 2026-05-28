# Credit Risk Analysis

## Problem Statement
Financial institutions lose billions annually to loan defaults.
This project builds an end-to-end credit risk analytics pipeline
to predict which loan applicants are likely to default, using
307,511 real-world applications from Home Credit Group.

## Tools & Technologies
- Python (Pandas, Scikit-learn, XGBoost, SHAP)
- SQL (MS SQL Server)
- Power BI
- Jupyter Notebook

## Project Structure
- `data/` → raw and processed datasets
- `sql/` → business SQL queries
- `notebooks/` → EDA, modelling, SHAP analysis
- `dashboard/` → Power BI .pbix file
- `reports/` → screenshots and findings

## Key SQL Findings
- Overall default rate: **8.07%** (24,825 out of 307,511 applicants)
- Youngest applicants (20–30) default at **11.4%** — 2.3x higher than 60+ age group
- Low-skill laborers have the highest occupational default rate at **17.15%**
- Unemployed applicants default at **36.36%** — 4.5x the average
- Academic degree holders have the lowest default rate at **1.83%**
- High-risk segment (low income + high loan + no property): 19,331 applicants with 8.55% default rate

## Key Results
*(to be updated after modelling)*

## How to Run
1. Clone the repo
2. Install dependencies: `pip install -r requirements.txt`
3. Open notebooks in order: 01_eda → 02_model → 03_shap