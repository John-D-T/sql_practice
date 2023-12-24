-- Question 596

-- Use a CTE to find out how many students are in each course

WITH cte AS (
    SELECT class, COUNT(class) AS unique_students
    FROM Courses
    GROUP BY class
)

-- Then filter on classes where there are 5 or more students

SELECT class
FROM cte
WHERE unique_students >= 5;