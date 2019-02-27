USE albums_db;
SHOW TABLES;
DESCRIBE albums;
SELECT name FROM albums WHERE artist = 'Pink Floyd';
SELECT release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
SELECT genre FROM albums WHERE name = 'Nevermind';
SELECT name FROM albums WHERE release_date between 1990 AND 1999;
SELECT name FROM albums WHERE sales < 20;
SELECT name FROM albums WHERE genre = 'Rock';
-- It only searches "Rock" not things that incluse "Rock" 
-- Would need to use LIKE and %Rock to find all kinds of Rock.