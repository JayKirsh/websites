/*Select tables within the database*/

SELECT *
FROM customers
ORDER BY customer_id;

SELECT *
FROM customers_log;

/*Create a trigger on the customers table to fire log_customers_change() any time it is altered*/

CREATE TRIGGER customer_updated
    BEFORE UPDATE ON customers
    FOR EACH ROW
    EXECUTE PROCEDURE log_customers_change();

UPDATE customers
SET first_name = 'Jordan', last_name = 'Kirchner'
WHERE first_name = 'Edward';

/*Confirm the triggers are firing when either first_name or last_name are altered*/

SELECT *
FROM customers
ORDER BY customer_id;

SELECT *
FROM customers_log;

/*Confirm the triggers are not firing when columns aside from first_name or last_name are altered*/

UPDATE customers
SET email_address = 'BoxOfChocolates@example.com'
WHERE first_name = 'Jordan';

SELECT *
FROM customers
ORDER BY customer_id;

SELECT *
FROM customers_log;

/*Create a trigger that calls log_customers_change once for every statement on INSERT to the customers table*/

CREATE TRIGGER customer_insert
    AFTER INSERT ON customers
    FOR EACH STATEMENT
    EXECUTE PROCEDURE log_customers_change();

/*Add three names to the customers table in one statement*/

INSERT INTO customers (first_name, last_name, email_address, home_phone, city, state_name, years_old)
VALUES 
('Jeffrey','Cook','Jeffrey.Cook@example.com','202-555-0398','Jersey city','New Jersey',66),
('Jeff','Cock','Jeff.Cock@example.com','202-555-0397','Jerusalem','Isreal',67),
('Juffrey','Coke','Juffrey.Coke@example.com','202-555-0396','Jufftown','Juffstate',65);

SELECT *
FROM customers
ORDER BY customer_id;

SELECT *
FROM customers_log;

/*Create a trigger customer_min_age that fires override_with_min_age() when the age is */

CREATE TRIGGER customer_min_age
    BEFORE UPDATE ON customers
    FOR EACH ROW
    WHEN (NEW.years_old < 13)
    EXECUTE PROCEDURE override_with_min_age();

/*Insert two customers, one with an age under 13 and one with an age over 13*/

UPDATE customers
SET years_old = 1
WHERE first_name = 'Jordan';

UPDATE customers
SET years_old = 31
WHERE first_name = 'Frances';

SELECT *
FROM customers
ORDER BY customer_id;

SELECT *
FROM customers_log;

/*Change first_name and years_old within a single update*/

UPDATE customers
SET years_old = 9,
    first_name = 'Denis'
WHERE last_name = 'Hall';

SELECT *
FROM customers
ORDER BY customer_id;

SELECT *
FROM customers_log;

/*Drop the customer_min_age trigger*/

DROP TRIGGER IF EXISTS customer_min_age on customers;

/*Select the triggers within information_schema*/

SELECT * 
FROM information_schema.triggers;