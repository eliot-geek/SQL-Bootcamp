SELECT p.address AS address, pz.name AS name, COUNT(po.id) AS count_of_orders
FROM person p
INNER JOIN person_order po ON p.id = po.person_id
INNER JOIN menu m ON po.menu_id = m.id
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
GROUP BY p.address, pz.name
ORDER BY p.address ASC, pz.name ASC;
