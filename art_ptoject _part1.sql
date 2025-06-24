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