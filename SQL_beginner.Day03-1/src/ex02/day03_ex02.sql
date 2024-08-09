SELECT m.pizza_name, m.price, pz.name AS pizzeria_name
FROM (
    SELECT id AS menu_id
    FROM menu m
    EXCEPT
    SELECT menu_id
    FROM person_order
) AS table1
INNER JOIN menu m ON table1.menu_id = m.id
INNER JOIN pizzeria pz ON pz.id = m.pizzeria_id
ORDER BY 1, 2;



SELECT m.pizza_name, m.price, p.name AS pizzeria_name
FROM menu m
INNER JOIN pizzeria p ON m.pizzeria_id = p.id
LEFT JOIN person_order po ON m.id = po.menu_id
WHERE po.menu_id IS NULL
ORDER BY m.pizza_name, m.price;