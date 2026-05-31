# Assignment 2: SQL Sales Data Analysis

## Objective
The goal of this assignment is to analyze a sales dataset using SQL to uncover business insights, including monthly sales trends, top-performing customers, and data quality validation.

## Tools Used
* Database Management System: MySQL
* Language: SQL

## Steps Performed
1. Database Setup: Created a local schema and imported the raw dataset into a new table.
2. Data Exploration: Used DESCRIBE and LIMIT to verify the schema, column structures, and data types.
3. Data Filtering: Applied WHERE clauses to segment data by specific categories, regions, and sales thresholds.
4. Aggregation: Utilized GROUP BY along with aggregate functions (SUM, COUNT) to calculate total revenue and order volumes.
5. Sorting & Limiting: Applied ORDER BY ... DESC and LIMIT to extract the highest-performing metrics.
6. Business Use Cases: Formulated specific queries to solve for monthly revenue trends, top customer identification, and dataset duplication checks.

## Business Insights & Query Capabilities

### 1. Monthly Sales Trends
Created an aggregation query that groups total revenue by month. This allows the business to easily track performance over the year and instantly identify the highest-grossing and lowest-grossing months for seasonal planning.

### 2. Top Customer Identification
Developed a ranking query that calculates the total lifetime spend of every buyer. By sorting the results and limiting the output to the top 5, the business can immediately identify its most valuable customers for loyalty programs or targeted marketing.

### 3. Data Quality Validation
Implemented a duplicate-checking query to ensure the data is clean and reliable for analysis. By using the HAVING clause, the query automatically scans the dataset and flags any duplicate Order ID entries, preventing incorrect revenue calculations.
