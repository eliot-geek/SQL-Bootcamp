(SELECT pz.name AS pizzeria_name
 FROM person p
 INNER JOIN person_order po ON p.id = po.person_id
 INNER JOIN menu m ON m.id = po.menu_id
 INNER JOIN pizzeria pz ON pz.id = m.pizzeria_id
 WHERE p.gender = 'female'
 EXCEPT
 SELECT pz.name
 FROM person p
 INNER JOIN person_order po ON p.id = po.person_id
 INNER JOIN menu m ON m.id = po.menu_id
 INNER JOIN pizzeria pz ON pz.id = m.pizzeria_id
 WHERE p.gender = 'male')
UNION
(SELECT pz.name
 FROM person p
 INNER JOIN person_order po ON p.id = po.person_id
 INNER JOIN menu m ON m.id = po.menu_id
 INNER JOIN pizzeria pz ON pz.id = m.pizzeria_id
 WHERE p.gender = 'male'
 EXCEPT
 SELECT pz.name
 FROM person p
 INNER JOIN person_order po ON p.id = po.person_id
 INNER JOIN menu m ON m.id = po.menu_id
 INNER JOIN pizzeria pz ON pz.id = m.pizzeria_id
 WHERE p.gender = 'female')
ORDER BY pizzeria_name;