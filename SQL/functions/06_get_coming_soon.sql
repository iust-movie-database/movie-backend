CREATE OR REPLACE FUNCTION get_coming_soon(
    p_user_id BIGINT DEFAULT NULL,
    p_limit INT DEFAULT 5
)
RETURNS TABLE (
    title_id BIGINT,
    t_type CHAR(1),
    age_rating VARCHAR,
    name_fa VARCHAR,
    name_en VARCHAR,
    poster_url VARCHAR,
    genres TEXT,
    release_year NUMERIC,
    duration_mins INT,
    total_seasons INT,
    total_episodes INT,
    is_saved BOOLEAN
) AS $$
BEGIN
    RETURN QUERY
        SELECT t.title_id, t.t_type, t.age_rating,
               t.name_fa, t.name_en, t.poster_url,
               STRING_AGG(g.name_fa, ', ') AS genres,
               EXTRACT(YEAR FROM t.release_date) AS release_year,
               t.duration_mins,
               s.total_seasons, s.total_episodes,
               CASE WHEN p_user_id IS NOT NULL AND EXISTS (
                   SELECT 1 FROM saved sv 
                   WHERE sv.user_id = p_user_id AND sv.title_id = t.title_id
               ) THEN TRUE ELSE FALSE END as is_saved
        FROM title t
        LEFT JOIN series s ON t.title_id = s.title_id  -- Changed to LEFT JOIN
        LEFT JOIN has_genre hg ON t.title_id = hg.title_id  -- Fixed JOIN condition
        LEFT JOIN genre g ON hg.genre_id = g.genre_id
        WHERE t.release_date >= CURRENT_DATE
        GROUP BY t.title_id, s.total_seasons, s.total_episodes
        ORDER BY t.release_date ASC
        LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;