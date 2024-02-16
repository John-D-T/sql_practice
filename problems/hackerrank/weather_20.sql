-- median = count / 2 + 1
-- median: row_number = count/2 + 1

WITH cte AS (
            SELECT LAT_N, ROW_NUMBER() OVER (ORDER BY LAT_N) AS lat_n_row
            FROM STATION)

SELECT CAST(LAT_N AS decimal(10,4))
FROM cte
WHERE lat_n_row = ((SELECT COUNT(ID) AS total_count FROM STATION) / 2) + 1;