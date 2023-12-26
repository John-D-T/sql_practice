-- simple one, easy to overthink

-- to return an integer, just perform a count
    -- no groupby needed, or anything


SELECT
COUNT(city) - COUNT(DISTINCT city)
FROM Station;