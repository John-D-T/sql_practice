-- Question 1731


-- join the employee table to the project table
-- we now have a big table with all the project and all the employees and their experiences

-- then we want to perform an aggregation, averaging on 'experience_years' and grouping by project


SELECT p.project_id, ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project p
LEFT JOIN Employee e on p.employee_id = e.employee_id
GROUP BY p.project_id;
