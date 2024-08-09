CREATE MATERIALIZED VIEW mv_dmitriy_visits_and_eats AS
SELECT pz.name AS pizzeria_name
FROM person_visits pv
INNER JOIN pizzeria pz ON pv.pizzeria_id = pz.id
INNER JOIN person p ON pv.person_id = p.id
INNER JOIN menu m ON pz.id = m.pizzeria_id
WHERE p.name = 'Dmitriy'
  AND pv.visit_date = '2022-01-08'
  AND m.price < 800
GROUP BY pz.name;


/*
-- The check script
SELECT * FROM mv_dmitriy_visits_and_eats
*/