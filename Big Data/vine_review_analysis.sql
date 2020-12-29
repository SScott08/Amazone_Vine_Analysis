CREATE TABLE review_id_table (
  review_id TEXT PRIMARY KEY NOT NULL,
  customer_id INTEGER,
  product_id TEXT,
  product_parent INTEGER,
  review_date DATE -- this should be in the formate yyyy-mm-dd
);

-- Customer table for first data set
CREATE TABLE customers_table (
  customer_id INT PRIMARY KEY NOT NULL UNIQUE,
  customer_count INT
);



CREATE TABLE products_table (
  product_id TEXT PRIMARY KEY NOT NULL UNIQUE,
  product_title TEXT
);


-- vine table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

SELECT * FROM review_id_table;

SELECT * FROM products_table;
SELECT * FROM customers_table;
SELECT * FROM vine_table;

SELECT * INTO vine_table_over_twenty
FROM vine_table
WHERE total_votes >= 20;


SELECT * INTO vine_table_over_fifty
FROM vine_table_over_twenty
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5;

SELECT * INTO paid_reviews
FROM vine_table_over_fifty
WHERE vine = 'Y';

SELECT * INTO unpaid_reviews
FROM vine_table_over_fifty
WHERE vine = 'N';

CREATE table total_reviews (total int);

CREATE table five_star_reviews (total_five_star int);

INSERT INTO five_star_reviews (total_five_star)
SELECT COUNT (star_rating)
FROM paid_reviews
WHERE star_rating = 5;

INSERT INTO total_reviews (total)
SELECT COUNT (total_votes)
FROM paid_reviews;

SELECT total, total_five_star
INTO calc_reviews
FROM total_reviews
JOIN five_star_reviews ON 1=1;

SELECT * FROM calc_reviews;

SELECT total, total_five_star
,CAST(total_five_star AS FLOAT)/CAST(total AS FLOAT)*100 AS per_five
INTO paid_analysis FROM calc_reviews;

SELECT * FROM paid_analysis;

--Unpaid
CREATE table total_reviews_unpaid (total int);

CREATE table five_star_reviews_unpaid (total_five_star int);

INSERT INTO five_star_reviews_unpaid (total_five_star)
SELECT COUNT (star_rating)
FROM unpaid_reviews
WHERE star_rating = 5;

INSERT INTO total_reviews_unpaid (total)
SELECT COUNT (total_votes)
FROM unpaid_reviews;

SELECT total, total_five_star
INTO calc_reviews_unpaid
FROM total_reviews_unpaid
JOIN five_star_reviews_unpaid ON 1=1;

SELECT * FROM calc_reviews_unpaid;

SELECT total, total_five_star
,CAST(total_five_star AS FLOAT)/CAST(total AS FLOAT)*100 AS per_five
INTO unpaid_analysis FROM calc_reviews_unpaid;

SELECT * FROM unpaid_analysis;

SELECT * FROM paid_analysis;