-- we have hackers, and submissions

-- hacker_id, name, total_score of the hackers

-- filter out hackers with a total_score of 0
-- order by total_score desc, then hacker_id

--CTE first to determine highest score (ROW_NUMBER, partition by hacker_id and challenge ORDER BY score DESC)
    -- CTE to determine total_score (summation of all a hackers highest scores)
        -- then a query to read from that

WITH cte_1 AS (
    SELECT s.submission_id, s.hacker_id, h.name, s.challenge_id, s.score,
    ROW_NUMBER() OVER (PARTITION BY s.hacker_id, s.challenge_id ORDER BY s.score DESC) AS highest_score
    FROM Submissions s
    LEFT JOIN Hackers h ON s.hacker_id = h.hacker_id
),

cte_2 AS (
    SELECT ct1.hacker_id, ct1.name, SUM(ct1.score) AS total_score
    FROM cte_1 ct1
    WHERE ct1.highest_score = 1
    GROUP BY ct1.hacker_id, ct1.name
)

SELECT ct2.hacker_id, ct2.name, ct2.total_score
FROM cte_2 ct2
WHERE ct2.total_score <> 0
ORDER BY ct2.total_score DESC, ct2.hacker_id ASC;