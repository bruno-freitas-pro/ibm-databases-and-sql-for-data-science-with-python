-- Exercise 1: Using JOINS

-- Question 1
-- Write and execute a SQL query to list the school names, community names and average attendance for communities with a hardship index of 98.

SELECT	a.name_of_school 				AS "School Name",
		a.community_area_name 			AS "Community Area Name",
		a.average_student_attendance 	AS "Average Student Attendance",
		a.average_teacher_attendance	AS "Average Teacher Attendance",
		b.hardship_index				AS "Hardship Index"
FROM chicago_public_schools AS a
LEFT JOIN census_data AS b
ON a.community_area_number = b.community_area_number
WHERE b.hardship_index = 98;

-- Question 2
-- Write and execute a SQL query to list all crimes that took place at a school. Include case number, crime type and community name.

SELECT a.case_number, a.primary_type, b.community_area_name, a.location_description FROM chicago_crime_data AS a
	LEFT JOIN census_data AS b
	ON a.community_area_number = b.community_area_number
	WHERE UPPER(location_description) LIKE '%SCHOOL%';

-- Exercise 2: Creating a view

/* 	For privacy reasons, you have been asked to create a view that enables users to select just the school name and the icon fields from the CHICAGO_PUBLIC_SCHOOLS table.
**	By providing a view, you can ensure that users cannot see the actual scores given to a school, just the icon associated with their score.
**	You should define new names for the view columns to obscure the use of scores and icons in the original table.
*/

-- Question 1
-- Write and execute a SQL statement to create a view showing the columns listed in the following table, with new column names as shown in the second column.

CREATE VIEW chicago_public_schools_ratings (School_Name, Safety_Rating, Family_Rating, Environment_Rating, Instruction_Rating, Leaders_Rating, Teachers_Rating)
	AS SELECT NAME_OF_SCHOOL, Safety_Icon, Family_Involvement_Icon, Environment_Icon, Instruction_Icon, Leaders_Icon, Teachers_Icon
	   FROM chicago_public_schools;

-- Write and execute a SQL statement that returns all of the columns from the view.

SELECT * FROM chicago_public_schools_ratings;

-- Write and execute a SQL statement that returns just the school name and leaders rating from the view.

SELECT School_Name, Leaders_Rating FROM chicago_public_schools_ratings;

-- Exercise 3: Creating a Stored Procedure

/*	The icon fields are calculated based on the value in the corresponding score field.
**	You need to make sure that when a score field is updated, the icon field is updated too.
**	To do this, you will write a stored procedure that receives the school id and a leaders score as input parameters,
**	calculates the icon setting and updates the fields appropriately.
*/

-- Question 1

/*	Write the structure of a query to create or replace a stored procedure called
**	UPDATE_LEADERS_SCORE that takes a in_School_ID parameter as an integer and a in_Leader_Score parameter as an integer.
**	Don't forget to use the #SET TERMINATOR statement to use the @ for the CREATE statement terminator.
*/

-- Db2 Solution

--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE
	(IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)

LANGUAGE SQL
BEGIN

	UPDATE CHICAGO_PUBLIC_SCHOOLS
	
	SET
	LEADERS_SCORE = in_Leader_Score
	
	WHERE SCHOOL_ID = in_School_ID;

END
@
--#SET TERMINATOR ;

-- MySQL Solution
DROP PROCEDURE IF EXISTS UPDATE_LEADERS_SCORE;

DELIMITER //
CREATE PROCEDURE UPDATE_LEADERS_SCORE
	(IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)

BEGIN

	UPDATE CHICAGO_PUBLIC_SCHOOLS
	
	SET
	LEADERS_SCORE = in_Leader_Score
	
	WHERE SCHOOL_ID = in_School_ID;
	
END //
DELIMITER ;

-- Question 2

/* Inside your stored procedure, write a SQL statement to update the Leaders_Score field in the CHICAGO_PUBLIC_SCHOOLS table
** for the school identified by in_School_ID to the value in the in_Leader_Score parameter.
*/

-- Db2 Solution

--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE
	(IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)

LANGUAGE SQL
BEGIN

	UPDATE CHICAGO_PUBLIC_SCHOOLS
	
	SET
	LEADERS_SCORE = in_Leader_Score
	
	WHERE SCHOOL_ID = in_School_ID;

END
@
--#SET TERMINATOR ;

-- MySQL Solution

DROP PROCEDURE IF EXISTS UPDATE_LEADERS_SCORE;

DELIMITER //
CREATE PROCEDURE UPDATE_LEADERS_SCORE
	(IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)

BEGIN

	UPDATE CHICAGO_PUBLIC_SCHOOLS
	
	SET
	LEADERS_SCORE = in_Leader_Score
	
	WHERE SCHOOL_ID = in_School_ID;
	
END //
DELIMITER ;

-- Question 3
/* Inside your stored procedure, write a SQL IF statement to update the Leaders_Icon field in the CHICAGO_PUBLIC_SCHOOLS table
** for the school identified by in_School_ID using the following information.
*/

