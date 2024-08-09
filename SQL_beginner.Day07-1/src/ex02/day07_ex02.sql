(SELECT pz.name, COUNT(*) AS count, 'order' AS action_type
 FROM person_order po
 INNER JOIN menu m ON po.menu_id = m.id
 INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
 GROUP BY pz.name
 ORDER BY count DESC
 LIMIT 3)
UNION
(SELECT pz.name, COUNT(*) AS count, 'visit' AS action_type
 FROM person_visits pv
 INNER JOIN pizzeria pz ON pv.pizzeria_id = pz.id
 GROUP BY pz.name
 ORDER BY count DESC
 LIMIT 3)
ORDER BY action_type ASC, count DESC;
