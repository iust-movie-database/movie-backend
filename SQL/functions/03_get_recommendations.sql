CREATE OR REPLACE FUNCTION get_recommendations(
    p_user_id BIGINT,
    p_limit INT DEFAULT 5
)
RETURNS TABLE (
    title_id BIGINT,
    t_type CHAR(1),
    score DECIMAL,
    age_rating VARCHAR,
    name_fa VARCHAR,
    name_en VARCHAR,
    poster_url VARCHAR,
    genres TEXT,  -- Changed from VARCHAR to TEXT
    release_year INT,
    duration_mins INT,
    total_seasons INT,
    total_episodes INT,
    end_year INT,
    is_saved BOOLEAN
) AS $$
BEGIN
    RETURN QUERY
        SELECT t.title_id, t.t_type, t.score, t.age_rating,
               t.name_fa, t.name_en, t.poster_url,
               STRING_AGG(DISTINCT g.name_fa, ', ') as genres,  -- No cast needed
               EXTRACT(YEAR FROM t.release_date)::INT as release_year,
               t.duration_mins,
               s.total_seasons, s.total_episodes, EXTRACT(YEAR FROM s.end_date)::INT,
               CASE WHEN p_user_id IS NOT NULL AND EXISTS(
                    SELECT 1 FROM saved sv
                    WHERE sv.user_id = p_user_id AND
                          sv.title_id = t.title_id
               ) THEN TRUE ELSE FALSE END AS is_saved
        FROM recommended r
        JOIN title t ON r.title_id = t.title_id
        LEFT JOIN series s ON t.title_id = s.title_id
        LEFT JOIN has_genre hg ON t.title_id = hg.title_id
        LEFT JOIN genre g ON hg.genre_id = g.genre_id
        WHERE r.user_id = p_user_id
        --   AND t.title_id NOT IN (
        --       SELECT review.title_id FROM review WHERE review.user_id = p_user_id
        --   )
        --   AND t.title_id NOT IN (
        --       SELECT s2.title_id FROM saved s2 
        --       WHERE s2.user_id = p_user_id 
        --       AND s2.status IN ('Watched', 'Watching')
        --   )
        GROUP BY t.title_id, s.total_seasons, s.total_episodes, s.end_date, r.score
        ORDER BY r.score DESC
        LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;