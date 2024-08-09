-- Отключение последовательных сканирований
SET enable_seqscan = off; 

EXPLAIN ANALYZE
SELECT 
	m.pizza_name AS pizza_name, 
	pz.name AS pizzeria_name
FROM menu m
INNER JOIN pizzeria pz ON pz.id = m.pizzeria_id;