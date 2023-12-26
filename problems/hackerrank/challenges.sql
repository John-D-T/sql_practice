
-- we want hacker_id, name, and total_number of challengers

-- create a CTE with several key variables
    -- COUNT
    -- COUNT of the COUNT
    -- MAX of the count
-- use the GROUP BY to help with these windowing functions

-- then select from the cte where the COUNT of the COUNT is 1, or the count = the max of the count

WITH cte AS (
SELECT h.hacker_id, h.name,
       COUNT(*) AS challenge_count,
       COUNT(*) OVER (PARTITION BY COUNT(*)) AS number_of_challenge_counts,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS challenge_rank
FROM Challenges c
LEFT JOIN Hackers h ON c.hacker_id = h.hacker_id
GROUP BY h.hacker_id, h.name
)


SELECT ct.hacker_id, ct.name, ct.challenge_count
FROM cte ct
WHERE ct.number_of_challenge_counts = 1
OR    ct.challenge_rank = 1
ORDER BY ct.challenge_count DESC, ct.hacker_id ASC;