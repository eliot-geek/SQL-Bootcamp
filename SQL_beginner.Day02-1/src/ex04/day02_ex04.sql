SELECT menu.pizza_name, p.name AS pizzeria_name, menu.price
FROM menu 
INNER JOIN pizzeria p ON menu.pizzeria_id = p.id
WHERE menu.pizza_name IN ('mushroom pizza', 'pepperoni pizza')
ORDER BY menu.pizza_name, p.name;


SELECT pizza_name, name AS pizzeria_name, price
FROM menu 
INNER JOIN pizzeria p ON menu.pizzeria_id = p.id
WHERE pizza_name IN ('mushroom pizza','pepperoni pizza')
ORDER BY 1,2;