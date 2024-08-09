SELECT order_date AS action_date, person_id
FROM person_order
INTERSECT ALL
SELECT visit_date, person_id
FROM person_visits
ORDER BY action_date ASC, person_id DESC;



SELECT order_date AS action_date, person_id
FROM person_order
INTERSECT ALL
SELECT visit_date, person_id
FROM person_visits
ORDER BY 1 ASC, 2 DESC;



SELECT order_date AS action_date, person_id
FROM person_order
WHERE (order_date, person_id) IN (
    SELECT visit_date, person_id
    FROM person_visits
)
UNION
SELECT visit_date AS action_date, person_id
FROM person_visits
WHERE (visit_date, person_id) IN (
    SELECT order_date, person_id
    FROM person_order
)
ORDER BY action_date ASC, person_id DESC;