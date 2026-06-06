-- =====================================================
-- HAS_GENRE DATA
-- =====================================================

-- MOVIE 1: INCEPTION (title_id = 1)
INSERT INTO has_genre (title_id, genre_id) VALUES
(1, (SELECT genre_id FROM genre WHERE name_en = 'Action')),
(1, (SELECT genre_id FROM genre WHERE name_en = 'Sci-Fi')),
(1, (SELECT genre_id FROM genre WHERE name_en = 'Thriller'));

-- MOVIE 2: THE DARK KNIGHT (title_id = 2)
INSERT INTO has_genre (title_id, genre_id) VALUES
(2, (SELECT genre_id FROM genre WHERE name_en = 'Action')),
(2, (SELECT genre_id FROM genre WHERE name_en = 'Crime')),
(2, (SELECT genre_id FROM genre WHERE name_en = 'Drama')),
(2, (SELECT genre_id FROM genre WHERE name_en = 'Thriller'));

-- MOVIE 3: PULP FICTION (title_id = 3)
INSERT INTO has_genre (title_id, genre_id) VALUES
(3, (SELECT genre_id FROM genre WHERE name_en = 'Crime')),
(3, (SELECT genre_id FROM genre WHERE name_en = 'Drama'));

-- MOVIE 4: FORREST GUMP (title_id = 4)
INSERT INTO has_genre (title_id, genre_id) VALUES
(4, (SELECT genre_id FROM genre WHERE name_en = 'Drama')),
(4, (SELECT genre_id FROM genre WHERE name_en = 'Romance'));

-- MOVIE 5: THE MATRIX (title_id = 5)
INSERT INTO has_genre (title_id, genre_id) VALUES
(5, (SELECT genre_id FROM genre WHERE name_en = 'Action')),
(5, (SELECT genre_id FROM genre WHERE name_en = 'Sci-Fi'));

-- MOVIE 6: TITANIC (title_id = 6)
INSERT INTO has_genre (title_id, genre_id) VALUES
(6, (SELECT genre_id FROM genre WHERE name_en = 'Drama')),
(6, (SELECT genre_id FROM genre WHERE name_en = 'Romance')),
(6, (SELECT genre_id FROM genre WHERE name_en = 'Disaster'));

-- MOVIE 7: GLADIATOR (title_id = 7)
INSERT INTO has_genre (title_id, genre_id) VALUES
(7, (SELECT genre_id FROM genre WHERE name_en = 'Action')),
(7, (SELECT genre_id FROM genre WHERE name_en = 'Adventure')),
(7, (SELECT genre_id FROM genre WHERE name_en = 'Drama')),
(7, (SELECT genre_id FROM genre WHERE name_en = 'Epic'));

-- MOVIE 8: PARASITE (title_id = 8)
INSERT INTO has_genre (title_id, genre_id) VALUES
(8, (SELECT genre_id FROM genre WHERE name_en = 'Drama')),
(8, (SELECT genre_id FROM genre WHERE name_en = 'Thriller'));

-- MOVIE 9: OPPENHEIMER (title_id = 9)
INSERT INTO has_genre (title_id, genre_id) VALUES
(9, (SELECT genre_id FROM genre WHERE name_en = 'Biography')),
(9, (SELECT genre_id FROM genre WHERE name_en = 'Drama')),
(9, (SELECT genre_id FROM genre WHERE name_en = 'Historical')),
(9, (SELECT genre_id FROM genre WHERE name_en = 'Thriller'));

-- MOVIE 10: THE SOCIAL NETWORK (title_id = 10)
INSERT INTO has_genre (title_id, genre_id) VALUES
(10, (SELECT genre_id FROM genre WHERE name_en = 'Biography')),
(10, (SELECT genre_id FROM genre WHERE name_en = 'Drama'));

-- SERIES 1: GAME OF THRONES (title_id = 11)
INSERT INTO has_genre (title_id, genre_id) VALUES
(11, (SELECT genre_id FROM genre WHERE name_en = 'Action')),
(11, (SELECT genre_id FROM genre WHERE name_en = 'Adventure')),
(11, (SELECT genre_id FROM genre WHERE name_en = 'Drama')),
(11, (SELECT genre_id FROM genre WHERE name_en = 'Fantasy')),
(11, (SELECT genre_id FROM genre WHERE name_en = 'Epic'));

