# Assignment 1 : Pandas Data Cleaning 

## Objective
The goal of this assignment was to learn Python basics and perform basic data exploration and cleaning using the Pandas library.

## Steps Performed
1. **Loaded Data:** Read the `Combined_dataset.csv` into a Pandas DataFrame.
2. **Data Exploration:** Explored the dataset using `.head()`, `.tail()`, `.shape`, and `.info()` to understand columns and data types.
3. **Handling Missing Values:** Cleaned the dataset by dropping rows with missing values using `.dropna()`.
4. **Basic Operations:** Filtered rows based on conditions and selected specific columns for analysis.
5. **Removed Duplicates:** Identified and removed exact duplicate rows using `.drop_duplicates()`.
6. **Derived Column:** Created a new column (`total_amount`) by performing basic arithmetic operations on existing data.
7. **Exported Data:** Saved the final cleaned dataset as a new file named `Cleaned_dataset.csv`.

## Files in this Repository
* `Assignment.ipynb`: The Jupyter Notebook containing all the Python/Pandas code.
* `Cleaned_dataset.csv`: The final dataset after all cleaning steps were applied.


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

---
## Business Insights & Query Capabilities

### 1. Monthly Sales Trends
Created an aggregation query that groups total revenue by month. This allows the business to easily track performance over the year and instantly identify the highest-grossing and lowest-grossing months for seasonal planning.

### 2. Top Customer Identification
Developed a ranking query that calculates the total lifetime spend of every buyer. By sorting the results and limiting the output to the top 5, the business can immediately identify its most valuable customers for loyalty programs or targeted marketing.

### 3. Data Quality Validation 
Implemented a duplicate-checking query to ensure the data is clean and reliable for analysis. By using the HAVING clause, the query automatically scans the dataset and flags any duplicate Order ID entries, preventing incorrect revenue calculations.
