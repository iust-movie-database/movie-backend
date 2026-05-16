-- =====================================================
-- 1.Query: PLOT SUMMARY
-- =====================================================
SELECT 
    t.title_id,
    t.name AS series_name,
    t.name_en AS series_name_en,
    t.summary AS storyline,
    t.release_date,
    EXTRACT(YEAR FROM t.release_date) AS premiere_year,
    t.status,
    t.age_rating,
    t.score AS average_rating,
    t.vote_count,
    s.total_seasons,
    s.total_episodes,
    s.end_year,
    CASE 
        WHEN t.status = 'Ongoing' THEN 'Currently Airing'
        WHEN s.end_year IS NOT NULL AND s.end_year <= EXTRACT(YEAR FROM CURRENT_DATE) THEN 'Completed'
        WHEN s.end_year IS NULL AND t.status = 'Released' THEN 'Completed'
        ELSE 'Status Unknown'
    END AS series_completion_status
FROM 
    Title t
    INNER JOIN Series s ON t.title_id = s.title_id
WHERE 
    t.ttype = 'S'
    AND t.title_id = 1;  -- Replace with actual series ID

-- =====================================================
-- 2.Query: CAST & CREW
-- =====================================================
SELECT 
    p.person_id,
    p.name AS actor_name,
    p.name_en AS actor_name_en,
    cm.char_name,
    cm.char_name_en,
    cm.ordering,
    'Main Cast' AS role_category
FROM 
    Cast_Member cm
    JOIN Person p ON cm.person_id = p.person_id
    JOIN Title t ON cm.title_id = t.title_id
WHERE 
    cm.title_id = 19  -- Replace with actual series ID
    AND t.ttype = 'S'
    AND cm.ordering <= 10
ORDER BY 
    cm.ordering;

-- =====================================================
-- 3.Query: SEASONS & EPISODES LIST
-- =====================================================
SELECT 
    s.season_number,
    s.episodes_count,
    s.release_date,
    EXTRACT(YEAR FROM s.release_date) AS year_aired
FROM 
    Season s
    INNER JOIN Title t ON s.title_id = t.title_id
WHERE 
    s.title_id = 1  -- Replace with actual series ID
    AND t.ttype = 'S'
ORDER BY 
    s.season_number;