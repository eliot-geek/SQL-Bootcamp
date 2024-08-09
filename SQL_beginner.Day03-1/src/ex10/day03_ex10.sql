INSERT INTO person_order (id, person_id, menu_id, order_date) 
VALUES (
  (SELECT MAX(id) + 1 FROM person_order),
  (SELECT id FROM person WHERE name = 'Denis'),
  (SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'),
  '2022-02-24'
);

INSERT INTO person_order (id, person_id, menu_id, order_date) 
VALUES (
  (SELECT MAX(id) + 1 FROM person_order),
  (SELECT id FROM person WHERE name = 'Irina'),
  (SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'),
  '2022-02-24'
);


/*
-- The check script
SELECT COUNT(*) = 2 AS check
FROM person_order
WHERE order_date = '2022-02-24' AND person_id IN (6,4) AND menu_id = (SELECT id FROM menu WHERE pizza_name = 'sicilian pizza');
*/