-- Db2 Solution

--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE
	(IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)

LANGUAGE SQL
MODIFIES SQL DATA

BEGIN

	UPDATE CHICAGO_PUBLIC_SCHOOLS
	SET LEADERS_SCORE = in_Leader_Score
	WHERE SCHOOL_ID = in_School_ID;
	
	IF in_Leader_Score > 0 AND in_Leader_Score < 20 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Very weak'
		WHERE SCHOOL_ID = in_School_ID;

	ELSEIF in_Leader_Score >= 20 AND in_Leader_Score < 40 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Weak'
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 40 AND in_Leader_Score < 60 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Average'
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 60 AND in_Leader_Score < 80 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Strong'
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 80 AND in_Leader_Score < 100 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Very strong'
		WHERE SCHOOL_ID = in_School_ID;
		
	END IF;
END
@
--#SET TERMINATOR ;

-- MySQL Solution

DROP PROCEDURE IF EXISTS UPDATE_LEADERS_SCORE;

DELIMITER //
CREATE PROCEDURE UPDATE_LEADERS_SCORE
	(IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)

BEGIN

	UPDATE chicago_public_schools
	SET LEADERS_SCORE = in_Leader_Score
	WHERE SCHOOL_ID = in_School_ID;
	
	IF in_Leader_Score > 0 AND in_Leader_Score < 20 THEN
		UPDATE chicago_public_schools
		SET Leaders_Icon = 'Very weak'
		WHERE SCHOOL_ID = in_School_ID;

	ELSEIF in_Leader_Score >= 20 AND in_Leader_Score < 40 THEN
		UPDATE chicago_public_schools
		SET Leaders_Icon = 'Weak'
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 40 AND in_Leader_Score < 60 THEN
		UPDATE chicago_public_schools
		SET Leaders_Icon = 'Average'
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 60 AND in_Leader_Score < 80 THEN
		UPDATE chicago_public_schools
		SET Leaders_Icon = 'Strong'
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 80 AND in_Leader_Score < 100 THEN
		UPDATE chicago_public_schools
		SET Leaders_Icon = 'Very strong'
		WHERE SCHOOL_ID = in_School_ID;
		
	END IF;
    
END //
DELIMITER ;

-- Question 4
-- Run your code to create the stored procedure.

-- Question 5
/* Write a query to call the stored procedure, passing a valid school ID and a leader score of 50, to check that the procedure works as expected.
*/

-- Db2 Solution

SELECT SCHOOL_ID, LEADERS_SCORE, LEADERS_ICON FROM CHICAGO_PUBLIC_SCHOOLS WHERE SCHOOL_ID = 609737;

CALL UPDATE_LEADERS_SCORE (609737, 50);

SELECT SCHOOL_ID, LEADERS_SCORE, LEADERS_ICON FROM CHICAGO_PUBLIC_SCHOOLS WHERE SCHOOL_ID = 609737;

-- MySQL Solution

SELECT SCHOOL_ID, LEADERS_SCORE, LEADERS_ICON FROM chicago_public_schools WHERE SCHOOL_ID = 609737;

CALL UPDATE_LEADERS_SCORE (609737, 50);

SELECT SCHOOL_ID, LEADERS_SCORE, LEADERS_ICON FROM chicago_public_schools WHERE SCHOOL_ID = 609737;

-- Exercise 4: Using Transactions
/* You realise that if someone calls your code with a score outside of the allowed range (0-99),
** then the score will be updated with the invalid data and the icon will remain at its previous value.
** There are various ways to avoid this problem, one of which is using a transaction.
*/

-- Question 1
/* Update your stored procedure definition.
** Add a generic ELSE clause to the IF statement that rolls back the current work if the score did not fit any of the preceding categories.
*/

-- Db2 Solution
--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE
	(IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)

LANGUAGE SQL
MODIFIES SQL DATA

BEGIN

	UPDATE CHICAGO_PUBLIC_SCHOOLS
	SET LEADERS_SCORE = in_Leader_Score
	WHERE SCHOOL_ID = in_School_ID;
	
	IF in_Leader_Score > 0 AND in_Leader_Score < 20 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Very weak'
		WHERE SCHOOL_ID = in_School_ID;

	ELSEIF in_Leader_Score >= 20 AND in_Leader_Score < 40 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Weak'
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 40 AND in_Leader_Score < 60 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Average'
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 60 AND in_Leader_Score < 80 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Strong'
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 80 AND in_Leader_Score < 100 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Very strong'
		WHERE SCHOOL_ID = in_School_ID;

	ELSE ROLLBACK WORK;

	END IF;
END
@
--#SET TERMINATOR ;

-- MySQL Solution

DROP PROCEDURE IF EXISTS UPDATE_LEADERS_SCORE;

DELIMITER //
CREATE PROCEDURE UPDATE_LEADERS_SCORE
	(IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)

BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	START TRANSACTION;
	
	IF in_Leader_Score > 0 AND in_Leader_Score < 20 THEN
		UPDATE chicago_public_schools
		SET Leaders_Icon = 'Very weak', LEADERS_SCORE = in_Leader_Score
		WHERE SCHOOL_ID = in_School_ID;

	ELSEIF in_Leader_Score >= 20 AND in_Leader_Score < 40 THEN
		UPDATE chicago_public_schools
		SET Leaders_Icon = 'Weak', LEADERS_SCORE = in_Leader_Score
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 40 AND in_Leader_Score < 60 THEN
		UPDATE chicago_public_schools
		SET Leaders_Icon = 'Average', LEADERS_SCORE = in_Leader_Score
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 60 AND in_Leader_Score < 80 THEN
		UPDATE chicago_public_schools
		SET Leaders_Icon = 'Strong', LEADERS_SCORE = in_Leader_Score
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 80 AND in_Leader_Score < 100 THEN
		UPDATE chicago_public_schools
		SET Leaders_Icon = 'Very strong', LEADERS_SCORE = in_Leader_Score
		WHERE SCHOOL_ID = in_School_ID;
	    
	END IF;
    
    COMMIT;
    
END //
DELIMITER ;


-- Question 2
/* Update your stored procedure definition again. Add a statement to commit the current unit of work at the end of the procedure.
*/

-- Db2 Solution

--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE
	(IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)

LANGUAGE SQL
MODIFIES SQL DATA

BEGIN

	UPDATE CHICAGO_PUBLIC_SCHOOLS
	SET LEADERS_SCORE = in_Leader_Score
	WHERE SCHOOL_ID = in_School_ID;
	
	IF in_Leader_Score > 0 AND in_Leader_Score < 20 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Very weak'
		WHERE SCHOOL_ID = in_School_ID;

	ELSEIF in_Leader_Score >= 20 AND in_Leader_Score < 40 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Weak'
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 40 AND in_Leader_Score < 60 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Average'
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 60 AND in_Leader_Score < 80 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Strong'
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 80 AND in_Leader_Score < 100 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET Leaders_Icon = 'Very strong'
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSE ROLLBACK WORK;

	END IF;
	COMMIT WORK;
END
@
--#SET TERMINATOR ;

-- MySQL Solution

DROP PROCEDURE IF EXISTS UPDATE_LEADERS_SCORE;

DELIMITER //
CREATE PROCEDURE UPDATE_LEADERS_SCORE
	(IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)

BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	START TRANSACTION;
	
	IF in_Leader_Score > 0 AND in_Leader_Score < 20 THEN
		UPDATE chicago_public_schools
		SET Leaders_Icon = 'Very weak', LEADERS_SCORE = in_Leader_Score
		WHERE SCHOOL_ID = in_School_ID;

	ELSEIF in_Leader_Score >= 20 AND in_Leader_Score < 40 THEN
		UPDATE chicago_public_schools
		SET Leaders_Icon = 'Weak', LEADERS_SCORE = in_Leader_Score
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 40 AND in_Leader_Score < 60 THEN
		UPDATE chicago_public_schools
		SET Leaders_Icon = 'Average', LEADERS_SCORE = in_Leader_Score
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 60 AND in_Leader_Score < 80 THEN
		UPDATE chicago_public_schools
		SET Leaders_Icon = 'Strong', LEADERS_SCORE = in_Leader_Score
		WHERE SCHOOL_ID = in_School_ID;
		
	ELSEIF in_Leader_Score >= 80 AND in_Leader_Score < 100 THEN
		UPDATE chicago_public_schools
		SET Leaders_Icon = 'Very strong', LEADERS_SCORE = in_Leader_Score
		WHERE SCHOOL_ID = in_School_ID;
	    
	END IF;
    
    COMMIT;
    
END //
DELIMITER ;

/* Run your code to replace the stored procedure.
*/

/* Write and run one query to check that the updated stored procedure works as expected when you use a valid score of 38.
*/

-- MySQL Solution

SELECT SCHOOL_ID, LEADERS_SCORE, LEADERS_ICON FROM chicago_public_schools WHERE SCHOOL_ID = 609737;

CALL UPDATE_LEADERS_SCORE (609737, 38);

SELECT SCHOOL_ID, LEADERS_SCORE, LEADERS_ICON FROM chicago_public_schools WHERE SCHOOL_ID = 609737;

/* Write and run another query to check that the updated stored procedure works as expected when you use an invalid score of 101.
*/

-- MySQL Solution

SELECT SCHOOL_ID, LEADERS_SCORE, LEADERS_ICON FROM chicago_public_schools WHERE SCHOOL_ID = 609737;

CALL UPDATE_LEADERS_SCORE (609737, 101);

SELECT SCHOOL_ID, LEADERS_SCORE, LEADERS_ICON FROM chicago_public_schools WHERE SCHOOL_ID = 609737;
