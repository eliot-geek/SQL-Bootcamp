SELECT t1.name, COALESCE(t1.count, 0) + COALESCE(t2.count, 0) AS total_count
FROM
(SELECT pz.name, COUNT(*) AS count
FROM person_visits pv
INNER JOIN pizzeria pz ON pv.pizzeria_id = pz.id
GROUP BY pz.name) AS t1 FULL JOIN
(SELECT pz.name, COUNT(*) AS count
FROM person_order po
INNER JOIN menu m ON po.menu_id = m.id
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
GROUP BY pz.name) AS t2 ON t1.name = t2.name
ORDER BY total_count DESC, name ASC;
