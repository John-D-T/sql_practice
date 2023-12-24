-- Question 1045

-- select number of distinct product keys per customer_id
-- then select where that number equals the count of the product key table

WITH distinct_product_keys AS (
  SELECT DISTINCT c.customer_id, c.product_key
  FROM Customer c
),

counted_product_keys AS (
  SELECT dpk.customer_id, COUNT(dpk.product_key) AS unique_product_keys
  FROM distinct_product_keys dpk
  GROUP BY dpk.customer_id
)

-- Alt solution: Skips having to create another CTE and perform a JOIN
-- SELECT cpk.customer_id
-- FROM counted_product_keys cpk
-- WHERE (unique_product_keys) = (SELECT COUNT(*) FROM Product);

,
number_of_products AS (
  SELECT COUNT(*) as total_products
  FROM Product
)

SELECT cpk.customer_id
FROM counted_product_keys cpk
JOIN number_of_products nop
ON cpk.unique_product_keys = nop.total_products;