SELECT p.name AS person_name,
	   m.pizza_name AS pizza_name,
	   pz.name AS pizzeria_name
FROM person_order po
INNER JOIN person p ON p.id = po.person_id
INNER JOIN menu m ON m.id = po.menu_id
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
ORDER BY 1, 2, 3;



SELECT 
    person.name AS person_name,
    menu.pizza_name,
    pizzeria.name AS pizzeria_name
FROM person
INNER JOIN person_order ON person.id = person_order.person_id
INNER JOIN menu ON person_order.menu_id = menu.id
INNER JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
ORDER BY person_name ASC, pizza_name ASC, pizzeria_name ASC;