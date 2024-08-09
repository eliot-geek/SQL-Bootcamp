CREATE SEQUENCE seq_person_discounts
    START WITH 1
    INCREMENT BY 1;
ALTER TABLE person_discounts
ALTER COLUMN id SET DEFAULT nextval('seq_person_discounts');
SELECT setval('seq_person_discounts', (SELECT COUNT(*) + 1 FROM person_discounts));


--
SELECT COUNT(*) = 1 AS Check1,
MAX("start_value") = 1 AS Check2,
MAX("last_value") > 5 AS Check3
FROM pg_sequences
WHERE sequencename = 'seq_person_discounts'