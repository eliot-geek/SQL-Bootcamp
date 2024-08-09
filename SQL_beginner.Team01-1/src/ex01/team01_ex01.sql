-- INSERT INTO currency VALUES (100, 'EUR', 0.85, '2022-01-01 13:29');
-- INSERT INTO currency VALUES (100, 'EUR', 0.79, '2022-01-08 13:29');

SELECT t1.name,
       t1.lastname,
       currency_name,
       money * rate_to_usd AS currency_in_usd
FROM (
    SELECT COALESCE(u.name, 'not defined') AS name,
           COALESCE(u.lastname, 'not defined') AS lastname,
           c.name AS currency_name,
           money,
           COALESCE(
               (SELECT rate_to_usd 
                FROM currency c 
                WHERE b.currency_id = c.id 
                  AND c.updated < b.updated 
                ORDER BY c.updated DESC LIMIT 1),
               (SELECT rate_to_usd 
                FROM currency c 
                WHERE b.currency_id = c.id 
                  AND c.updated > b.updated 
                ORDER BY c.updated ASC LIMIT 1)
           ) AS rate_to_usd
    FROM balance b
    INNER JOIN (
        SELECT c.id, c.name 
        FROM currency c 
        GROUP BY c.id, c.name
    ) AS c ON c.id = b.currency_id
    LEFT JOIN "user" u ON u.id = b.user_id
) AS t1
ORDER BY 1 DESC, 2, 3;


------------------------------------------------------------------------------------------


SELECT
    COALESCE(u.name, 'not defined') AS name,
    COALESCE(u.lastname, 'not defined') AS lastname,
    c.name AS currency_name,
    b.money * c.rate_to_usd AS currency_in_usd
FROM balance b
LEFT JOIN "user" u ON b.user_id = u.id
JOIN currency c ON b.currency_id = c.id
    AND c.updated = COALESCE(
        (SELECT MAX(currency.updated)
         FROM currency
         WHERE c.id = currency.id
           AND b.updated >= currency.updated),
        (SELECT MIN(currency.updated)
         FROM currency
         WHERE c.id = currency.id
           AND b.updated < currency.updated)
    )
ORDER BY name DESC, lastname, currency_name;


------------------------------------------------------------------------------------------


WITH cur_cte AS (
    SELECT 
        b.user_id AS bui,
        b.money,
        b.updated,
        c.name AS cur_name,
        c.rate_to_usd AS cur_rate,
        c.updated AS cur_updated
    FROM balance b
    JOIN currency c ON b.currency_id = c.id
),
all_join AS (
    SELECT 
        q2.id,
        q2.cur_name,
        q2.money,
        q2.updated,
        COALESCE(q1.diff, q2.diff) AS new_diff
    FROM (
        SELECT 
            cur_cte.bui AS id,
            cur_name,
            money,
            updated,
            MIN(updated - cur_updated) AS diff
        FROM cur_cte
        WHERE updated - cur_updated > INTERVAL '0 days'
        GROUP BY 1, 2, 3, 4
    ) q1
    FULL JOIN (
        SELECT 
            cur_cte.bui AS id,
            cur_name,
            money,
            updated,
            MAX(updated - cur_updated) AS diff
        FROM cur_cte
        WHERE updated - cur_updated < INTERVAL '0 days'
        GROUP BY 1, 2, 3, 4
    ) q2
    ON q1.id = q2.id 
       AND q1.cur_name = q2.cur_name 
       AND q1.money = q2.money 
       AND q1.updated = q2.updated
)
SELECT 
    COALESCE(u.name, 'not defined') AS name,
    COALESCE(u.lastname, 'not defined') AS lastname,
    aj.cur_name,
    aj.money * cu.rate_to_usd AS currency_in_usd
FROM all_join aj
LEFT JOIN "user" u ON aj.id = u.id
LEFT JOIN currency cu 
    ON aj.new_diff = (aj.updated - cu.updated) 
    AND aj.cur_name = cu.name
ORDER BY name DESC, lastname ASC, cur_name ASC;


------------------------------------------------------------------------------------------


-- insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29'); 
-- insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');

WITH t1 AS (
	SELECT b.user_id, b.currency_id, b.updated AS b_updated, MAX(c.updated) AS c_updated FROM balance b
	JOIN currency c ON c.id = b.currency_id
	WHERE c.updated <= b.updated
	GROUP BY b.user_id, b.currency_id, b.updated
),
t2 AS (
	SELECT b.user_id, b.currency_id, b.updated AS b_updated, MIN(c.updated) AS c_updated FROM balance b
	JOIN currency c ON c.id = b.currency_id
	WHERE c.updated > b.updated
	GROUP BY b.user_id, b.currency_id, b.updated
),

t AS (
	SELECT COALESCE(t1.user_id, t2.user_id) AS user_id, 
		COALESCE(t1.currency_id, t2.currency_id) AS currency_id,
		COALESCE(t1.b_updated, t2.b_updated) AS b_updated,
		COALESCE(t1.c_updated, t2.c_updated) AS c_updated 
	FROM t1
	FULL JOIN t2 ON t1.user_id = t2.user_id AND t1.currency_id = t2.currency_id AND t1.b_updated = t2.b_updated
)
SELECT COALESCE(u.name, 'not defined') AS name,
	COALESCE(u.lastname, 'not defined') AS lastname,
	c.name AS currency_name,
	b.money * c.rate_to_usd AS currency_in_usd
FROM t
JOIN balance b ON b.user_id = t.user_id AND b.currency_id = t.currency_id AND t.b_updated = b.updated
LEFT JOIN "user" u ON u.id = t.user_id
JOIN currency c ON c.id = t.currency_id AND c.updated = t.c_updated
ORDER BY name DESC, lastname, currency_name;
