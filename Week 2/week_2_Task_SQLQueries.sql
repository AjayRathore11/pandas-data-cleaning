
-- Table 1
use celebal;
CREATE TABLE customers ( 
    customer_id   INT           PRIMARY KEY, 
    first_name    VARCHAR(50)   NOT NULL, 
    last_name     VARCHAR(50)   NOT NULL, 
    email         VARCHAR(100)  UNIQUE NOT NULL, 
    city          VARCHAR(50)   NOT NULL, 
    state         VARCHAR(50)   NOT NULL, 
    join_date     DATE          NOT NULL, 
    is_premium    BOOLEAN       DEFAULT FALSE 
); 
 
-- Index for filtering by city/state 
CREATE INDEX idx_customers_city ON customers(city); 
CREATE INDEX idx_customers_state ON customers(state);



-- Table 2

CREATE TABLE products ( 
    product_id    INT           PRIMARY KEY, 
    product_name  VARCHAR(100)  NOT NULL, 
    category      VARCHAR(50)   NOT NULL, 
    brand         VARCHAR(50)   NOT NULL, 
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0), 
    stock_qty     INT           NOT NULL  DEFAULT 0  CHECK (stock_qty >= 0) 
); 
 
-- Index for filtering by category 
CREATE INDEX idx_products_category ON products(category); 


-- Table 3
CREATE TABLE orders ( 
    order_id      INT           PRIMARY KEY, 
    customer_id   INT           NOT NULL, 
    order_date    DATE          NOT NULL, 
    status        VARCHAR(20)   NOT NULL  DEFAULT 'Pending' 
                  CHECK (status IN ('Pending','Shipped','Delivered','Cancelled')), 
    total_amount  DECIMAL(12,2) NOT NULL  CHECK (total_amount >= 0), 
     
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
); 
 
-- Index for date-based filtering and sorting 
CREATE INDEX idx_orders_date ON orders(order_date); 
CREATE INDEX idx_orders_status ON orders(status); 


-- Table 4

CREATE TABLE order_items ( 
    item_id       INT           PRIMARY KEY, 
    order_id      INT           NOT NULL, 
    product_id    INT           NOT NULL, 
    quantity      INT           NOT NULL  CHECK (quantity > 0), 
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0), 
    discount_pct  DECIMAL(5,2)  DEFAULT 0 CHECK (discount_pct BETWEEN 0 AND 100), 
     
    FOREIGN KEY (order_id)   REFERENCES orders(order_id), 
    FOREIGN KEY (product_id) REFERENCES products(product_id) 
); 



-- Inserting data into above tables

-- ========== INSERT: customers ========== 
INSERT INTO customers VALUES 
(101, 'Aarav',  'Sharma', 'aarav.s@email.com',  'Mumbai',    'Maharashtra', '2024-01-15', TRUE), 
(102, 'Priya',  'Patel',  'priya.p@email.com',  'Ahmedabad', 'Gujarat',     '2024-02-20', FALSE), 
(103, 'Rohan',  'Gupta',  'rohan.g@email.com',  'Delhi',     'Delhi',       '2024-03-10', TRUE), 
(104, 'Sneha',  'Reddy',  'sneha.r@email.com',  'Hyderabad', 'Telangana',   '2024-04-05', FALSE), 
(105, 'Vikram', 'Singh',  'vikram.s@email.com', 'Jaipur',    'Rajasthan',   '2024-05-12', TRUE), 
(106, 'Ananya', 'Iyer',   'ananya.i@email.com', 'Chennai',   'Tamil Nadu',  '2024-06-18', FALSE), 
(107, 'Karan',  'Mehta',  'karan.m@email.com',  'Pune',      'Maharashtra', '2024-07-22', TRUE), 
(108, 'Divya',  'Nair',   'divya.n@email.com',  'Kochi',     'Kerala',      '2024-08-30', FALSE); 

