-- Question 1757

-- select product_id from the Products table
-- Filter on low_fats and recyclable columns1757.sql

SELECT p.product_id
FROM Products p
WHERE p.low_fats = 'Y'
AND p.recyclable = 'Y';