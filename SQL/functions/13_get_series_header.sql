CREATE OR REPLACE FUNCTION get_series_header(
    p_title_id BIGINT,
    p_user_id BIGINT DEFAULT NULL
)
RETURNS TABLE (
    title_id BIGINT,
    name_fa VARCHAR,
    name_en VARCHAR,
    poster_url VARCHAR,
    score DECIMAL,
    vote_count INT,
    release_date DATE,
    end_date DATE,
    age_rating VARCHAR,
    episode_duration INT,
    genres TEXT,
    summary TEXT,
    total_seasons INT,
    total_episodes INT,
    is_saved BOOLEAN
) AS $$
BEGIN
    RETURN QUERY
    SELECT t.title_id, t.name_fa, t.name_en, t.poster_url,
           t.score, t.vote_count,
           t.release_date, s.end_date,
           t.age_rating, t.duration_mins AS episode_duration,
           STRING_AGG(DISTINCT g.name_fa, ', ') as genres,
           t.summary,
           s.total_seasons, s.total_episodes,
           CASE WHEN p_user_id IS NOT NULL AND EXISTS (
               SELECT 1 FROM saved sv 
               WHERE sv.user_id = p_user_id AND sv.title_id = t.title_id
           ) THEN TRUE ELSE FALSE END as is_saved
    FROM title t
    JOIN series s USING(title_id)
    LEFT JOIN has_genre hg USING(title_id)
    LEFT JOIN genre g USING(genre_id)
    WHERE t.title_id = p_title_id
    GROUP BY t.title_id, s.end_date, s.total_seasons, s.total_episodes;
END;
$$ LANGUAGE plpgsql;