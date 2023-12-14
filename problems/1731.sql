-- Question 1731


-- we have the employees table
-- we can self join on employee_id = reports_to
-- now we have a big table, where every individual has a row for each person who reports to them

WITH cte AS (
    SELECT e1.employee_id AS manager_id, e1.name AS manager_name, e2.name AS employee_name, e2.age AS employee_age
    FROM Employees e1
    LEFT JOIN Employees e2 ON e1.employee_id = e2.reports_to

    -- we filter out those who have no individuals under them - not managers
    WHERE e2.reports_to is NOT NULL
)


-- When adding columns which you aren't aggregating, you need to have them in the GROUP BY statement.
SELECT manager_id AS employee_id, manager_name AS name, COUNT(employee_name) AS reports_count, ROUND(AVG(employee_age)) AS average_age
FROM cte
GROUP BY manager_id, manager_name

-- this part isn't important, it's just to make sure the row order matches leetcode's expected output.
ORDER BY employee_id;
