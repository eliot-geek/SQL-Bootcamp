SELECT 
	(SELECT name FROM person p WHERE p.id = pv.person_id) AS person_name, 
	(SELECT name FROM pizzeria piz WHERE piz.id = pv.pizzeria_id) AS pizzeria_name
FROM 
	(SELECT * FROM person_visits WHERE visit_date BETWEEN '2022-01-07' AND '2022-01-09') AS pv
ORDER BY 
	person_name ASC, 
	pizzeria_name DESC;



SELECT 
    (SELECT name FROM person WHERE person.id = pv.person_id) AS person_name,
    (SELECT name FROM pizzeria WHERE pizzeria.id = pv.pizzeria_id) AS pizzeria_name
FROM 
    (SELECT * FROM person_visits WHERE visit_date BETWEEN '2022-01-07' AND '2022-01-09') AS pv
ORDER BY 
    1 ASC, 
    2 DESC;
