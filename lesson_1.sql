USE ecommerce_analytics;
SELECT * FROM orders
WHERE status = 'pending'
LIMIT 5;

-- Comparison operators
-- AND, OR, NOT , BETWEEN, IN, LIKE
 
SELECT * FROM orders
WHERE status = 'pending' OR status = 'refunded' OR status = 'cancelled'      -- pending, refunded, cancelled, completed
LIMIT 10;

SELECT * FROM orders
WHERE NOT status = 'completed' -- pending, refunded, cancelled
LIMIT 10;

SELECT * FROM orders
WHERE NOT status = 'completed' AND user_id = 1 -- pending, refunded, cancelled, completed
LIMIT 10;


-- top ten orders between 500 to 3000 in our orders
SELECT * FROM orders
WHERE total_amount BETWEEN 500 AND 3000
ORDER BY total_amount DESC
LIMIT 10;

-- IN
SELECT * FROM orders
WHERE user_id IN (1,2,3,4,5);

-- LIKE
SELECT * FROM users
WHERE country LIKE 'z_%_%'
LIMIT 10;

-- % represents 0,1 or multiple characters ---> wildcard
-- '%Z%' ---> contains Z
-- _ reprents exactly one single character  --> 'a_%_%' --starts with a and atleast 3 characters long

-- Aggregate Functions
-- COUNT(), SUM(), AVG(), MIN(), MAX(), GROUP BY, HAVING 



SELECT * FROM orders
LIMIT 10;

-- calculate the total_amount of sales per status  ----> completed, cancelled, refunded, pending
SELECT 
	status,
	SUM(total_amount) AS sum_per_status  -- calculated
FROM orders 
WHERE total_amount BETWEEN 500 AND 3000
GROUP BY status
ORDER BY sum_per_status DESC;

-- how you write the query
-- SELECT    
-- FROM
-- JOIN
-- WHERE
-- GROUP BY
-- HAVING
-- ORDER BY
-- LIMIT

SELECT  -- 6
	status,
	SUM(total_amount) AS sum_per_status  -- calculated -- 4  and sum_per_status column added to the grouped table
FROM orders    -- 1
WHERE total_amount BETWEEN 500 AND 3000 -- filtering before calculation(aggregation)  -- 2
GROUP BY status   -- 3
HAVING sum_per_status > 60000   -- filter after a calculation  -- 5
ORDER BY sum_per_status DESC;  -- 7 


CREATE VIEW totals_per_status AS(
SELECT  -- 6
	status,
	SUM(total_amount) AS sum_per_status  -- calculated -- 4  and sum_per_status column added to the grouped table
FROM orders    -- 1
WHERE total_amount BETWEEN 500 AND 3000 -- filtering before calculation(aggregation)  -- 2
GROUP BY status   -- 3
ORDER BY sum_per_status DESC  -- 7 
);

SELECT * FROM totals_per_status;

CREATE VIEW employeeDirectory AS (
SELECT  employeeid, firts_name, last_name
FROM employee
);

DROP VIEW totals_per_status;


