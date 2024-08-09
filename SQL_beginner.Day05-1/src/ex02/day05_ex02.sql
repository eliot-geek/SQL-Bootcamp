CREATE INDEX idx_person_name ON person(UPPER(name));

SET enable_seqscan = off;

EXPLAIN ANALYSE
SELECT * 
FROM person
WHERE UPPER(name) = 'Peter';