-- creacion de base de datos
CREATE DATABASE movies;

-- cambio a la base de datos
\c movies

CREATE TABLE movie(
    id INT, 
    movie VARCHAR(100), 
    release_year INT, 
    director VARCHAR(50), 
    PRIMARY KEY(id)
    );

CREATE TABLE cast(
    id INT, 
    actor VARCHAR(50), FOREIGN KEY (id) REFERENCES movie(id)
    );

\copy movie FROM 'peliculas.csv' csv header;
\copy cast FROM 'cast.csv' csv;

--Peticion Titanic
SELECT movie, release_year, director, actor FROM movie JOIN cast ON movie.id=cast.id WHERE movie.movie='Titanic';

--Peliculas donde actua Harrison ford
SELECT movie FROM movie JOIN cast ON movie.id=cast.id WHERE cast.actor='Harrison Ford';

--10 directores mas populares del top 100
SELECT director,count(*) AS numero_peliculas FROM movie GROUP BY director ORDER BY count(*) DESC LIMIT 10; 

--Actores distintos
SELECT count(DISTINCT actor)  AS num_actors_different FROM cast;

--Películas estrenadas entre  1990 y 1999
SELECT movie, release_year FROM movie WHERE release_year >= 1990 AND release_year <= 1999 ORDER BY movie;

--Reparto de peliculas de 2001
SELECT actor, movie, release_year FROM movie JOIN cast ON movie.id=cast.id WHERE release_year=2001;

--Actores de la ultima pelicula estrenada
SELECT actor FROM cast WHERE id=(SELECT id FROM movie ORDER BY release_year DESC LIMIT 1);