-- ========== INSERT: products ========== 
INSERT INTO products VALUES 
(201, 'Wireless Earbuds',     'Electronics', 'BoAt',          1499.00, 250), 
(202, 'Cotton T-Shirt',       'Clothing',    'Levis',         799.00,  500), 
(203, 'Smart Watch',          'Electronics', 'Noise',         2999.00, 150), 
(204, 'Running Shoes',        'Clothing',    'Nike',          4599.00, 120), 
(205, 'Bluetooth Speaker',    'Electronics', 'JBL',           3499.00, 200), 
(206, 'Bedsheet Set',         'Home',        'Spaces',        1299.00, 300), 
(207, 'Laptop Stand',         'Electronics', 'AmazonBasics',  899.00,  180), 
(208, 'Cushion Covers (Set)', 'Home',        'HomeCenter',    599.00,  400); 

-- ========== INSERT: orders ========== 
INSERT INTO orders VALUES 
(1001, 101, '2024-08-01', 'Delivered',  4498.00), 
(1002, 102, '2024-08-03', 'Delivered',  799.00), 
(1003, 103, '2024-08-05', 'Shipped',    7498.00), 
(1004, 101, '2024-08-10', 'Delivered',  3499.00), 
(1005, 104, '2024-08-12', 'Cancelled',  2999.00), 
(1006, 105, '2024-08-15', 'Delivered',  5898.00), 
(1007, 106, '2024-08-18', 'Pending',    1299.00), 
(1008, 103, '2024-08-20', 'Delivered',  899.00), 
(1009, 107, '2024-08-25', 'Shipped',    6098.00), 
(1010, 108, '2024-08-28', 'Delivered',  1598.00); 

-- ========== INSERT: order_items ========== 
INSERT INTO order_items VALUES 
(5001, 1001, 201, 2, 1499.00, 0), 
(5002, 1001, 207, 1, 899.00,  10), 
(5003, 1002, 202, 1, 799.00,  0), 
(5004, 1003, 203, 1, 2999.00, 0), 
(5005, 1003, 204, 1, 4599.00, 5), 
(5006, 1004, 205, 1, 3499.00, 0), 
(5007, 1005, 203, 1, 2999.00, 0), 
(5008, 1006, 201, 1, 1499.00, 10), 
(5009, 1006, 204, 1, 4599.00, 5), 
(5010, 1007, 206, 1, 1299.00, 0), 
(5011, 1008, 207, 1, 899.00,  0), 
(5012, 1009, 205, 1, 3499.00, 0), 
(5013, 1009, 208, 2, 599.00,  15), 
(5014, 1010, 206, 1, 1299.00, 0), 
(5015, 1010, 208, 1, 599.00,  0); 



-- Section A (Basics)

-- Q1. Write a query to display all columns and rows from the customer's table. 
select * from customers;

-- Q2. Retrieve only the first_name, last_name, and city of all customers. 
select first_name, last_name, city from customers;

-- Q3. List all unique categories available in the products table. 
select distinct category from products;

-- Q4. Identify the Primary Key of each table in the schema. Explain why a Primary Key must be unique and NOT NULL. 
	/* primary keys are below for every table:
		 customers: customer_id
		 products: product_id
		 orders: order_id
		 order_items: item_id

	 -- a Primary Key must be unique and not null because it serves as the definitive unique identifier for every row in a table.
         It ensures data integrity and enables the database to distinguish between individual records without ambiguity.
     */
     
-- Q5.What constraints are applied to the email column in the customers table? What would happen if you tried to insert a duplicate email?
  /*  -The email column in customers table has two constraints Unique and not null .
		Unique - It means that every single email in that column should be different 
        not null - It means that the email field should not be left blank
	  -If we try to insert duplicate email then the insert operation will be blocked , an duplicate entry error will be shown.
       there will be no changes made in the table.
	*/
    
-- Q6. Try inserting a product with unit_price = -50. What happens and which constraint prevents it? Write both the INSERT statement and explain the error. 
   /* If we try to insrt -50 into unit_price , then the database will throw an error and rejects its insertion ,due to CHECK (unit_price > 0), makig it impossible to 
      accidentally enter a negative price.
    */
    

-- Section B — Filtering & Optimization

-- Q7. Retrieve all orders with status = 'Delivered'. 
select * from orders
where status ='Delivered';

-- Q8. Find all products in the 'Electronics' category with a unit_price greater than ₹2000. 
select * from products 
where category ='Electronics' and unit_price>2000;
     
