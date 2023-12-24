-- first creating a common table expression to get the:
    -- max length city (window function)
    -- min length city (window function)
    -- length of each city name

-- second cte then builds on the first one, and ranks each city in their city length grouping
    -- 1 is assigned to the alphabetically first one

-- then we query the station table, joined to the second cte table to get cities which are:
    -- the longest or shortest city names
    -- and the earliest alphabetically if there is more than one city with the longest name

WITH
cte AS (
SELECT city,
    MAX(LENGTH(city)) OVER () as max_length,
    MIN(LENGTH(city)) OVER () as min_length,
    LENGTH(city) as city_length
FROM station
),
cte_2 AS (
SELECT *,
    ROW_NUMBER() OVER (PARTITION BY city_length ORDER BY city) as alphabet_rank
FROM cte
)

SELECT s.city, c.city_length
FROM STATION s
LEFT JOIN cte_2 c
ON (s.city = c.city)
WHERE ((c.city_length = c.max_length)
OR (c.city_length = c.min_length))
AND c.alphabet_rank = 1;