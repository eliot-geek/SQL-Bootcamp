CREATE VIEW v_price_with_discount AS
SELECT 
    p.name AS name,
    m.pizza_name AS pizza_name,
    m.price AS price,
    CAST(m.price - m.price * 0.1 AS INTEGER) AS discount_price
FROM person_order po
INNER JOIN person p ON po.person_id = p.id
INNER JOIN menu m ON po.menu_id = m.id
ORDER BY p.name, m.pizza_name;



/*
CREATE VIEW v_price_with_discount AS
SELECT 
    p.name AS name,
    m.pizza_name AS pizza_name,
    m.price AS price,
    ROUND(m.price - m.price * 0.1) AS discount_price
FROM person_order po
INNER JOIN person p ON po.person_id = p.id
INNER JOIN menu m ON po.menu_id = m.id
ORDER BY p.name, m.pizza_name;
*/


/*
-- The check script
SELECT * FROM v_price_with_discount
*/