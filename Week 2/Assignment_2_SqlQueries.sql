
-- 1. Data already Loaded
-- 2. Exploring Schema and Table
describe sales_data;

select * from sales_data 
limit 15;

-- 3. Applying where Filters 

select City from sales_data
where `Ship Mode`='Second Class'
limit 6;

select * from sales_data
where Region='west';

select Category from sales_data
where `Ship date`="6/14/2015";

select Category,Region from sales_data 
where Sales>100;


-- 4. using Group By 

select City ,AVG(Sales) from sales_data
group by City;

select State,SUM(Quantity) from sales_data 
group by State;

select State,Count(City) from sales_data
group By State;


-- 5. Sort and limit results (top products, top categories)

	-- Showing top 10 Cities in Kentucky State that is Sorted in ascending order 
select * from sales_data
where State='kentucky'
order by City
limit 10;

-- top 5 product name and Category , Sorted in Descending order 
select `Product Name`,Category from sales_data
order by `Product Name` desc
limit 5;


-- 6. Solve use cases (monthly trends, top customers, duplicates)

	-- The order date was not in format of date ,it was in text so i converted into date
select month(STR_TO_DATE(`Order Date`, '%m/%d/%Y')), SUM(Sales) from sales_data
group by  month(STR_TO_DATE(`Order Date`, '%m/%d/%Y'));

select `Customer Name`, sum(Sales) from sales_data
group by `Customer Name`
order by sum(Sales) desc
limit 5;

	-- Duplicates
select `Order ID`,count(*) from sales_data
group by `Order ID` 
having count(*)>1;


-- 7. Validate results (row counts, data quality)
select count(*) as Total_rows 
from sales_data;

	-- Missing value count
select count(*) as Missing_IDs from sales_data
where `order ID` is null;

	-- Any Negative values 
select count(*) as Negative_values from sales_data
where Sales<0;

