/*Creating a database to house retaurant information*/

CREATE TABLE restaurant (
  id integer PRIMARY KEY,
  name varchar(20),
  description varchar(100),
  rating decimal,
  telephone varchar(10),
  hours varchar(100)
);

CREATE TABLE address (
  id integer PRIMARY KEY,
  street_number varchar(10),
  street_name varchar(30),
  city varchar(20),
  state varchar(15),
  google_map_link varchar(50),
  id_restaurant integer REFERENCES restaurant(id) UNIQUE
);

CREATE TABLE category (
  id char(2) PRIMARY KEY,
  name varchar(20),
  description varchar(200)
);

CREATE TABLE dish (
  id integer PRIMARY KEY,
  name varchar(50),
  description varchar(200),
  hot_and_spicy BOOL
);

CREATE TABLE review (
  id integer PRIMARY KEY,
  rating decimal,
  description varchar(100),
  date date,
  id_restaurant integer REFERENCES restaurant(id)
);

CREATE TABLE categories_dishes (
  id_category varchar(2) REFERENCES category(id),
  id_dish integer REFERENCES dish(id),
  price money,
  PRIMARY KEY(id_category, id_dish)
);

/*Viewing keys and constraints*/

SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'restaurant';

SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'address';

SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'category';

SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'dish';

SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'review';

/* 
 *--------------------------------------------
 Insert values for restaurant
 *--------------------------------------------
 */
INSERT INTO restaurant VALUES (
  1,
  'Bytes of China',
  'Delectable Chinese Cuisine',
  3.9,
  '6175551212',
  'Mon - Fri 9:00 am to 9:00 pm, Weekends 10:00 am to 11:00 pm'
);

/* 
 *--------------------------------------------
 Insert values for address
 *--------------------------------------------
 */
INSERT INTO address VALUES (
  1,
  '2020',
  'Busy Street',
  'Chinatown',
  'MA',
  'http://bit.ly/BytesOfChina',
  1
);

/* 
 *--------------------------------------------
 Insert values for review
 *--------------------------------------------
 */
INSERT INTO review VALUES (
  1,
  5.0,
  'Would love to host another birthday party at Bytes of China!',
  '05-22-2020',
  1
);

INSERT INTO review VALUES (
  2,
  4.5,
  'Other than a small mix-up, I would give it a 5.0!',
  '04-01-2020',
  1
);

INSERT INTO review VALUES (
  3,
  3.9,
  'A reasonable place to eat for lunch, if you are in a rush!',
  '03-15-2020',
  1
);

/* 
 *--------------------------------------------
 Insert values for category
 *--------------------------------------------
 */
INSERT INTO category VALUES (
  'C',
  'Chicken',
  null
);

INSERT INTO category VALUES (
  'LS',
  'Luncheon Specials',
  'Served with Hot and Sour Soup or Egg Drop Soup and Fried or Steamed Rice  between 11:00 am and 3:00 pm from Monday to Friday.'
);

INSERT INTO category VALUES (
  'HS',
  'House Specials',
  null
);

/* 
 *--------------------------------------------
 Insert values for dish
 *--------------------------------------------
 */
INSERT INTO dish VALUES (
  1,
  'Chicken with Broccoli',
  'Diced chicken stir-fried with succulent broccoli florets',
  false
);

INSERT INTO dish VALUES (
  2,
  'Sweet and Sour Chicken',
  'Marinated chicken with tangy sweet and sour sauce together with pineapples and green peppers',
  false
);

INSERT INTO dish VALUES (
  3,
  'Chicken Wings',
  'Finger-licking mouth-watering entree to spice up any lunch or dinner',
  true
);

INSERT INTO dish VALUES (
  4,
  'Beef with Garlic Sauce',
  'Sliced beef steak marinated in garlic sauce for that tangy flavor',
  true
);

INSERT INTO dish VALUES (
  5,
  'Fresh Mushroom with Snow Peapods and Baby Corns',
  'Colorful entree perfect for vegetarians and mushroom lovers',
  false
);

INSERT INTO dish VALUES (
  6,
  'Sesame Chicken',
  'Crispy chunks of chicken flavored with savory sesame sauce',
  false
);

INSERT INTO dish VALUES (
  7,
  'Special Minced Chicken',
  'Marinated chicken breast sauteed with colorful vegetables topped with pine nuts and shredded lettuce.',
  false
);

INSERT INTO dish VALUES (
  8,
  'Hunan Special Half & Half',
  'Shredded beef in Peking sauce and shredded chicken in garlic sauce',
  true
);

/*
 *--------------------------------------------
 Insert valus for cross-reference table, categories_dishes
 *--------------------------------------------
 */
INSERT INTO categories_dishes VALUES (
  'C',
  1,
  6.95
);

INSERT INTO categories_dishes VALUES (
  'C',
  3,
  6.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  1,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  4,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  5,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  6,
  15.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  7,
  16.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  8,
  17.95
);

/*Select the restaurant name, street number, street name, and telephone number*/

SELECT restaurant.name, address.street_number, address.street_name, restaurant.telephone
FROM restaurant
JOIN address
ON restaurant.id = address.id;

/*Select the best rating the first restaurant ever received*/

SELECT max(review.rating) AS best_rating, review.description, date
FROM restaurant
JOIN review
ON restaurant.id = review.id
GROUP BY review.description, date;

/*Select all dish names with their respective prices and category sorted by dish name*/

SELECT dish.name, price, category
FROM dish
JOIN categories_dishes
ON dish.id = categories_dishes.id_dish
JOIN category
ON categories_dishes.id_category = category.id
ORDER BY dish.name;

/*Select the previous results but order by category name*/

SELECT category, dish.name, price
FROM dish
JOIN categories_dishes
ON dish.id = categories_dishes.id_dish
JOIN category
ON categories_dishes.id_category = category.id
ORDER BY category;

/*Select all spicy dishes with their respective prices and category*/

SELECT dish.name as spicy_dish_name, category, price
FROM dish
JOIN categories_dishes
ON dish.id = categories_dishes.id_dish
JOIN category
ON categories_dishes.id_category = category.id
WHERE hot_and_spicy = TRUE;

/*Select each id_dish along with the amount of times it appears in the menu*/

SELECT id_dish, COUNT(id_category) AS dish_count
FROM categories_dishes
GROUP BY 1
ORDER BY 1;

/*Select the dish(es) that appear more than once in the menu*/

SELECT id_dish, COUNT(id_category) AS dish_count
FROM categories_dishes
GROUP BY 1
HAVING COUNT(id_category) > 1
ORDER BY 1;


/*Select multiple tables to replace id_dish from the last query with its respective dish_name*/

SELECT name AS dish_name, COUNT(id_category) AS dish_count
FROM categories_dishes
JOIN dish
ON categories_dishes.id_dish = dish.id
GROUP BY 1
HAVING COUNT(id_category) > 1
ORDER BY 1;

/*An alternate solution to find the best rating & review of a restaurant*/

SELECT review.rating AS best_rating, review.description, date
FROM restaurant
JOIN review
ON restaurant.id = review.id
WHERE review.rating = (
  SELECT MAX(review.rating)
  FROM review
);