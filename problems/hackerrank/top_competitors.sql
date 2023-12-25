-- join the hacker table to the the challenges table, then the difficulty table (we just want the difficulty column from these joins)
    -- then using the challenge id, join this to the submission table

-- obtain hacker id, hacker name
-- filter on those who've obtained a full score for more than one challenge
-- order by number of full scores, then by hacker id

-- CTE doesn't work on MySql, only MSSQL


-- WIP
WITH cte AS (
    SELECT h.hacker_id, h.name, d.difficulty_level, d.score, c.challenge_id
    FROM Challenges c
    LEFT JOIN Hackers h
    ON c.hacker_id = h.hacker_id
    LEFT JOIN Difficulty d
    ON c.difficulty_level = d.difficulty_level
),
cte_2 AS (
SELECT s.hacker_id, c.name, s.score, COUNT(name) OVER (PARTITION BY name)
FROM Submissions s
LEFT JOIN cte c
ON s.challenge_id = c.challenge_id
WHERE s.score = (c.difficulty_level * 20)
)

SELECT * FROM
cte_2
WHERE COUNT(DISTINCT name) > 2;