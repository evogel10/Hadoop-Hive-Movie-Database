CREATE TABLE rating (userID INT, itemID INT, rating INT, time_stamp BIGINT)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE;


CREATE TABLE item (movieID INT, movie_title STRING, release_date STRING, 
video_release_date STRING, imdb_url STRING, unknown INT, action INT, 
adventure INT, animation INT, childrens INT, comedy INT, crime INT, 
documentary INT, drama INT, fantasy INT, film_noir INT, horror INT, 
musical INT, mystery INT, romance INT, sci_fi INT, thriller INT, war INT, 
western INT)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '/home/hdadmin/Downloads/ml-100k/u.data'
OVERWRITE INTO TABLE rating;

LOAD DATA LOCAL INPATH '/home/hdadmin/Downloads/ml-100k/u.item'
OVERWRITE INTO TABLE item;

SELECT i.movieID, i.movie_title, i.release_date, i.imdb_url, CAST(AVG(r.rating) AS DECIMAL(10,1)) FROM item i FULL OUTER JOIN rating r
ON (i.movieID = r.itemID)
GROUP BY i.movieID, i.movie_title, i.release_date, i.imdb_url
LIMIT 10;