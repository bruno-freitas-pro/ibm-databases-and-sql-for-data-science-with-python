/* Use a sub-query to determine the Community Area Name with most number of crimes */

SELECT
    community_area_number,
    community_area_name,
    -- The following sub-query is intended for only listing total_crimes, and is not explicitly required by the exercise.
    (
     SELECT
         count(*) as total_crimes
     FROM
         CHICAGO_CRIME_DATA
     GROUP BY community_area_number
     ORDER BY
         -- send NULLS to the end of the list, then order by the line count
         CASE WHEN community_area_number IS NULL THEN 1 ELSE 0 END,
         COUNT(*) DESC LIMIT 1
    )
FROM
    CENSUS_DATA
WHERE
    community_area_number = (
                             SELECT
                                 community_area_number
                             FROM
                                 CHICAGO_CRIME_DATA
                             GROUP BY community_area_number
                             ORDER BY
                                 -- send NULLS to the end of the list, then order by the line count
                                 CASE WHEN community_area_number IS NULL THEN 1 ELSE 0 END,
                                 COUNT(*) DESC LIMIT 1
    )
