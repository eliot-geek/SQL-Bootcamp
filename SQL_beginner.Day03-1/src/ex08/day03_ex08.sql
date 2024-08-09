INSERT INTO menu (id, pizza_name, price, pizzeria_id)
VALUES ((
	SELECT MAX(id) + 1 FROM menu),
	'sicilian pizza',
	900,
	(SELECT id FROM pizzeria WHERE name = 'Dominos')
);


/*
-- The check script
SELECT COUNT(*) = 1 AS check
FROM menu
WHERE id = 20 AND pizzeria_id = 2 AND pizza_name = 'sicilian pizza' AND price = 900;
*/