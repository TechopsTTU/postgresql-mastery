-- ==========================================================================
-- SQL TYPING PRACTICE - 55 QUERIES
-- Instructions: Type each query below the comment. Test each one as you go.
-- TIP: Press ESC to dismiss autocomplete, or Ctrl+Alt+S → Editor → Code Completion
-- ==========================================================================

-- ==================== COMPARISON OPERATORS ====================

-- 1. Films with rental rate greater than 2.99
select * from film
where rental_rate > 2.99;

-- 2. Films with PG rating
select * from film
where rating = 'PG';

-- 3. Films longer than 120 minutes
select * from film
where length > 120;


-- 4. Active customers
select * from customer
where active = 1;

-- 5. Films with rental rate less than or equal to 0.99
select * from film
where rental_rate <= 0.99;

-- 6. Films with replacement cost greater than or equal to 20
select * from film
where replacement_cost >= 20;

-- 7. Customers who are not active
select * from customer
where active = 0;

-- 8. Films with length less than 60 minutes
select * from film
where length < 60;

-- 9. Payments greater than 5 dollars
select *
from payment
where amount > 5.00;

-- 10. Staff members with staff_id equal to 1
select * from staff
where staff_id = 1;

-- ==================== BETWEEN OPERATOR ====================

-- 11. Films with length between 90 and 120 minutes
select * from film
where rental_duration between 90 and 120;

-- 12. Films with rental rate between 1 and 3
select *  from film
where rental_rate between 1 and 3;


-- 13. Payments between 2 and 4 dollars
select * from payment
where amount between 2.00 and 4.00;

-- To check the data type of amount column
SELECT pg_typeof(amount) FROM payment LIMIT 1;

-- Alternatively, you can use the information_schema to check the data type
SELECT
    table_schema,
    table_name,
    column_name,
    data_type,
    numeric_precision,
    numeric_scale
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name   = 'payment'
  AND column_name  = 'amount';

-- 14. Films with replacement cost between 15 and 20
select * from film
where replacement_cost between 15 and 20;

-- 15. Rentals between specific dates (use '2005-05-01' and '2005-05-31')
select * from rental
where rental_date between '2005-05-01' and '2006-05-31';


-- ==================== IN OPERATOR ====================

-- 16. Films with ratings: G, PG, or PG-13
select * from film
where rating in ('G', 'PG', 'PG-13');

-- 17. Films with rental rates of 0.99, 2.99, or 4.99
select * from film
where rental_rate in (0.99, 2.99, 4.99);

-- 18. Customers from store IDs 1 or 2
select * from customer
where store_id in (1, 2);

-- 19. Films with language IDs 1 or 2
select * from film
where language_id in (1, 2);

-- 20. Actors with actor IDs: 1, 5, 10, 15, 20
select * from actor
where actor_id in (1, 5, 10, 15, 20);



-- ==================== LIKE OPERATOR ====================

-- 21. Films with titles starting with 'A'
select * from film
where title like 'A%';

-- 22. Films with titles ending with 'R'
select * from film
where title like '%R';

-- 23. Films with titles containing 'TRU' using 'ilike' for case-insensitive search

select * from film
where title ilike '%tru%';

-- 24. Customers with last names starting with 'S'
select * from customer
where last_name ilike 's%';

-- 25. Actors with first names containing 'AN'
select * from actor
where first_name like 'AN%';

-- 26. Films with descriptions containing 'Drama'
select * from film
where description like '%Drama%';

-- 27. Customers with emails ending in '.org'
select * from customer
where email like '%.org';

-- ==================== COMBINED CONDITIONS ====================

-- 28. Films with PG rating AND rental rate less than 3
select * from film
where rating = 'PG' and rental_rate < 3;

-- 29. Films longer than 100 minutes AND with R rating
select * from film
where length > 100 and rating = 'R';

-- 30. Films with rating G OR PG
select * from film
where rating = 'G' or rating = 'PG';

-- 31. Active customers from store 1
select * from customer
where store_id = 1 and active = 1;

-- 32. Films with rental rate greater than 3 OR length greater than 150
select * from film
where rental_rate > 3 OR  length > 150;

-- ==================== NOT OPERATOR ====================

-- 33. Films NOT rated PG-13
select * from film
where rating not in ('PG-13');


-- 34. Films with rental rate NOT between 2 and 3
select * from film
where rental_rate not between 2 and 3;


-- 35. Films NOT rated NC-17 or R
select * from film
where rating not in ('NC-17', 'R');

-- 36. Customers whose last name does NOT start with 'A'
select * from customer
where last_name not like 'A%';

-- ==================== CUSTOMER TABLE ====================

-- 37. Customers created after '2006-02-14'
select * from customer
where create_date > '2006-02-14';

-- 38. Customers from store 2
select * from customer
where store_id = 2;

-- 39. Inactive customers
select * from customer
where active = 0;

-- ==================== PAYMENT TABLE ====================

-- 40. Payments made by customer_id

select * from payment
where customer_id = 1;

-- 41. Payments less than 1 dollar
select * from payment
where amount < 1.00;

-- 42. Payments by staff_id 2
select * from payment
where staff_id = 2;

-- ==================== RENTAL TABLE ====================

-- 43. Rentals by customer 10
select * from rental
where customer_id = 10;

-- 44. Rentals from inventory_id greater than 1000
select * from rental
where inventory_id > 1000;

-- 45. Rentals that have been returned (return_date IS NOT NULL)
select * from rental
where return_date IS NOT NULL;

-- 46. Rentals that haven't been returned yet (return_date IS NULL)
select * from rental
where return_date IS NULL;

-- ==================== ACTOR TABLE ====================

-- 47. Actors with first name 'JOHN'
select * from actor
where first_name = 'JOHN';

-- 48. Actors with last name starting with 'D'
select * from actor
where last_name like 'D%';

-- ==================== INVENTORY TABLE ====================

-- 49. Inventory items from store 1
select * from inventory
where store_id = 1;

-- 50. Inventory for film_id less than 10
select * from inventory
where film_id < 10;

-- ==================== BONUS CHALLENGES ====================

-- 51. Films with rental duration equal to 3 days
select * from film
where rental_duration = 3;

-- 52. Payments between 3 and 6 dollars AND customer_id = 100
select * from payment
where amount between 3.00 and 6.00 and customer_id = 100;

-- 53. Films: PG rating AND length > 90 AND rental_rate < 3
select * from film
where rating = 'PG' and length > 90 and rental_rate < 3;

-- 54. Actors with last names ending in 'SON'
select * from actor
where last_name like '%SON';

-- 55. Films with replacement cost NOT equal to 20.99
select * from film
where replacement_cost <> 20.99;

-- ==========================================================================
-- CONGRATULATIONS! You've completed 55 SQL queries!
-- ==========================================================================
