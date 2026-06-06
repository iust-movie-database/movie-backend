-- =====================================================
-- SAVED DATA (Watchlist) - COMPLETE
-- =====================================================

-- User 1 (john_doe) watchlist - 13 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(1, 2, 'Watched', '2023-01-20'),
(1, 5, 'Watched', '2023-02-15'),
(1, 8, 'Watched', '2023-03-10'),
(1, 11, 'Watching', '2023-04-05'),
(1, 12, 'Want to Watch', '2023-05-01'),
(1, 4, 'Watching', '2023-06-15'),
(1, 1, 'Watched', '2023-07-20'),
(1, 20, 'Want to Watch', '2024-01-10'),
(1, 3, 'Watched', '2023-08-10'),
(1, 6, 'Watched', '2023-09-15'),
(1, 7, 'Watched', '2023-10-20'),
(1, 9, 'Want to Watch', '2023-11-25'),
(1, 10, 'Want to Watch', '2023-12-30');

-- User 2 (jane_smith) watchlist - 13 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(2, 1, 'Watched', '2023-02-10'),
(2, 2, 'Watched', '2023-03-15'),
(2, 3, 'Watched', '2023-04-20'),
(2, 6, 'Watched', '2023-05-10'),
(2, 9, 'Watched', '2023-06-25'),
(2, 10, 'Watching', '2023-07-15'),
(2, 11, 'Watching', '2023-08-01'),
(2, 13, 'Want to Watch', '2023-09-05'),
(2, 15, 'Want to Watch', '2023-10-10'),
(2, 19, 'Want to Watch', '2024-02-01'),
(2, 4, 'Watched', '2023-11-15'),
(2, 7, 'Watched', '2023-12-20'),
(2, 8, 'Watched', '2024-01-25');

-- User 3 (mike_wilson) watchlist - 7 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(3, 4, 'Watched', '2023-03-05'),
(3, 5, 'Watched', '2023-04-15'),
(3, 7, 'Watched', '2023-05-20'),
(3, 8, 'Watching', '2023-06-25'),
(3, 12, 'Want to Watch', '2023-07-30'),
(3, 14, 'Want to Watch', '2023-08-15'),
(3, 16, 'Want to Watch', '2024-01-20');

-- User 4 (sarah_johnson) watchlist - 13 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(4, 6, 'Watched', '2023-04-10'),
(4, 9, 'Watched', '2023-05-15'),
(4, 10, 'Watching', '2023-06-20'),
(4, 11, 'Watching', '2023-07-25'),
(4, 13, 'Watched', '2023-08-10'),
(4, 14, 'Want to Watch', '2023-09-15'),
(4, 17, 'Want to Watch', '2023-10-20'),
(4, 18, 'Want to Watch', '2024-01-25'),
(4, 20, 'Want to Watch', '2024-02-15'),
(4, 1, 'Watched', '2023-11-10'),
(4, 2, 'Watched', '2023-12-15'),
(4, 3, 'Watched', '2024-01-20'),
(4, 5, 'Watching', '2024-02-25');

-- User 5 (admin_user) watchlist - 12 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(5, 1, 'Watched', '2023-01-10'),
(5, 2, 'Watched', '2023-01-15'),
(5, 3, 'Watched', '2023-02-20'),
(5, 4, 'Watched', '2023-03-01'),
(5, 5, 'Watched', '2023-03-10'),
(5, 6, 'Watched', '2023-04-05'),
(5, 7, 'Watched', '2023-05-10'),
(5, 8, 'Watched', '2023-06-15'),
(5, 9, 'Watched', '2023-07-20'),
(5, 10, 'Watched', '2023-08-25'),
(5, 11, 'Watched', '2023-09-30'),
(5, 12, 'Watched', '2023-10-05');

-- User 6 (emma_davis) watchlist - 13 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(6, 1, 'Watched', '2023-06-01'),
(6, 2, 'Watched', '2023-07-05'),
(6, 8, 'Watched', '2023-08-10'),
(6, 13, 'Watching', '2023-09-15'),
(6, 15, 'Want to Watch', '2023-10-20'),
(6, 19, 'Want to Watch', '2024-02-10'),
(6, 3, 'Watched', '2023-10-01'),
(6, 4, 'Watched', '2023-10-15'),
(6, 5, 'Watched', '2023-11-01'),
(6, 6, 'Watched', '2023-11-15'),
(6, 7, 'Watched', '2023-12-01'),
(6, 9, 'Watched', '2024-01-05'),
(6, 10, 'Watched', '2024-01-20');