-- Q9. List all customers who joined in the year 2024 and belong to the state 'Maharashtra'. 
select first_name,last_name,city from customers 
where year(join_date)=2024 and state='Maharashtra';

-- Q10. Find all orders placed between '2024-08-10' and '2024-08-25' (inclusive) that are NOT cancelled. 
select * from orders
where order_date between '2024-08-10' and '2024-08-25' AND status!='Cancelled';

-- Q11. Explain what the index idx_orders_date does. How would it improve the performance of a query that filters orders by order_date? Write a sample query that would benefit from this index. 
   /* - The idx_orders_date index works exactly like the index at the back of a book. It creates a hidden, 
       sorted list of dates that points directly to their specific rows in the table.
	  - With index, it skips the reading and jumps instantly to the matching records, saving a massive amount of time and increase the performance of query
	*/
select order_id, status, total_amount from orders
Where order_date = '2024-08-15';

/* Q12. If you run: SELECT * FROM customers WHERE YEAR(join_date) = 2024; — would the index on join_date be used? 
       Explain why or why not, and rewrite the query to be index-friendly (SARGable). */
	-- No, the index would not be used
    -- Applying the YEAR() function to the column wraps it in a calculation. The database cannot read the raw index directly.
    -- This creates a "non-sargable" condition. The engine must calculate the year for every single row individually.
    -- Because it must evaluate every row anyway, the database optimizer will bypass the index and perform a full table scan.
    
    SELECT * FROM customers 
	WHERE join_date >= '2024-01-01' AND join_date <= '2024-12-31';
  
  
  
-- Section C — Aggregation (GROUP BY, SUM, COUNT, AVG, MIN, MAX) 

-- Q13. Count the total number of orders in the orders table. 
select count(*) as total_orders
from orders;    -- 10

-- Q14. Find the total revenue (SUM of total_amount) from all 'Delivered' orders.
select sum(total_amount) as Total from orders 
where status='Delivered';

-- Q15. Calculate the average unit_price of products in each category.
select category,avg(unit_price) from products
group by category;

-- Q16. For each order status, find the count of orders and the total revenue. Sort the result by total revenue in descending order. 
select status,count(*) as order_count,sum(total_amount) as total_revenue from orders
group by status
order by total_revenue desc;

-- Q17. Find the most expensive (MAX) and cheapest (MIN) product in each category. 
select category,max(unit_price) as most_expensive ,min(unit_price) as cheapest from products
group by category;


-- Q18. List all product categories where the average unit_price is greater than ₹2000. (Hint: Use HAVING clause) 
select category , avg(unit_price) as avg_price from products 
group by category
having avg(unit_price)>2000;


-- Section D — Joins & Relationships 
   
-- Q19. Write an INNER JOIN query to display each order along with the customer's first_name and last_name. Show: order_id, order_date, first_name, last_name, total_amount. 
select o.order_id, o.order_date, c.first_name, c.last_name, o.total_amount from orders as o
inner join customers as c 
on o.customer_id=c.customer_id;

-- Q20. Using a LEFT JOIN, list ALL customers and their orders (if any). Customers with no orders should still appear with NULL values for order columns. 
select c.first_name,c.last_name,o.order_id,o.order_date,o.total_amount 
from customers as c 
left join orders as o 
on c.customer_id=o.customer_id;

-- Q21. Write a query using JOINs across three tables (orders → order_items → products) to show: order_id, product_name, quantity, unit_price, and discount_pct for each order item. 
select o.order_id, p.product_name, oi.quantity, oi.unit_price,oi.discount_pct 
from orders as o 
join order_items as oi 
	on o.order_id=oi.order_id
join products as p 
	on oi.product_id=p.product_id;
    
-- Q22. Explain the difference between LEFT JOIN and RIGHT JOIN with an example from this schema. When would you use a FULL OUTER JOIN? 
	/* Difference 
       - LEFT JOIN: Returns all rows from the left table, and the matched rows from the right table. 
		 If no match is found, NULL values are returned for the right table's columns.
	   - RIGHT JOIN: Returns all rows from the right table, and the matched rows from the left table. 
		 If no match is found, NULL values are returned for the left table's columns.
         
       Full Outer Join: use a Full Outer Join to retain all records from both tables, regardless of whether they match or not.  
       Use Case: It is best used for data auditing, reconciliation, or identifying mismatches. For example, 
				finding all customers who haven't ordered plus any orphaned orders that don't belong to a valid customer.
	*/
    -- Left join
    select c.first_name,o.order_id,o.total_amount
	from customers c
	left join orders o 
    on c.customer_id = o.customer_id;
    
    -- Right join
    select c.first_name,o.order_id,o.total_amount
	from customers c
	right join orders o 
    on c.customer_id = o.customer_id;
    
