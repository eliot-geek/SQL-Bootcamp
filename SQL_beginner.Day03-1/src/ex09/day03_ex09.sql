INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date) 
VALUES (
  (SELECT MAX(id) + 1 FROM person_visits),
  (SELECT id FROM person WHERE name = 'Denis'),
  (SELECT id FROM pizzeria WHERE name = 'Dominos'),
  '2022-02-24'
);

INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date) 
VALUES (
  (SELECT MAX(id) + 1 FROM person_visits),
  (SELECT id FROM person WHERE name = 'Irina'),
  (SELECT id FROM pizzeria WHERE name = 'Dominos'),
  '2022-02-24'
);



/*
-- The check script
SELECT COUNT(*) = 2 AS check
FROM person_visits
WHERE visit_date = '2022-02-24' AND person_id IN (6,4) AND pizzeria_id = 2;
*/