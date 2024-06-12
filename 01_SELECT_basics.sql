-- 1. Introducing the world table of countries
-- The example uses a WHERE clause to show the population of 'France'. Note that strings should be in 'single quotes';
-- Modify it to show the population of Germany
SELECT population FROM world
  WHERE name = 'Germany'