-- Q23. Identify all Foreign Key relationships in the schema. Explain what would happen if you tried to insert an order with customer_id = 999 (which doesn't exist in customers).
   -- In the orders table, the customer_id links directly to the customer_id in the customers table.
   -- In the order_items table, the order_id links back to the orders table.
   -- Also in the order_items table, the product_id links back to the products table.
   
   /* if you tried to insert an order with customer_id = 999, the database checks the master list of customers and sees that ID 999 is not there. 
       It will not let you create an order for a fake or missing person.*/

/* Q24. Write a query using CASE to classify products into price tiers: 
  • 'Budget'    → unit_price < 1000 
  • 'Mid-Range' → unit_price BETWEEN 1000 AND 3000 
  • 'Premium'   → unit_price > 3000 
   Display: product_name, unit_price, price_tier. */
    
    select product_name, unit_price,
		case
			when unit_price < 1000 then 'Budget'
            when unit_price BETWEEN 1000 AND 3000 then 'Mid-Range'
            else 'Premium'
		end as price_tiers
	from products;
    
-- Q25. Using a CASE statement inside an aggregate function, count how many orders are 'Delivered' vs 'Not Delivered' (all other statuses). Display the result in a single row.
		-- (I found this question a little tricky so i took help of gemini for this question ,first understand the code then i wrote it in mysql)
select 
	sum(case when status='Delivered' then 1 else 0 end) as delivered_count,
    sum(case when status != 'Delivered' then 1 else 0 end) as not_delivered_count
from orders;

/* Q26. Explain each letter of ACID: 
  • A – Atomicity 
  • C – Consistency 
  • I – Isolation 
  • D – Durability 
Give a real-world example (e.g., bank transfer) showing why each property is important. */

    -- Atomicity: A transaction must completely succeed or completely fail. It cannot stop halfway.
    -- Consistency: A transaction must move the database from one valid state to another, maintaining all predefined rules and constraints.
    -- Isolation: Multiple transactions happening at the same time must not interfere with each other. Each transaction runs as if it is the only one.
    -- Durability: Once a transaction is committed, its changes are permanently saved in the database, even if a total system crash or power outage happens immediately after.
    
    /* Example- Imagine you are buying the very last VIP concert ticket online, and you hit "Buy." Atomicity ensures that if your payment connection 
				drops halfway through, the transaction is completely canceled so you aren't charged for a ticket you didn't receive (it's all or nothing). 
				Consistency enforces the database rules, guaranteeing the system never lets the ticket inventory mathematically drop below zero. 
                Isolation ensures that if someone else clicks "Buy" at the exact same millisecond, the database acts like a traffic cop, processing your 
                entire order first before looking at theirs so you don't double-book the same seat. Finally, Durability guarantees that the second your 
                screen says "Order Confirmed," your ticket is permanently saved to the hard drive—meaning even if the ticketing company's servers lose power 
                a moment later, your seat is still securely yours when they reboot.*/
                
                
/* Q27. Write a SQL transaction that does the following atomically: 
  1. Insert a new order (order_id=1011, customer_id=102, today's date, 'Pending', 1598.00) 
  2. Insert two order items for that order 
  3. Update the stock_qty of the purchased products 
  4. If any step fails, ROLLBACK the entire transaction. Otherwise, COMMIT. 
  Write the complete BEGIN...COMMIT/ROLLBACK block. */ 

start transaction;

insert into orders (order_id, customer_id, order_date, status, total_amount)
values (1011, 102, curdate(), 'Pending', 1598.00);

insert into order_items (order_id, product_id, quantity, unit_price)
values 
    (1011, 201, 1, 1000.00),
    (1011, 202, 1, 598.00);

update products 
set stock_qty = stock_qty - 1 
where product_id in (201, 202);

commit;