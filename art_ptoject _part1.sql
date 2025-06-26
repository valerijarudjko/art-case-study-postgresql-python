ALTER DATABASE art SET search_path TO public;

SELECT * FROM museum
LIMIT 100

-- SQL Case Study

-- Problem Statements: Part I

-- 1. All the paintings which are not displayed on any museums?
--(If a painting is not displayed in a museum, then its museum_id will be NULL in the work table.)

SELECT name
FROM work
WHERE museum_id IS NULL;

-- Total of 10223 paintings


-- 2. Are there museums without any paintings?
-- (We need to join museum and work tables)

SELECT m.name
FROM museum m
LEFT JOIN work w ON m.museum_id = w.museum_id
WHERE w.work_id IS NULL;

--(All museums have at least one painting)


-- 3. How many paintings have an asking price of more than their regular price?

SELECT COUNT(DISTINCT work_id)
FROM product_size
WHERE sale_price > regular_price;

-- (0 paintings)


-- 4. Identify the paintings whose asking price is less than 50% of their regular price?

SELECT DISTINCT w.work_id, w.name
FROM product_size p
JOIN work w ON p.work_id = w.work_id
WHERE p.sale_price < 0.5 * p.regular_price;

--(total of 34 paintings)


--5. Which canva size costs the most?
SELECT * FROM canvas_size

SELECT cs.label, MAX(ps.sale_price) AS max_price
FROM product_size ps
JOIN canvas_size cs ON ps.size_id = cs.size_id::text
GROUP BY cs.label
ORDER BY max_price DESC
LIMIT 1;


-- 6. Which canvas is largest by physical size (width)?

SELECT width, height, label
FROM canvas_size
ORDER BY width DESC


-- 7. Identify the museums with invalid city information in the given dataset.

SELECT *
FROM museum
WHERE city IS NULL
   OR TRIM(city) = ''
   OR city ~ '^[0-9]+$';

-- or 

SELECT *
FROM museum
WHERE city IS NULL
    OR TRIM(city) = ''
    OR city SIMILAR TO '[0-9]+';

--(total of 5 cities)



