-- =====================================================
-- SIMILAR_TO DATA (Movie/Series Recommendations)
-- =====================================================

-- Based on: INCEPTION (title_id = 1)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(1, 2, '2024-01-15', 85),   -- The Dark Knight (same director, mind-bending)
(1, 5, '2024-01-15', 90),   -- The Matrix (mind-bending reality)
(1, 9, '2024-01-15', 88),   -- Oppenheimer (same director)
(1, 10, '2024-01-15', 75),  -- The Social Network (intelligent thriller)
(1, 13, '2024-01-15', 70);  -- Stranger Things (sci-fi mystery)

-- Based on: THE DARK KNIGHT (title_id = 2)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(2, 1, '2024-01-15', 85),   -- Inception (same director)
(2, 3, '2024-01-15', 80),   -- Pulp Fiction (crime drama)
(2, 5, '2024-01-15', 75),   -- The Matrix (action hero)
(2, 7, '2024-01-15', 82),   -- Gladiator (revenge story)
(2, 11, '2024-01-15', 88);  -- Game of Thrones (dark political drama)

-- Based on: PULP FICTION (title_id = 3)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(3, 2, '2024-01-15', 80),   -- The Dark Knight (crime drama)
(3, 4, '2024-01-15', 65),   -- Forrest Gump (cult classic)
(3, 7, '2024-01-15', 75),   -- Gladiator (violent drama)
(3, 10, '2024-01-15', 70),  -- The Social Network (sharp dialogue)
(3, 12, '2024-01-15', 85);  -- Breaking Bad (crime transformation)

-- Based on: FORREST GUMP (title_id = 4)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(4, 3, '2024-01-15', 65),   -- Pulp Fiction (90s classic)
(4, 6, '2024-01-15', 80),   -- Titanic (emotional drama)
(4, 7, '2024-01-15', 70),   -- Gladiator (inspirational story)
(4, 8, '2024-01-15', 75),   -- Parasite (social commentary)
(4, 14, '2024-01-15', 72);  -- The Crown (historical drama)

-- Based on: THE MATRIX (title_id = 5)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(5, 1, '2024-01-15', 90),   -- Inception (reality bending)
(5, 2, '2024-01-15', 75),   -- The Dark Knight (action hero)
(5, 9, '2024-01-15', 70),   -- Oppenheimer (philosophical)
(5, 13, '2024-01-15', 80),  -- Stranger Things (sci-fi mystery)
(5, 18, '2024-01-15', 78);  -- The Mandalorian (sci-fi adventure)

-- Based on: TITANIC (title_id = 6)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(6, 4, '2024-01-15', 80),   -- Forrest Gump (emotional drama)
(6, 7, '2024-01-15', 75),   -- Gladiator (epic romance)
(6, 8, '2024-01-15', 65),   -- Parasite (class struggle)
(6, 11, '2024-01-15', 70),  -- Game of Thrones (epic scale)
(6, 14, '2024-01-15', 78);  -- The Crown (historical romance)

-- Based on: GLADIATOR (title_id = 7)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(7, 2, '2024-01-15', 82),   -- The Dark Knight (revenge story)
(7, 3, '2024-01-15', 75),   -- Pulp Fiction (violent drama)
(7, 4, '2024-01-15', 70),   -- Forrest Gump (inspirational)
(7, 6, '2024-01-15', 75),   -- Titanic (epic romance)
(7, 11, '2024-01-15', 85);  -- Game of Thrones (epic battle scenes)

-- Based on: PARASITE (title_id = 8)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(8, 4, '2024-01-15', 75),   -- Forrest Gump (social commentary)
(8, 6, '2024-01-15', 65),   -- Titanic (class divide)
(8, 10, '2024-01-15', 70),  -- The Social Network (betrayal)
(8, 12, '2024-01-15', 80),  -- Breaking Bad (moral decline)
(8, 15, '2024-01-15', 85);  -- Succession (family power struggle)

-- Based on: OPPENHEIMER (title_id = 9)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(9, 1, '2024-01-15', 88),   -- Inception (same director)
(9, 2, '2024-01-15', 85),   -- The Dark Knight (same director)
(9, 5, '2024-01-15', 70),   -- The Matrix (philosophical)
(9, 10, '2024-01-15', 75),  -- The Social Network (biopic)
(9, 14, '2024-01-15', 80);  -- The Crown (historical figure)

-- Based on: THE SOCIAL NETWORK (title_id = 10)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(10, 1, '2024-01-15', 75),  -- Inception (intelligent)
(10, 3, '2024-01-15', 70),  -- Pulp Fiction (sharp dialogue)
(10, 8, '2024-01-15', 70),  -- Parasite (betrayal)
(10, 9, '2024-01-15', 75),  -- Oppenheimer (biopic)
(10, 15, '2024-01-15', 85); -- Succession (corporate power)