-- User 7 (chris_brown) watchlist - 13 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(7, 3, 'Watched', '2023-07-01'),
(7, 4, 'Watched', '2023-08-05'),
(7, 5, 'Watched', '2023-09-10'),
(7, 7, 'Watched', '2023-10-15'),
(7, 11, 'Watching', '2023-11-20'),
(7, 12, 'Want to Watch', '2023-12-25'),
(7, 16, 'Want to Watch', '2024-01-30'),
(7, 20, 'Want to Watch', '2024-02-20'),
(7, 1, 'Watched', '2024-01-01'),
(7, 2, 'Watched', '2024-01-10'),
(7, 6, 'Watched', '2024-01-15'),
(7, 8, 'Watched', '2024-01-20'),
(7, 9, 'Watched', '2024-01-25');

-- User 8 (lisa_anderson) watchlist - 13 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(8, 2, 'Watched', '2023-08-01'),
(8, 6, 'Watched', '2023-09-05'),
(8, 9, 'Watched', '2023-10-10'),
(8, 10, 'Watching', '2023-11-15'),
(8, 14, 'Want to Watch', '2023-12-20'),
(8, 17, 'Want to Watch', '2024-01-25'),
(8, 18, 'Want to Watch', '2024-02-28'),
(8, 1, 'Watched', '2023-12-01'),
(8, 3, 'Watched', '2023-12-10'),
(8, 4, 'Watched', '2023-12-20'),
(8, 5, 'Watched', '2024-01-01'),
(8, 7, 'Watched', '2024-01-10'),
(8, 8, 'Watched', '2024-01-20');

-- User 9 (alex_turner) watchlist - 13 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(9, 5, 'Watched', '2023-09-01'),
(9, 8, 'Watched', '2023-10-05'),
(9, 11, 'Watching', '2023-11-10'),
(9, 15, 'Want to Watch', '2023-12-15'),
(9, 19, 'Want to Watch', '2024-01-20'),
(9, 1, 'Watched', '2023-11-01'),
(9, 2, 'Watched', '2023-11-10'),
(9, 3, 'Watched', '2023-11-20'),
(9, 4, 'Watched', '2023-12-01'),
(9, 6, 'Watched', '2023-12-10'),
(9, 7, 'Watched', '2023-12-20'),
(9, 9, 'Watched', '2024-01-05'),
(9, 10, 'Watched', '2024-01-15');

-- User 10 (olivia_wilson) watchlist - 13 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(10, 1, 'Watched', '2023-10-01'),
(10, 4, 'Watched', '2023-11-05'),
(10, 7, 'Watched', '2023-12-10'),
(10, 13, 'Watching', '2024-01-15'),
(10, 14, 'Want to Watch', '2024-02-20'),
(10, 20, 'Want to Watch', '2024-03-01'),
(10, 2, 'Watched', '2023-11-10'),
(10, 3, 'Watched', '2023-11-20'),
(10, 5, 'Watched', '2023-12-01'),
(10, 6, 'Watched', '2023-12-10'),
(10, 8, 'Watched', '2023-12-20'),
(10, 9, 'Watched', '2024-01-10'),
(10, 10, 'Watched', '2024-01-20');

-- User 11 (david_martin) watchlist - 13 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(11, 2, 'Watched', '2023-11-01'),
(11, 3, 'Watched', '2023-12-05'),
(11, 6, 'Watched', '2024-01-10'),
(11, 9, 'Watched', '2024-01-15'),
(11, 12, 'Watching', '2024-01-20'),
(11, 16, 'Want to Watch', '2024-02-25'),
(11, 1, 'Watched', '2024-01-01'),
(11, 4, 'Watched', '2024-01-05'),
(11, 5, 'Watched', '2024-01-10'),
(11, 7, 'Watched', '2024-01-15'),
(11, 8, 'Watched', '2024-01-20'),
(11, 10, 'Watched', '2024-01-25'),
(11, 11, 'Watched', '2024-01-30');

-- User 12 (sophia_lee) watchlist - 5 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(12, 4, 'Watched', '2023-12-01'),
(12, 5, 'Watched', '2024-01-05'),
(12, 10, 'Watching', '2024-01-10'),
(12, 11, 'Want to Watch', '2024-01-15'),
(12, 18, 'Want to Watch', '2024-02-20');

-- User 13 (james_white) watchlist - 13 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(13, 1, 'Watched', '2024-01-01'),
(13, 7, 'Watched', '2024-01-05'),
(13, 8, 'Watched', '2024-01-10'),
(13, 13, 'Watching', '2024-01-15'),
(13, 15, 'Want to Watch', '2024-01-20'),
(13, 17, 'Want to Watch', '2024-01-25'),
(13, 19, 'Want to Watch', '2024-02-01'),
(13, 2, 'Watched', '2024-01-10'),
(13, 3, 'Watched', '2024-01-15'),
(13, 4, 'Watched', '2024-01-20'),
(13, 5, 'Watched', '2024-01-25'),
(13, 6, 'Watched', '2024-01-30'),
(13, 9, 'Watched', '2024-02-05');

