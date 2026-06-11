CREATE OR REPLACE FUNCTION get_content_recommendations(
    p_user_id BIGINT,
    p_limit INT DEFAULT 20
)
RETURNS TABLE (
    rec_title_id BIGINT,
    title_name VARCHAR,
    content_score DECIMAL(5,2),
    genre_jaccard DECIMAL(4,2),
    director_jaccard DECIMAL(4,2),
    actor_jaccard DECIMAL(4,2),
    year_similarity DECIMAL(4,2),
    rating_similarity DECIMAL(4,2)
) AS $$
DECLARE
    v_user_genres INT[];
    v_user_directors INT[];
    v_user_actors INT[];
    v_user_avg_year DECIMAL;
    v_user_avg_score DECIMAL;
    v_rating_count INT;
BEGIN
    -- Get user's rating count
    SELECT COUNT(*) INTO v_rating_count
    FROM review WHERE user_id = p_user_id AND score >= 7;
    
    -- Cold start: less than 3 ratings
    IF v_rating_count < 3 THEN
        RETURN QUERY
        SELECT 
            t.title_id,
            t.name_en AS title_name,
            (COALESCE(t.score, 0) * LOG(COALESCE(t.vote_count, 1) + 1) * 10)::DECIMAL(5,2) AS content_score,
            0::DECIMAL(4,2) AS genre_jaccard,
            0::DECIMAL(4,2) AS director_jaccard,
            0::DECIMAL(4,2) AS actor_jaccard,
            0::DECIMAL(4,2) AS year_similarity,
            0::DECIMAL(4,2) AS rating_similarity
        FROM title t
        WHERE t.title_id NOT IN (SELECT title_id FROM review WHERE user_id = p_user_id)
          AND t.title_id NOT IN (SELECT title_id FROM saved WHERE user_id = p_user_id)
          AND t.score IS NOT NULL
        ORDER BY content_score DESC
        LIMIT p_limit;
        RETURN;
    END IF;
    
    -- Build weighted user profile from highly rated titles (score >= 7)
    -- Genres
    SELECT ARRAY_AGG(DISTINCT hg.genre_id)
    INTO v_user_genres
    FROM review r
    JOIN title t ON r.title_id = t.title_id
    JOIN has_genre hg ON t.title_id = hg.title_id
    WHERE r.user_id = p_user_id AND r.score >= 7;
    
    -- Directors
    SELECT ARRAY_AGG(DISTINCT cm.person_id)
    INTO v_user_directors
    FROM review r
    JOIN title t ON r.title_id = t.title_id
    JOIN crew_member cm ON t.title_id = cm.title_id
    JOIN role rl ON cm.role_id = rl.role_id
    WHERE r.user_id = p_user_id AND r.score >= 7
      AND rl.name_en = 'Director';
    
    -- Lead actors (ordering <= 5)
    SELECT ARRAY_AGG(DISTINCT cm.person_id)
    INTO v_user_actors
    FROM review r
    JOIN title t ON r.title_id = t.title_id
    JOIN cast_member cm ON t.title_id = cm.title_id
    WHERE r.user_id = p_user_id AND r.score >= 7
      AND cm.ordering <= 5;
    
    -- Weighted average year
    SELECT 
        SUM(EXTRACT(YEAR FROM t.release_date) * ((r.score - 6) / 4.0)) / NULLIF(SUM((r.score - 6) / 4.0), 0)
    INTO v_user_avg_year
    FROM review r
    JOIN title t ON r.title_id = t.title_id
    WHERE r.user_id = p_user_id AND r.score >= 7;
    
    -- Weighted average score
    SELECT 
        SUM(r.score * ((r.score - 6) / 4.0)) / NULLIF(SUM((r.score - 6) / 4.0), 0)
    INTO v_user_avg_score
    FROM review r
    WHERE r.user_id = p_user_id AND r.score >= 7;
    
    -- Calculate recommendations
    RETURN QUERY
    WITH candidate_titles AS (
        SELECT DISTINCT t.title_id, t.name_en, t.release_date, t.score
        FROM title t
        WHERE t.title_id NOT IN (SELECT title_id FROM review WHERE user_id = p_user_id)
          AND t.title_id NOT IN (SELECT title_id FROM saved WHERE user_id = p_user_id)
    ),
    genre_jaccard AS (
        SELECT 
            ct.title_id,
            COUNT(DISTINCT hg1.genre_id)::DECIMAL / NULLIF(COUNT(DISTINCT hg2.genre_id), 0) AS jaccard
        FROM candidate_titles ct
        LEFT JOIN has_genre hg1 ON ct.title_id = hg1.title_id
        LEFT JOIN has_genre hg2 ON ct.title_id = hg2.title_id
        WHERE EXISTS (SELECT 1 FROM UNNEST(v_user_genres) AS g WHERE g = hg1.genre_id)
        GROUP BY ct.title_id
    ),
    director_jaccard AS (
        SELECT 
            ct.title_id,
            COUNT(DISTINCT cm1.person_id)::DECIMAL / NULLIF(COUNT(DISTINCT cm2.person_id), 0) AS jaccard
        FROM candidate_titles ct
        LEFT JOIN crew_member cm1 ON ct.title_id = cm1.title_id
        LEFT JOIN crew_member cm2 ON ct.title_id = cm2.title_id
        WHERE EXISTS (SELECT 1 FROM UNNEST(v_user_directors) AS d WHERE d = cm1.person_id)
        GROUP BY ct.title_id
    ),
    actor_jaccard AS (
        SELECT 
            ct.title_id,
            COUNT(DISTINCT cm1.person_id)::DECIMAL / NULLIF(COUNT(DISTINCT cm2.person_id), 0) AS jaccard
        FROM candidate_titles ct
        LEFT JOIN cast_member cm1 ON ct.title_id = cm1.title_id
        LEFT JOIN cast_member cm2 ON ct.title_id = cm2.title_id
        WHERE EXISTS (SELECT 1 FROM UNNEST(v_user_actors) AS a WHERE a = cm1.person_id)
        GROUP BY ct.title_id
    )
    SELECT 
        ct.title_id,
        ct.name_en AS title_name,
        (
            COALESCE(gj.jaccard, 0) * 40 +
            COALESCE(dj.jaccard, 0) * 25 +
            COALESCE(aj.jaccard, 0) * 20 +
            GREATEST(0, 1 - ABS(EXTRACT(YEAR FROM ct.release_date) - COALESCE(v_user_avg_year, 2000)) / 50) * 10 +
            GREATEST(0, 1 - ABS(COALESCE(ct.score, 0) - COALESCE(v_user_avg_score, 7)) / 10) * 5
        )::DECIMAL(5,2) AS content_score,
        COALESCE(gj.jaccard, 0)::DECIMAL(4,2) AS genre_jaccard,
        COALESCE(dj.jaccard, 0)::DECIMAL(4,2) AS director_jaccard,
        COALESCE(aj.jaccard, 0)::DECIMAL(4,2) AS actor_jaccard,
        GREATEST(0, 1 - ABS(EXTRACT(YEAR FROM ct.release_date) - COALESCE(v_user_avg_year, 2000)) / 50)::DECIMAL(4,2) AS year_similarity,
        GREATEST(0, 1 - ABS(COALESCE(ct.score, 0) - COALESCE(v_user_avg_score, 7)) / 10)::DECIMAL(4,2) AS rating_similarity
    FROM candidate_titles ct
    LEFT JOIN genre_jaccard gj ON ct.title_id = gj.title_id
    LEFT JOIN director_jaccard dj ON ct.title_id = dj.title_id
    LEFT JOIN actor_jaccard aj ON ct.title_id = aj.title_id
    WHERE ct.score IS NOT NULL
    ORDER BY content_score DESC
    LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;