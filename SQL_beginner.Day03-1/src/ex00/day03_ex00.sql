SELECT m.pizza_name, m.price, pz.name AS pizzeria_name, pv.visit_date
FROM menu m
INNER JOIN pizzeria pz ON pz.id = m.pizzeria_id
INNER JOIN person_visits pv ON pz.id = pv.pizzeria_id
INNER JOIN person p ON p.id = pv.person_id
WHERE m.price BETWEEN 800 AND 1000 
  AND p.name = 'Kate'
ORDER BY m.pizza_name, m.price, pz.name;