-- Problem 1

-- List the case number, type of crime and community area for all crimes in community area number 18.
SELECT a.case_number, a.primary_type, b.community_area_name FROM chicago_crime_data AS a
	INNER JOIN census_data AS b
	ON a.community_area_number = b.community_area_number;

-- Problem 2

-- List all crimes that took place at a school. Include case number, crime type and community name.
SELECT a.case_number, a.primary_type, b.community_area_name FROM chicago_crime_data AS a
	LEFT JOIN census_data AS b
	ON a.community_area_number = b.community_area_number
	WHERE UPPER(a.location_description) LIKE '%SCHOOL%';

-- Problem 3

-- For the communities of Oakland, Armour Square, Edgewater and CHICAGO list the associated community_area_numbers and the case_numbers.
-- DB2 solution
SELECT b.community_area_name, b.community_area_number, a.case_number
FROM chicago_crime_data AS a
FULL OUTER JOIN census_data AS b
	ON a.community_area_number = b.community_area_number
WHERE b.community_area_name
	  IS NULL
	  OR UPPER(b.community_area_name)
	      IN (UPPER('Oakland'), UPPER('Armour Square'), UPPER('Edgewater'), UPPER('CHICAGO'));

-- MySQL solution
SELECT b.community_area_name, b.community_area_number, a.case_number FROM chicago_crime_data AS a
LEFT JOIN census_data as b ON a.community_area_number = b.community_area_number
WHERE UPPER(b.community_area_name) IN (UPPER('Oakland'), UPPER('Armour Square'), UPPER('Edgewater'), UPPER('CHICAGO'))
UNION
SELECT b.community_area_name, b.community_area_number, a.case_number FROM chicago_crime_data AS a
RIGHT JOIN census_data as b ON a.community_area_number = b.community_area_number
WHERE UPPER(b.community_area_name) IN (UPPER('Oakland'), UPPER('Armour Square'), UPPER('Edgewater'), UPPER('CHICAGO'))
ORDER BY community_area_name