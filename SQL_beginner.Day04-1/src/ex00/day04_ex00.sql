CREATE VIEW v_persons_female AS
SELECT *
FROM person
WHERE gender = 'female';

/*
-- The check script
SELECT * FROM v_persons_female ORDER BY 1;
*/


CREATE VIEW v_persons_male AS
SELECT *
FROM person
WHERE gender = 'male';


/*
-- The check script
SELECT * FROM v_persons_male ORDER BY 1;
*/