-- User 14 (isabella_clark) watchlist - 5 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(14, 2, 'Watched', '2024-01-10'),
(14, 6, 'Watched', '2024-01-15'),
(14, 9, 'Watched', '2024-01-20'),
(14, 14, 'Watching', '2024-01-25'),
(14, 20, 'Want to Watch', '2024-02-01');

-- User 15 (benjamin_taylor) watchlist - 13 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(15, 3, 'Watched', '2024-02-01'),
(15, 5, 'Watched', '2024-02-05'),
(15, 8, 'Watched', '2024-02-10'),
(15, 11, 'Watching', '2024-02-15'),
(15, 12, 'Want to Watch', '2024-02-20'),
(15, 16, 'Want to Watch', '2024-02-25'),
(15, 1, 'Watched', '2024-02-05'),
(15, 2, 'Watched', '2024-02-10'),
(15, 4, 'Watched', '2024-02-15'),
(15, 6, 'Watched', '2024-02-20'),
(15, 7, 'Watched', '2024-02-25'),
(15, 9, 'Watched', '2024-03-01'),
(15, 10, 'Watched', '2024-03-05');

-- User 16 (mia_rodriguez) watchlist - 5 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(16, 4, 'Watched', '2024-02-10'),
(16, 7, 'Watched', '2024-02-15'),
(16, 10, 'Watched', '2024-02-20'),
(16, 13, 'Watching', '2024-02-25'),
(16, 18, 'Want to Watch', '2024-03-01');

-- User 17 (ethan_moore) watchlist - 13 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(17, 1, 'Watched', '2024-02-15'),
(17, 2, 'Watched', '2024-02-20'),
(17, 9, 'Watched', '2024-02-25'),
(17, 11, 'Watching', '2024-03-01'),
(17, 15, 'Want to Watch', '2024-03-05'),
(17, 19, 'Want to Watch', '2024-03-10'),
(17, 3, 'Watched', '2024-02-20'),
(17, 4, 'Watched', '2024-02-25'),
(17, 5, 'Watched', '2024-03-01'),
(17, 6, 'Watched', '2024-03-05'),
(17, 7, 'Watched', '2024-03-10'),
(17, 8, 'Watched', '2024-03-15'),
(17, 10, 'Watched', '2024-03-20');

-- User 18 (amelia_jackson) watchlist - 5 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(18, 5, 'Watched', '2024-03-01'),
(18, 6, 'Watched', '2024-03-05'),
(18, 8, 'Watched', '2024-03-10'),
(18, 14, 'Watching', '2024-03-15'),
(18, 17, 'Want to Watch', '2024-03-20');

-- User 19 (alexander_hill) watchlist - 13 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(19, 3, 'Watched', '2024-03-10'),
(19, 7, 'Watched', '2024-03-15'),
(19, 10, 'Watched', '2024-03-20'),
(19, 12, 'Watching', '2024-03-25'),
(19, 16, 'Want to Watch', '2024-03-30'),
(19, 20, 'Want to Watch', '2024-04-01'),
(19, 1, 'Watched', '2024-03-15'),
(19, 2, 'Watched', '2024-03-20'),
(19, 4, 'Watched', '2024-03-25'),
(19, 5, 'Watched', '2024-03-30'),
(19, 6, 'Watched', '2024-04-05'),
(19, 8, 'Watched', '2024-04-10'),
(19, 9, 'Watched', '2024-04-15');

-- User 20 (charlotte_baker) watchlist - 13 titles
INSERT INTO saved (user_id, title_id, status, added_date) VALUES
(20, 2, 'Watched', '2024-04-01'),
(20, 4, 'Watched', '2024-04-05'),
(20, 8, 'Watched', '2024-04-10'),
(20, 11, 'Watching', '2024-04-15'),
(20, 13, 'Want to Watch', '2024-04-20'),
(20, 1, 'Watched', '2024-04-15'),
(20, 3, 'Watched', '2024-04-20'),
(20, 5, 'Watched', '2024-04-25'),
(20, 6, 'Watched', '2024-04-30'),
(20, 7, 'Watched', '2024-05-05'),
(20, 9, 'Watched', '2024-05-10'),
(20, 10, 'Watched', '2024-05-15'),
(20, 12, 'Watched', '2024-05-20');