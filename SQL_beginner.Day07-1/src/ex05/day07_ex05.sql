SELECT DISTINCT p.name
FROM person p
INNER JOIN person_order po ON p.id = po.person_id
ORDER BY p.name;
