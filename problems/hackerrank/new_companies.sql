/*
Enter your query here.
*/

-- tables: company, lead_manager, senior_manager, manager, employee
-- aliases: c, l, s, m, e
-- join on company_code
-- can't just join to employee due to redundancy
--     actually, since we perform a distinct count, we can just join company to employee

-- aggregation (group by company code and founder) to get number of underlings


SELECT c.company_code, c.founder, COUNT(DISTINCT e.lead_manager_code), COUNT(DISTINCT e.senior_manager_code),
        COUNT(DISTINCT e.manager_code), COUNT(DISTINCT e.employee_code)
FROM Company c
LEFT JOIN Employee e ON c.company_code = e.company_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code;