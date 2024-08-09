CREATE VIEW v_generated_dates AS
SELECT g::date AS generated_date
FROM generate_series('2022-01-01', '2022-01-31', INTERVAL '1 day') AS g
ORDER BY generated_date;


/*
-- The check script
SELECT COUNT(*) = 31 AS check,
MIN(generated_date) AS check1,
MAX(generated_date) AS check2
FROM v_generated_dates;
*/