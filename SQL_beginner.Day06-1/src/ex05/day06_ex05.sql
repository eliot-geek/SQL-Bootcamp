COMMENT ON TABLE person_discounts IS 'Table for storing information about personal discounts provided to customers at various pizzerias.';

COMMENT ON COLUMN person_discounts.id IS 'Unique identifier for the record (primary key).';
COMMENT ON COLUMN person_discounts.person_id IS 'Identifier of the customer receiving the discount (foreign key referencing the person table).';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'Identifier of the pizzeria where the discount is applicable (foreign key referencing the pizzeria table).';
COMMENT ON COLUMN person_discounts.discount IS 'Discount amount in percent provided to the customer. The value must be between 0 and 100.';


--
SELECT COUNT(*) = 5 AS Check
FROM pg_description
WHERE objoid = 'person_discounts'::regclass