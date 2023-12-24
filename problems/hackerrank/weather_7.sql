
-- selecting distinct to avoid duplicate city entries

-- using a right(city, 1) to get the last character to the right of the city name

-- using an "in ()" to check the string against a list of options

SELECT DISTINCT city
FROM station
WHERE RIGHT(city, 1) IN ("a","e","i","o","u");