-- we want the names + 'left bracket' + left(occupation, 1) + 'right bracket' - use concat
-- from occupation table
-- sorted by name

-- then select count of name
-- grouped by occupation
-- order by name


SELECT CONCAT(o.name, '(', LEFT(o.occupation, 1), ')')
FROM Occupations o
ORDER BY o.name ASC;

SELECT CONCAT('There are a total of ', COUNT(o2.name), ' ', LOWER(o2.occupation),'s.')
FROM Occupations o2
GROUP BY o2.occupation
ORDER BY COUNT(o2.name) ASC, o2.occupation ASC;