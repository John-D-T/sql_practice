/*
Enter your query here.
*/

-- three methods:
--  cte
--  subquery
--  order by and limit 1

--  cte

 WITH cte AS (
 SELECT MAX(LAT_N) as max_lat
 FROM Station
 WHERE LAT_N < 137.2345
 )

 SELECT ROUND(s.LONG_W, 4) AS long_w_max
 FROM Station s
 LEFT JOIN cte c ON s.LAT_N = c.max_lat
 WHERE c.max_lat is NOT NULL;


--  subquery

 SELECT ROUND(LONG_W, 4)
 FROM Station
 WHERE LAT_N = (SELECT MAX(LAT_N)
 FROM Station
 WHERE LAT_N < 137.2345);



-- order by and limit 1

SELECT ROUND(LONG_W, 4)
FROM Station
WHERE LAT_N < 137.2345
ORDER BY LAT_N DESC
LIMIT 1;