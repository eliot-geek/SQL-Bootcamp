DROP VIEW v_persons_female;
DROP VIEW v_persons_male;
DROP VIEW v_generated_dates;
DROP VIEW v_symmetric_union;
DROP VIEW v_price_with_discount;

DROP MATERIALIZED VIEW mv_dmitriy_visits_and_eats;


/*
-- The check script
SELECT COUNT(*) = 0 AS check
FROM pg_class
WHERE relname IN ('v_persons_female','v_persons_male','v_generated_dates',
'v_symmetric_union','v_price_with_discount','mv_dmitriy_visits_and_eats')
*/