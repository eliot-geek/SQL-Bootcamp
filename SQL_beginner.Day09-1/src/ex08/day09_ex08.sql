CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop INTEGER DEFAULT 10)
RETURNS TABLE (fib_number BIGINT) AS $$
WITH RECURSIVE fib(fib_number, fib_number2) AS (
    SELECT 0 AS fib_number, 1 AS fib_number2
    UNION ALL
    SELECT fib_number2, fib_number + fib_number2
    FROM fib
    WHERE fib_number2 < pstop
)
SELECT fib_number
FROM fib;
$$ LANGUAGE sql;


SELECT * FROM fnc_fibonacci(100);