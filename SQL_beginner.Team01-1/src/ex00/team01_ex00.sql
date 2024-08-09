SELECT
    COALESCE(u.name, 'not defined') AS name,
    COALESCE(u.lastname, 'not defined') AS lastname,
    t1.type,
    t1.volume,
    COALESCE(c.name, 'not defined') AS currency_name,
    COALESCE(
        (SELECT rate_to_usd 
        FROM currency c1 
        WHERE c1.id = c.id AND c1.updated = c.last_updated), 1) AS last_rate_to_usd,
    t1.volume::numeric * COALESCE(
        (SELECT rate_to_usd 
        FROM currency c1 
        WHERE c1.id = c.id AND c1.updated = c.last_updated), 1) AS total_volume_in_usd

FROM (
    SELECT user_id, 
           type, 
           currency_id, 
           SUM(money) AS volume
    FROM balance b
    GROUP BY user_id, type, currency_id
) AS t1

FULL JOIN "user" u ON u.id = t1.user_id
FULL JOIN (
    SELECT id, 
           name, 
           MAX(updated) AS last_updated
    FROM currency c
    GROUP BY id, name
) AS c ON c.id = t1.currency_id

ORDER BY name DESC, lastname ASC, type ASC;


------------------------------------------------------------------------------------------


WITH AggregatedBalances AS (
    SELECT user_id, type, currency_id, SUM(money) AS volume
    FROM balance
    GROUP BY user_id, type, currency_id
),
LatestCurrencyRate AS (
    SELECT c1.id, c1.name AS currency_name, c1.rate_to_usd
    FROM currency c1
    JOIN (
        SELECT id, MAX(updated) AS max_updated
        FROM currency
        GROUP BY id
    ) c2 ON c1.id = c2.id AND c1.updated = c2.max_updated
)
SELECT 
    COALESCE(u.name, 'not defined') AS name,
    COALESCE(u.lastname, 'not defined') AS lastname,
    b.type,
    b.volume,
    COALESCE(lcr.currency_name, 'not defined') AS currency_name,
    COALESCE(lcr.rate_to_usd, 1) AS last_rate_to_usd,
    b.volume * COALESCE(lcr.rate_to_usd, 1) AS total_volume_in_usd
FROM AggregatedBalances b
LEFT JOIN "user" u ON b.user_id = u.id
LEFT JOIN LatestCurrencyRate lcr ON b.currency_id = lcr.id
ORDER BY name DESC, lastname, type;


------------------------------------------------------------------------------------------


WITH u_volume AS (
    SELECT 
        COALESCE(u.name, 'not defined') AS name,
        COALESCE(u.lastname, 'not defined') AS lastname,
        b.type AS type,
        SUM(b.money) AS volume,
        b.currency_id
    FROM "user" u
    FULL JOIN balance b ON u.id = b.user_id
    GROUP BY b.type, COALESCE(u.lastname, 'not defined'), COALESCE(u.name, 'not defined'), b.currency_id
),
b_cur_name AS (
    SELECT 
        uv.name,
        uv.lastname,
        uv.type,
        uv.volume,
        COALESCE(c.name, 'not defined') AS currency_name,
        uv.currency_id
    FROM u_volume uv
    LEFT JOIN currency c ON c.id = uv.currency_id
    GROUP BY uv.name, uv.lastname, uv.type, uv.volume, COALESCE(c.name, 'not defined'), uv.currency_id
),
rtu AS (
    SELECT 
        c.id,
        c.name,
        c.rate_to_usd,
        c.updated AS last_updated
    FROM currency c
    JOIN (
        SELECT 
            id,
            MAX(updated) AS lastdate
        FROM currency
        GROUP BY id
    ) q1 ON c.id = q1.id AND c.updated = q1.lastdate
)
SELECT 
    b_cur_name.name AS name,
    b_cur_name.lastname AS lastname,
    b_cur_name.type AS type,
    b_cur_name.volume AS volume,
    b_cur_name.currency_name AS currency_name,
    COALESCE(rtu.rate_to_usd, 1) AS last_rate_to_usd,
    b_cur_name.volume * COALESCE(rtu.rate_to_usd, 1) AS total_volume_in_usd
FROM b_cur_name
LEFT JOIN rtu ON rtu.id = b_cur_name.currency_id
ORDER BY name DESC, lastname ASC, type ASC;