-- SERIES 2: BREAKING BAD (title_id = 12)
INSERT INTO has_genre (title_id, genre_id) VALUES
(12, (SELECT genre_id FROM genre WHERE name_en = 'Crime')),
(12, (SELECT genre_id FROM genre WHERE name_en = 'Drama')),
(12, (SELECT genre_id FROM genre WHERE name_en = 'Thriller'));

-- SERIES 3: STRANGER THINGS (title_id = 13)
INSERT INTO has_genre (title_id, genre_id) VALUES
(13, (SELECT genre_id FROM genre WHERE name_en = 'Drama')),
(13, (SELECT genre_id FROM genre WHERE name_en = 'Fantasy')),
(13, (SELECT genre_id FROM genre WHERE name_en = 'Horror')),
(13, (SELECT genre_id FROM genre WHERE name_en = 'Mystery')),
(13, (SELECT genre_id FROM genre WHERE name_en = 'Sci-Fi'));

-- SERIES 4: THE CROWN (title_id = 14)
INSERT INTO has_genre (title_id, genre_id) VALUES
(14, (SELECT genre_id FROM genre WHERE name_en = 'Biography')),
(14, (SELECT genre_id FROM genre WHERE name_en = 'Drama')),
(14, (SELECT genre_id FROM genre WHERE name_en = 'Historical'));

-- SERIES 5: SUCCESSION (title_id = 15)
INSERT INTO has_genre (title_id, genre_id) VALUES
(15, (SELECT genre_id FROM genre WHERE name_en = 'Comedy')),
(15, (SELECT genre_id FROM genre WHERE name_en = 'Drama'));

-- SERIES 6: DARK (title_id = 16)
INSERT INTO has_genre (title_id, genre_id) VALUES
(16, (SELECT genre_id FROM genre WHERE name_en = 'Drama')),
(16, (SELECT genre_id FROM genre WHERE name_en = 'Mystery')),
(16, (SELECT genre_id FROM genre WHERE name_en = 'Sci-Fi')),
(16, (SELECT genre_id FROM genre WHERE name_en = 'Thriller'));

-- SERIES 7: WESTWORLD (title_id = 17)
INSERT INTO has_genre (title_id, genre_id) VALUES
(17, (SELECT genre_id FROM genre WHERE name_en = 'Drama')),
(17, (SELECT genre_id FROM genre WHERE name_en = 'Mystery')),
(17, (SELECT genre_id FROM genre WHERE name_en = 'Sci-Fi')),
(17, (SELECT genre_id FROM genre WHERE name_en = 'Western'));

-- SERIES 8: THE MANDALORIAN (title_id = 18)
INSERT INTO has_genre (title_id, genre_id) VALUES
(18, (SELECT genre_id FROM genre WHERE name_en = 'Action')),
(18, (SELECT genre_id FROM genre WHERE name_en = 'Adventure')),
(18, (SELECT genre_id FROM genre WHERE name_en = 'Fantasy')),
(18, (SELECT genre_id FROM genre WHERE name_en = 'Sci-Fi'));

-- SERIES 9: HOUSE OF THE DRAGON (title_id = 19)
INSERT INTO has_genre (title_id, genre_id) VALUES
(19, (SELECT genre_id FROM genre WHERE name_en = 'Action')),
(19, (SELECT genre_id FROM genre WHERE name_en = 'Adventure')),
(19, (SELECT genre_id FROM genre WHERE name_en = 'Drama')),
(19, (SELECT genre_id FROM genre WHERE name_en = 'Fantasy')),
(19, (SELECT genre_id FROM genre WHERE name_en = 'Epic'));

-- SERIES 10: THE LAST OF US (title_id = 20)
INSERT INTO has_genre (title_id, genre_id) VALUES
(20, (SELECT genre_id FROM genre WHERE name_en = 'Action')),
(20, (SELECT genre_id FROM genre WHERE name_en = 'Adventure')),
(20, (SELECT genre_id FROM genre WHERE name_en = 'Drama')),
(20, (SELECT genre_id FROM genre WHERE name_en = 'Horror'));