SELECT action_date, person.name AS person_name
FROM 
	(SELECT order_date AS action_date, person_id
	FROM person_order
	INTERSECT ALL
	SELECT visit_date, person_id
	FROM person_visits
) AS t1
INNER JOIN person on t1.person_id = person.id
ORDER BY 1 ASC, 2 DESC;



SELECT table1.action_date,
       p.name AS person_name
FROM (
    SELECT order_date AS action_date, person_id
    FROM person_order
    INTERSECT ALL
    SELECT visit_date, person_id
    FROM person_visits
) AS table1
INNER JOIN person p ON table1.person_id = p.id
ORDER BY table1.action_date ASC, p.name DESC;