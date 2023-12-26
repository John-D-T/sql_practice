-- CTE doesn't work on MySql, only MSSQL


-- SELECT hacker_id, name
-- FROM Submissions joined to all tables (in order to get the h.hacker_name, d.score)
-- Pre-group, filtering on those with full scores
-- We group by hacker_id and name (to avoid duplicate rows, and also so we can select both columns)
-- HAVING the count of submissions > 1, so we only keep the grouped columns which fulfill those conditions
-- Then we order by number of full scores, then hacker_id

SELECT s.hacker_id, h.name
FROM Submissions s
LEFT JOIN Challenges c ON s.challenge_id = c.challenge_id
LEFT JOIN Difficulty d ON c.difficulty_level = d.difficulty_level
LEFT JOIN Hackers h ON s.hacker_id = h.hacker_id
WHERE s.score = d.score
GROUP BY s.hacker_id, h.name
HAVING COUNT(s.submission_id) > 1
ORDER BY COUNT(s.submission_id) DESC, s.hacker_id;



-- WIP cte solution
WITH cte AS (
    SELECT h.hacker_id, h.name, d.difficulty_level, s.score, c.challenge_id, s.submission_id, d.score AS d_score
    FROM Submissions s
    LEFT JOIN Challenges c ON s.challenge_id = c.challenge_id
    LEFT JOIN Hackers h    ON c.hacker_id = h.hacker_id
    LEFT JOIN Difficulty d ON c.difficulty_level = d.difficulty_level
),
cte_2 AS (
SELECT c1.hacker_id, c1.name, c1.score, COUNT(c1.submission_id) OVER (PARTITION BY c1.hacker_id) AS number_of_full_scores
FROM cte c1
WHERE c1.score = c1.d_score
)

-- need to remove duplicate rows from here
SELECT c2.hacker_id, c2.name FROM
cte_2 c2
WHERE c2.number_of_full_scores >= 1
GROUP BY c2.hacker_id, c2.name
ORDER BY COUNT(c2.hacker_id) DESC, c2.hacker_id;