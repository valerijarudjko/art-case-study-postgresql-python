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


-- 8. Museum_Hours table has 1 invalid city information. Identify and remove it. 

SELECT mh.*
FROM museum_hours mh
JOIN museum m ON mh.museum_id = m.museum_id
WHERE m.city IS NULL
   OR TRIM(m.city) = ''
   OR city SIMILAR TO '[0-9]+';

DELETE FROM museum_hours
WHERE museum_id IN (
    SELECT mh.museum_id
    FROM museum_hours mh
    JOIN museum m ON mh.museum_id = m.museum_id
    WHERE m.city IS NULL
       OR TRIM(m.city) = ''
       OR m.city SIMILAR TO '[0-9]+'
);


-- 9. Fetch the top 10 most famous painting subjects

SELECT subject, count (*) as total_sub
FROM subject
GROUP BY subject 
ORDER BY total_sub DESC
LIMIT 10;


-- 10. Identify the museums which are open on both Sunday and Monday. Display museum name & city.

SELECT m.name, m.city
FROM museum m
JOIN museum_hours mh ON m.museum_id = mh.museum_id
WHERE mh.day IN ('Sunday', 'Monday')
GROUP BY m.museum_id, m.name, m.city
HAVING COUNT(DISTINCT mh.day) = 2;


-- 11. How many museums open every single day.

SELECT * from museum_hours
SELECT * from museum


SELECT COUNT(*) AS open_all_week
FROM (
    SELECT museum_id
    FROM museum_hours
    GROUP BY museum_id
    HAVING COUNT(DISTINCT day) = 7
) AS subquery;



-- 12. Which is the top 5 most popular museums? (Popularity is defined based on the most no of paintings in a museum).

SELECT m.name, COUNT(w.work_id) AS painting_total
FROM work w
JOIN museum m ON w.museum_id = m.museum_id
GROUP BY m.museum_id, m.name
ORDER BY painting_total DESC
LIMIT 5;
