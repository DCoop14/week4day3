-- FROM CLAUSE (LEFT TABLE)
-- JOIN CLAUSE (RIGHT TABLE)


--INNER JOIN
SELECT *
FROM artist
INNER JOIN favorite_song
ON favorite_song.artist_id = artist.artist_id;


--combine into 1
SELECT artist_id FROM favorite_song WHERE song_name = 'Grindng All My Life';
SELECT artist_name FROM artist WHERE artist_id = 4;

--
SELECT artist_name
FROM artist
INNER JOIN favorite_song
ON favorite_song.artist_id = artist.artist_id
WHERE song_name = 'Grinding All My Life';

-- LEFT JOIN
SELECT artist_name, song_name, artist.artist_id
FROM favorite_song
LEFT JOIN artist
ON favorite_song.artist_id = artist.artist_id;

-- RIGHT JOIN
SELECT artist_name, song_name, artist.artist_id
FROM favorite_song
RIGHT JOIN artist
ON favorite_song.artist_id = artist.artist_id;


-- FULL JOIN (OUTER JOIN)
SELECT artist.artist_name, record_label, f_s.song_name, f_s.artist_id, album, COUNT(*)
FROM favorite_song AS f_s
FULL JOIN artist
ON f_s.artist_id = artist.artist_id
GROUP BY f_s.artist_id, artist.artist_name, record_label, song_name, album
ORDER BY COUNT(*) DESC;





