/*Alter the code column so that each value inserted into this field is unique and not empty*/

ALTER TABLE parts
ALTER COLUMN code SET NOT NULL;

ALTER TABLE parts
ADD UNIQUE(code);

/*Alter the table so that all rows have a value for description*/

UPDATE parts
SET description = 'None Available'
WHERE description = ' ';

/*Add a constraint on parts that ensures that all values in description are filled and non-empty*/

ALTER TABLE parts
ALTER COLUMN description SET NOT NULL;

/*Test the constraint by trying to insert a row into parts that violates the constraint*/

/*
INSERT INTO parts (id, code, manufacturer_id)
VALUES (54, 'V1-009', 9);
*/

SELECT *
FROM parts
ORDER BY id
LIMIT 10;

/*For the reorder_options schema, implement a check that ensures that price_usd and quantity are both NOT NULL*/

ALTER TABLE reorder_options
ALTER COLUMN price_usd SET NOT NULL;

ALTER TABLE reorder_options
ALTER COLUMN quantity SET NOT NULL;

/*Implement a check that ensures that price_usd and quantity are both positive*/

ALTER TABLE reorder_options
ADD CHECK (price_usd > 0 AND quantity > 0);

/*Add a constraint that limits price per unit to within 0.02 and 25.00*/

ALTER TABLE reorder_options
ADD CHECK (price_usd / quantity >= 0.02 AND price_usd / quantity <= 25.00);

/*Add a constraint to ensure that we don't have pricing information on parts that aren't already tracked in our DB schema*/

ALTER TABLE parts
ADD PRIMARY KEY (id);

ALTER TABLE reorder_options
ADD FOREIGN KEY (part_id)
REFERENCES parts(id);

SELECT *
FROM reorder_options
LIMIT 10;

/*Add a constraint to the locations trable that ensures each value in qty is greater than 0*/

ALTER TABLE locations
ADD CHECK (qty > 0);

/*Ensure that locations records only have one row for each combination of location and part*/

ALTER TABLE locations
ADD UNIQUE (part_id, location);

/*Ensure that for a part to be stored in locations it must already be registered in parts*/

/*

ALTER TABLE locations
ADD FOREIGN KEY (part_id)
REFERENCES parts(id);

*/

SELECT *
FROM locations
LIMIT 10;

/*Ensure that all parts in parts have a valid manufacturer*/

ALTER TABLE parts
ADD FOREIGN KEY (manufacturer_id)
REFERENCES manufacturers(id);

/*Create a new manufacturer in manufacturers with an id=11*/

INSERT INTO manufacturers (id, name)
VALUES (11, 'Pip-NNC Industrial');

SELECT *
FROM manufacturers;

/*Update the old manufacturers parts in parts to reference the new company*/

UPDATE parts
SET manufacturer_id = 11
WHERE manufacturer_id IN (1, 2);

SELECT *
FROM parts
ORDER BY id
LIMIT 20;
