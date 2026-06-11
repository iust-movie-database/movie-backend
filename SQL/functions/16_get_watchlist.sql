CREATE OR REPLACE FUNCTION get_user_watchlist(
    p_user_id BIGINT,
    p_status VARCHAR DEFAULT NULL,
    p_limit INT DEFAULT 10,
    p_offset INT DEFAULT 0
)
RETURNS TABLE (
    title_id BIGINT,
    t_type CHAR(1),
    score DECIMAL,
    age_rating VARCHAR,
    name_fa VARCHAR,
    name_en VARCHAR,
    poster_url VARCHAR,
    genres TEXT,
    release_year NUMERIC,
    duration_mins INT,
    total_seasons INT,
    total_episodes INT,
    status VARCHAR
) AS $$
BEGIN
    RETURN QUERY
        SELECT t.title_id, t.t_type, t.score, t.age_rating,
               t.name_fa, t.name_en, t.poster_url,
               STRING_AGG(DISTINCT g.name_fa, ', ') AS genres,
               EXTRACT(YEAR FROM t.release_date) AS release_year,
               t.duration_mins,
               s.total_seasons, s.total_episodes,
               sv.status
        FROM saved sv
        JOIN title t USING(title_id)
        LEFT JOIN series s USING(title_id)
        LEFT JOIN has_genre hg USING(title_id)
        LEFT JOIN genre g USING(genre_id)
        WHERE sv.user_id = p_user_id
          AND (p_status IS NULL OR sv.status = p_status)
        GROUP BY t.title_id, s.total_seasons, s.total_episodes, sv.status, sv.added_date
        ORDER BY sv.added_date DESC
        LIMIT p_limit
        OFFSET p_offset;
END;
$$ LANGUAGE plpgsql;