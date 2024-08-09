SELECT
    p.address AS address,
    ROUND((MAX(p.age) - MIN(p.age) / MAX(p.age::NUMERIC)), 2) AS formula,
    ROUND(AVG(p.age), 2) AS average,
    ROUND((MAX(p.age) - MIN(p.age) / MAX(p.age::NUMERIC)), 2) > ROUND(AVG(p.age), 2) AS comparison
FROM person p
GROUP BY p.address
ORDER BY p.address;
