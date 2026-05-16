-- =====================================================
-- 1.Query: PLOT SUMMARY
-- =====================================================
SELECT 
    t.title_id,
    t.name AS title_name,
    t.name_en AS title_name_en,
    t.summary AS storyline,
    t.release_date,
    t.duration,
    t.age_rating,
    t.score AS user_rating,
    t.vote_count
FROM 
    Title t
WHERE 
    t.ttype = 'M'
    AND t.title_id = 1;  -- Replace with actual movie ID

-- =====================================================
-- 2.Query: GENRE TAGS
-- =====================================================
SELECT 
    g.genre_id,
    g.name AS genre_name,
    g.name_en AS genre_name_en,
    g.description
FROM 
    Genre g
    INNER JOIN Has_Genre hg ON g.genre_id = hg.genre_id
WHERE 
    hg.title_id = 1  -- Replace with actual movie/TV ID
ORDER BY 
    g.name;

-- =====================================================
-- 3.Query: CAST & CREW
-- =====================================================
SELECT 
    p.person_id,
    p.name AS actor_name,
    p.name_en AS actor_name_en,
    cm.char_name,
    cm.char_name_en,
    cm.ordering,
    NULL AS profile_photo
FROM 
    Cast_Member cm
    JOIN Person p ON cm.person_id = p.person_id
WHERE 
    cm.title_id = 1  -- Replace with actual movie/TV ID
ORDER BY 
    cm.ordering NULLS LAST,
    p.name;

-- =====================================================
-- 4.Query: AWARDS
-- =====================================================
SELECT 
    a.award_id,
    a.name AS award_name,
    a.category,
    a.ceremony_date,
    EXTRACT(YEAR FROM a.ceremony_date) AS year,
    a.type,
    CASE 
        WHEN a.type = 'T' THEN 'Won'
        WHEN a.type IN ('C', 'W') THEN 'Nominated'
        ELSE 'Unknown'
    END AS result
FROM 
    Award a
WHERE 
    a.title_id = 1  -- Replace with actual movie/TV ID
ORDER BY 
    a.ceremony_date DESC,
    a.category;
