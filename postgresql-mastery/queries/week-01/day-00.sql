-- noinspection SqlNoDataSourceInspectionForFile
-- @formatter:off
-- ==========================================================================
-- SQL PRACTICE QUERIES - TYPING PRACTICE MODE (NO AUTOCOMPLETE)
-- ==========================================================================

select * from film
limit 10;


-- List all columns of the "film" table along with their data types and whether they can be null.
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'film'
ORDER BY ordinal_position;

-- Retrieve the first 5 records from the "film" table.
select description,release_year
from film limit 10;

-- Count the total number of records in the "film" table
select count(*) from film;

-- Find all films released in the year 2006.
select  * from film;

-- Find the titles and release years of all films released in the year 2006.
select title, release_year from film
where release_year = 2006
order by  title desc ;

-- List all columns of the "film" table along with their data types,
-- maximum character lengths, nullability, and default values.
SELECT
    column_name,
    data_type,
    character_maximum_length,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'film'
ORDER BY ordinal_position;

select rating, COUNT(*) as total_films
from film
group by rating
order by total_films desc;

-- List the film_id and title of all films, grouping by film_id.
SELECT film_id, title
FROM film
GROUP BY film_id;




