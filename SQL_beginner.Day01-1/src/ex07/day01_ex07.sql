SELECT order_date, 
	name || '(age:'||age||')' AS person_information
FROM person_order
INNER JOIN person ON person.id = person_order.person_id
ORDER BY 1, 2;



SELECT po.order_date,
	CONCAT(p.name, '(age:',p.age, ')') AS person_information
FROM person_order po
INNER JOIN person p ON p.id = po.person_id
ORDER BY order_date, person_information;