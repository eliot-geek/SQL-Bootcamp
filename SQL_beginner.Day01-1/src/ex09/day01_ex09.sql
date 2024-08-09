SELECT name
FROM pizzeria
WHERE id NOT IN (
	SELECT pizzeria_id
	FROM person_visits
);



SELECT name
FROM pizzeria
WHERE NOT EXISTS (
	SELECT 1
	FROM person_visits pv
	WHERE pv.pizzeria_id = pizzeria.id
);



-- The SELECT 1 is a common practice to use within an EXISTS subquery, as it checks for the existence of rows without needing to return any specific column values.