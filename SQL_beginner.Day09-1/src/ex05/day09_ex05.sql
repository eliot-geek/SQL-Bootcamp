DROP FUNCTION IF EXISTS fnc_persons_female();
DROP FUNCTION IF EXISTS fnc_persons_male();

CREATE FUNCTION fnc_persons(pgender VARCHAR DEFAULT 'female')
RETURNS TABLE (id person.id%TYPE,
				name person.name%TYPE,
				age person.age%TYPE, 
				gender person.gender%TYPE,
				address person.address%TYPE) AS $$
	
    SELECT id, name, age, gender, address
    FROM person
    WHERE gender = pgender;
$$ LANGUAGE sql;

SELECT * FROM fnc_persons(pgender := 'male');

SELECT * FROM fnc_persons();