-- Based on: GAME OF THRONES (title_id = 11)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(11, 2, '2024-01-15', 88),  -- The Dark Knight (dark themes)
(11, 7, '2024-01-15', 85),  -- Gladiator (epic battles)
(11, 12, '2024-01-15', 80), -- Breaking Bad (character arcs)
(11, 17, '2024-01-15', 75), -- Westworld (complex narrative)
(11, 19, '2024-01-15', 95); -- House of the Dragon (same universe)

-- Based on: BREAKING BAD (title_id = 12)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(12, 3, '2024-01-15', 85),  -- Pulp Fiction (crime drama)
(12, 8, '2024-01-15', 80),  -- Parasite (moral decline)
(12, 11, '2024-01-15', 80), -- Game of Thrones (character transformation)
(12, 15, '2024-01-15', 90), -- Succession (power struggle)
(12, 16, '2024-01-15', 75); -- Dark (complex storytelling)

-- Based on: STRANGER THINGS (title_id = 13)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(13, 1, '2024-01-15', 70),  -- Inception (sci-fi mystery)
(13, 5, '2024-01-15', 80),  -- The Matrix (alternate reality)
(13, 11, '2024-01-15', 75), -- Game of Thrones (ensemble cast)
(13, 16, '2024-01-15', 85), -- Dark (sci-fi mystery)
(13, 18, '2024-01-15', 72); -- The Mandalorian (adventure)

-- Based on: THE CROWN (title_id = 14)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(14, 4, '2024-01-15', 72),  -- Forrest Gump (historical)
(14, 6, '2024-01-15', 78),  -- Titanic (historical romance)
(14, 9, '2024-01-15', 80),  -- Oppenheimer (historical biopic)
(14, 10, '2024-01-15', 75), -- The Social Network (power)
(14, 15, '2024-01-15', 70); -- Succession (family drama)

-- Based on: SUCCESSION (title_id = 15)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(15, 8, '2024-01-15', 85),  -- Parasite (class warfare)
(15, 10, '2024-01-15', 85), -- The Social Network (betrayal)
(15, 11, '2024-01-15', 80), -- Game of Thrones (power struggle)
(15, 12, '2024-01-15', 90), -- Breaking Bad (moral decay)
(15, 14, '2024-01-15', 70); -- The Crown (family drama)

-- Based on: DARK (title_id = 16)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(16, 1, '2024-01-15', 85),  -- Inception (time manipulation)
(16, 5, '2024-01-15', 80),  -- The Matrix (reality bending)
(16, 11, '2024-01-15', 75), -- Game of Thrones (complex plot)
(16, 13, '2024-01-15', 85), -- Stranger Things (sci-fi mystery)
(16, 17, '2024-01-15', 78); -- Westworld (philosophical sci-fi)

-- Based on: WESTWORLD (title_id = 17)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(17, 1, '2024-01-15', 82),  -- Inception (reality vs illusion)
(17, 5, '2024-01-15', 85),  -- The Matrix (AI consciousness)
(17, 11, '2024-01-15', 75), -- Game of Thrones (complex narrative)
(17, 16, '2024-01-15', 78), -- Dark (philosophical)
(17, 18, '2024-01-15', 70); -- The Mandalorian (sci-fi western)

-- Based on: THE MANDALORIAN (title_id = 18)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(18, 5, '2024-01-15', 78),  -- The Matrix (sci-fi)
(18, 7, '2024-01-15', 75),  -- Gladiator (lone warrior)
(18, 11, '2024-01-15', 80), -- Game of Thrones (fantasy adventure)
(18, 13, '2024-01-15', 72), -- Stranger Things (adventure)
(18, 17, '2024-01-15', 70); -- Westworld (sci-fi western)

-- Based on: HOUSE OF THE DRAGON (title_id = 19)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(19, 2, '2024-01-15', 75),  -- The Dark Knight (dark themes)
(19, 7, '2024-01-15', 80),  -- Gladiator (epic battles)
(19, 11, '2024-01-15', 95), -- Game of Thrones (same universe)
(19, 12, '2024-01-15', 70), -- Breaking Bad (character drama)
(19, 15, '2024-01-15', 78); -- Succession (family war)

-- Based on: THE LAST OF US (title_id = 20)
INSERT INTO similar_to (title_id, similar_id, simil_date, score) VALUES
(20, 5, '2024-01-15', 75),  -- The Matrix (post-apocalyptic)
(20, 7, '2024-01-15', 72),  -- Gladiator (survival)
(20, 11, '2024-01-15', 80), -- Game of Thrones (character driven)
(20, 12, '2024-01-15', 85), -- Breaking Bad (moral complexity)
(20, 13, '2024-01-15', 78); -- Stranger Things (emotional bonds);