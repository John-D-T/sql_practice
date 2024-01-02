-- first CTE is to generate a unique number for each person in each occupation
-- overlap in numbers between different occupations is fine for this pivot

-- then second CTE is to then group up all the row_number=1, row_number=2, etc...
-- if there is a match on the occupation and row_number, we use the name
-- else it's NULL - this is implicit
-- max isn't important, it's just to allow for the aggregation function to work



WITH cte AS (
    SELECT
        Occupation,
        Name,
        ROW_NUMBER() over(PARTITION BY Occupation ORDER BY Name ASC) AS NameOrder
    FROM Occupations
),
cte_2 AS (
    SELECT
        NameOrder,
        MAX(CASE WHEN Occupation = 'Doctor' THEN Name END) AS Doctor,
        MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
        MAX(CASE WHEN Occupation = 'Singer' THEN Name END) AS Singer,
        MAX(CASE WHEN Occupation = 'Actor' THEN Name END) AS Actor
    FROM cte
    GROUP BY NameOrder
)

SELECT Doctor, Professor, Singer, Actor
FROM cte_2;