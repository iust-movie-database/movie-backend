-- =====================================================
-- RECOMMENDED DATA (Personalized recommendations)
-- =====================================================

-- User 1 (john_doe) - 8 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(1, 9, '2024-06-01', 95),
(1, 2, '2024-06-01', 92),
(1, 11, '2024-06-01', 90),
(1, 5, '2024-06-01', 88),
(1, 13, '2024-06-01', 85),
(1, 7, '2024-06-01', 82),
(1, 12, '2024-06-01', 80),
(1, 20, '2024-06-01', 78);

-- User 2 (jane_smith) - 8 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(2, 6, '2024-06-01', 93),
(2, 4, '2024-06-01', 91),
(2, 1, '2024-06-01', 89),
(2, 14, '2024-06-01', 87),
(2, 8, '2024-06-01', 85),
(2, 3, '2024-06-01', 83),
(2, 10, '2024-06-01', 80),
(2, 15, '2024-06-01', 78);

-- User 3 (mike_wilson) - 6 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(3, 5, '2024-06-01', 94),
(3, 1, '2024-06-01', 91),
(3, 7, '2024-06-01', 88),
(3, 2, '2024-06-01', 86),
(3, 12, '2024-06-01', 84),
(3, 16, '2024-06-01', 82);

-- User 4 (sarah_johnson) - 8 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(4, 11, '2024-06-01', 96),
(4, 2, '2024-06-01', 93),
(4, 7, '2024-06-01', 90),
(4, 19, '2024-06-01', 88),
(4, 1, '2024-06-01', 86),
(4, 12, '2024-06-01', 84),
(4, 5, '2024-06-01', 82),
(4, 20, '2024-06-01', 80);

-- User 5 (admin_user) - 10 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(5, 1, '2024-06-01', 98),
(5, 2, '2024-06-01', 97),
(5, 3, '2024-06-01', 96),
(5, 4, '2024-06-01', 95),
(5, 5, '2024-06-01', 94),
(5, 6, '2024-06-01', 93),
(5, 7, '2024-06-01', 92),
(5, 8, '2024-06-01', 91),
(5, 9, '2024-06-01', 90),
(5, 10, '2024-06-01', 89);

-- User 6 (emma_davis) - 7 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(6, 13, '2024-06-01', 92),
(6, 1, '2024-06-01', 89),
(6, 11, '2024-06-01', 87),
(6, 5, '2024-06-01', 85),
(6, 16, '2024-06-01', 83),
(6, 2, '2024-06-01', 81),
(6, 18, '2024-06-01', 79);

-- User 7 (chris_brown) - 7 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(7, 12, '2024-06-01', 93),
(7, 11, '2024-06-01', 91),
(7, 3, '2024-06-01', 88),
(7, 15, '2024-06-01', 86),
(7, 8, '2024-06-01', 84),
(7, 2, '2024-06-01', 82),
(7, 20, '2024-06-01', 80);

-- User 8 (lisa_anderson) - 6 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(8, 14, '2024-06-01', 90),
(8, 6, '2024-06-01', 88),
(8, 4, '2024-06-01', 86),
(8, 9, '2024-06-01', 84),
(8, 1, '2024-06-01', 82),
(8, 10, '2024-06-01', 80);

-- User 9 (alex_turner) - 6 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(9, 5, '2024-06-01', 94),
(9, 1, '2024-06-01', 92),
(9, 2, '2024-06-01', 89),
(9, 13, '2024-06-01', 87),
(9, 11, '2024-06-01', 85),
(9, 18, '2024-06-01', 83);

-- User 10 (olivia_wilson) - 6 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(10, 20, '2024-06-01', 91),
(10, 7, '2024-06-01', 89),
(10, 12, '2024-06-01', 87),
(10, 1, '2024-06-01', 85),
(10, 4, '2024-06-01', 83),
(10, 13, '2024-06-01', 81);

-- User 11 (david_martin) - 6 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(11, 16, '2024-06-01', 92),
(11, 1, '2024-06-01', 90),
(11, 13, '2024-06-01', 88),
(11, 5, '2024-06-01', 86),
(11, 11, '2024-06-01', 84),
(11, 2, '2024-06-01', 82);

-- User 12 (sophia_lee) - 5 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(12, 4, '2024-06-01', 89),
(12, 6, '2024-06-01', 87),
(12, 14, '2024-06-01', 85),
(12, 8, '2024-06-01', 83),
(12, 10, '2024-06-01', 81);

-- User 13 (james_white) - 7 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(13, 15, '2024-06-01', 93),
(13, 12, '2024-06-01', 91),
(13, 11, '2024-06-01', 89),
(13, 8, '2024-06-01', 87),
(13, 3, '2024-06-01', 85),
(13, 2, '2024-06-01', 83),
(13, 19, '2024-06-01', 81);

-- User 14 (isabella_clark) - 5 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(14, 9, '2024-06-01', 88),
(14, 14, '2024-06-01', 86),
(14, 6, '2024-06-01', 84),
(14, 4, '2024-06-01', 82),
(14, 1, '2024-06-01', 80);

-- User 15 (benjamin_taylor) - 6 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(15, 2, '2024-06-01', 92),
(15, 11, '2024-06-01', 90),
(15, 1, '2024-06-01', 88),
(15, 7, '2024-06-01', 86),
(15, 12, '2024-06-01', 84),
(15, 5, '2024-06-01', 82);

-- User 16 (mia_rodriguez) - 5 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(16, 18, '2024-06-01', 87),
(16, 13, '2024-06-01', 85),
(16, 5, '2024-06-01', 83),
(16, 1, '2024-06-01', 81),
(16, 11, '2024-06-01', 79);

-- User 17 (ethan_moore) - 6 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(17, 19, '2024-06-01', 91),
(17, 11, '2024-06-01', 89),
(17, 2, '2024-06-01', 87),
(17, 7, '2024-06-01', 85),
(17, 15, '2024-06-01', 83),
(17, 12, '2024-06-01', 81);

-- User 18 (amelia_jackson) - 5 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(18, 14, '2024-06-01', 86),
(18, 6, '2024-06-01', 84),
(18, 4, '2024-06-01', 82),
(18, 9, '2024-06-01', 80),
(18, 8, '2024-06-01', 78);

-- User 19 (alexander_hill) - 6 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(19, 20, '2024-06-01', 90),
(19, 12, '2024-06-01', 88),
(19, 16, '2024-06-01', 86),
(19, 13, '2024-06-01', 84),
(19, 1, '2024-06-01', 82),
(19, 11, '2024-06-01', 80);

-- User 20 (charlotte_baker) - 6 recommendations
INSERT INTO recommended (user_id, title_id, recom_date, score) VALUES
(20, 13, '2024-06-01', 89),
(20, 20, '2024-06-01', 87),
(20, 1, '2024-06-01', 85),
(20, 11, '2024-06-01', 83),
(20, 2, '2024-06-01', 81),
(20, 5, '2024-06-01', 79);