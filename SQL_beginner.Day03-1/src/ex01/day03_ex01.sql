SELECT id AS menu_id
FROM menu
EXCEPT
SELECT menu_id
FROM person_order
ORDER BY 1;



SELECT id AS menu_id
FROM menu 
WHERE id NOT IN (
	SELECT menu_id
	FROM person_order
)
ORDER BY id;