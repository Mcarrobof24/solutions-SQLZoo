-- 1.  List the films where the yr is 1962 [Show id, title]
SELECT id, title
 FROM movie
 WHERE yr=1962

-- 2. Give year of 'Citizen Kane'.
SELECT yr
 FROM movie
 WHERE title='Citizen Kane'

-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr

-- 4. What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name='Glenn Close'

-- 5. What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title='Casablanca'

-- 6. Obtain the cast list for 'Casablanca'.
-- what is a cast list?
-- The cast list is the names of the actors who were in the movie.
-- Use movieid=11768, (or whatever value you got from the previous question)
SELECT a.name 
FROM actor a JOIN casting c 
ON a.id = c.actorid
WHERE movieid =11768

-- 7. Obtain the cast list for the film 'Alien'
SELECT A.name FROM
   movie M JOIN casting C ON M.id=C.movieid
           JOIN actor A ON C.actorid=A.id
WHERE title ='Alien'

-- 8. List the films in which 'Harrison Ford' has appeared
SELECT M.title FROM
   movie M JOIN casting C ON M.id=C.movieid
         JOIN actor A ON C.actorid=A.id
WHERE A.name ='Harrison Ford'

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT M.title FROM
   movie M JOIN casting C ON M.id=C.movieid
         JOIN actor A ON C.actorid=A.id
WHERE A.name ='Harrison Ford' AND C.ord <> 1

-- 10. List the films together with the leading star for all 1962 films.
SELECT M.title, A.name FROM
   movie M JOIN casting C ON M.id=C.movieid
         JOIN actor A ON C.actorid=A.id
WHERE M.yr =1962 AND C.ord = 1

-- 11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
-- Did you get "Little Miss Marker twice"?

SELECT movie.title, actor.name 
FROM movie 
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE movie.id IN 
(SELECT casting.movieId FROM casting JOIN actor ON casting.actorid = actor.id
where actor.name = 'Julie Andrews')
AND casting.ord = 1

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles
SELECT actor.name FROM
actor JOIN casting ON actor.id = casting.actorid
WHERE (SELECT COUNT(ord) FROM casting 
WHERE ord=1 AND actorid = actor.id)>=15
GROUP BY name

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT movie.title, COUNT(casting.actorid) AS total FROM
movie JOIN casting ON movie.id= casting.movieid
WHERE yr = 1978
GROUP BY movie.title
ORDER BY total DESC, movie.title

-- 15. List all the people who have worked with 'Art Garfunkel'.
SELECT name FROM actor JOIN casting ON actor.id = actorid
WHERE movieid IN
  (SELECT id FROM movie WHERE title IN
    (SELECT title FROM movie JOIN casting ON movie.id = movieid WHERE actorid IN
      (SELECT id FROM actor WHERE name = 'Art Garfunkel')))
  AND name != 'Art Garfunkel'

