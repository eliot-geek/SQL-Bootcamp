CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date(
    pperson VARCHAR DEFAULT 'Dmitriy',
    pprice NUMERIC DEFAULT 500,
    pdate DATE DEFAULT '2022-01-08')

RETURNS TABLE (name VARCHAR) AS $$
BEGIN
RETURN QUERY
    SELECT pz.name AS pizzeria_name
    FROM menu
    INNER JOIN pizzeria pz ON pz.id = menu.pizzeria_id
    INNER JOIN person_visits pv ON menu.pizzeria_id = pv.pizzeria_id
    INNER JOIN person p ON p.id = pv.person_id
    WHERE price < pprice
      AND p.name = pperson
      AND visit_date = pdate;
END;
$$ LANGUAGE plpgsql;


SELECT *
FROM fnc_person_visits_and_eats_on_date(pprice := 800);

SELECT *
FROM fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');