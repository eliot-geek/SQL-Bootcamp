-- Session #1:
BEGIN;
UPDATE pizzeria 
SET rating = 5 
WHERE name = 'Pizza Hut';
COMMIT;
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';


-- Session #2: Before the commit
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';