-- Day 00: Example queries

-- List first 10 films (from pagila sample schema)
SELECT * FROM film LIMIT 10;

-- Show table sizes
SELECT schemaname, relname AS table_name, pg_size_pretty(pg_total_relation_size(relid)) AS total_size
FROM pg_catalog.pg_statio_user_tables
ORDER BY pg_total_relation_size(relid) DESC;
