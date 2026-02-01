-- Day 00: Practice queries

-- Practice query 1: List all films
SELECT * FROM film;

-- Practice query 2: Count total films
SELECT COUNT(*) FROM film;

-- Practice query 3: Show database size
SELECT pg_database.datname, pg_size_pretty(pg_database_size(pg_database.datname)) AS size
FROM pg_database;
