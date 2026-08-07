SELECT * FROM ecommerce_analytics.totals_per_status;   -- view is permanent

-- Common Table Expression (CTE) --> a named subquery or a temporary table
-- temporary, discarded after query execution
-- defined inside the sql script/application code
-- only reusable within that specific query that they are created in
-- cannot bo used to restrict data access privileges
-- us cases; break down complex queries 

-- WITH name_cte AS (
--
-- normal query
-- )
-- SELECT * FROM name_cte WHERE filter;
-- SELECT * FROM name_cte WHERE filter;

WITH total_status_cte AS (
SELECT 
	status,
	SUM(total_amount) AS sum_per_status  
FROM orders    
WHERE total_amount BETWEEN 500 AND 3000 
GROUP BY status   
ORDER BY sum_per_status DESC 
)
 -- usage -----
SELECT *
FROM total_status_cte
WHERE sum_per_status < 50000;



SELECT *
FROM total_status_cte;



-- subqueries 
SELECT * 
FROM (
	SELECT 
		status,
		SUM(total_amount) AS sum_per_status  
	FROM orders    
	WHERE total_amount BETWEEN 500 AND 3000 
	GROUP BY status   
	ORDER BY sum_per_status DESC) AS total_status

WHERE sum_per_status < 50000; 

--  window functions 
-- ---> peform calculations across a set of table rows that a related to the current row wothout collapsing  the rows into a single output like GROPU BY 
-- running totals,  1 , 2, ,3, -- 1 --->3---->6, rankings, moving averages

-- PARTITION BY ---> GROUP BY

-- SELECT 
-- column1, 
-- FUNCTION() OVER (PARTITION BY column2 ORDER BY column3) AS window_result
-- FROM table_name;

-- main cats & functions 
-- 1. Ranking Functions 
-- ROW_NUMBER() --> Assign unique sequntial int  ----> SELECT salary, ROW_NUMBER() OVER (PARTITOIN BY department ORDER BY salary) AS salary_rank FROM employees; 1 2 3
-- DENSE_RANK() --> assign a rank based on ordering --->  earn the same salary 1 1 2 -- next rank number is not skipped
-- RANK() --> assign rank based on ordering ---> if a tie 1 1 3 -- next rank number is skipped

-- 2. Value Functions
-- LAG(col, offset) --> fetch a value from a previous row in a partion(default is 1 row back)
-- LEAD(col, offset) --> 1,2,3,4 fetch a value from a subseunt row in a partition(default is 1 row foward)
-- FIRST_VALUE(col)/LAST_VALUE(col) --> 


-- 3. Aggregate functions
-- to create running totals or moving averages,  AVG(), COUNT() SUM()


SELECT * FROM ecommerce_analytics.products;

WITH rankedrows AS(
	-- RANK products by unit_price within the category
	SELECT 
		p.product_id, 
		p.category, 
		p.product_name, 
		p.unit_price,
		DENSE_RANK() OVER (PARTITION BY p.category ORDER BY p.unit_price DESC) AS price_rank
	FROM products p)
    
SELECT * 
FROM rankedrows
WHERE price_rank <=3;


-- JOINS
-- combines rows from 2 or more tables based on the related column between them(PK,FK)
-- INNER JOIN
   -- Returns rows only when there is a match in both tables table1 as t1 table2 as t2 ---on t1.user_id = t2.user_id
-- LEFT JOIN 
   -- Return all rows of the left table plus matching rows on the right table
-- RIGHT JOIN 
   -- Return all rows on right table plus matching rows on left table
-- CROSS JOIN - return every row in both tables(left & right)


-- asked to retrieve emails for all users who have pending orders to that we can send the a reminder email to complete
SELECT 
	u.user_id,
	o.order_id,
	u.country,
	u.email,
	u.plan_type,
	u.is_active,
    o.order_date,
    o.status,
    o.total_amount
FROM ecommerce_analytics.users AS u -- first table( left)
RIGHT JOIN ecommerce_analytics.orders AS o
ON o.user_id = u.user_id
WHERE o.status = 'pending';



 
 

	
