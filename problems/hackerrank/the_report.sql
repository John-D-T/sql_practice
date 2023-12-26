-- we want name, grade, and mark
-- grade has to be higher than 8 (aka mark has to be >=80)
-- if it's 1-7, set name to NULL
-- GRADE 8+ order the grades descending, then by name
-- GRADE 1-7 order the grades descending, then by marks ascending

-- first join the two tables together, and retrieve rows of interest
-- then we perform two case/whens to handle the two subsets of grades (1-7, 8-10)
WITH cte AS (
SELECT s.Name, g.Grade, s.Marks
FROM Students s
JOIN Grades g
ON s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
)

SELECT
CASE
    WHEN c.Grade >= 8 THEN c.Name
    ELSE NULL
END AS Name,
c.Grade, c.Marks
FROM cte c
ORDER BY c.Grade DESC, (
CASE
    WHEN c.Grade >= 8 THEN c.name
    ELSE c.Marks
END) ASC;