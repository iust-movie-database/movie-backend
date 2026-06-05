CREATE OR REPLACE FUNCTION get_recommendations(
    p_user_id BIGINT DEFAULT NULL,
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
    genres VARCHAR,
    release_year INT,
    -- Movie fields
    duration_mins INT,
    -- Series fields
    total_seasons INT,
    total_episodes INT,
    end_year INT,
    is_saved BOOLEAN
) AS $$
BEGIN
    RETURN QUERY
        SELECT t.title_id, t.t_type, t.score, t.age_rating,
               t.name_fa, t.name_en, t.poster_url,
               STRING_AGG(g.name_fa, ', ') as genres,
               EXTRACT(YEAR FROM t.release_date)::INT as release_year,
               t.duration_mins,
               s.total_seasons, s.total_episodes, EXTRACT(YEAR FROM s.end_date)::INT,
               CASE WHEN p_user_id IS NOT NULL AND EXISTS(
                    SELECT 1 FROM saved sv
                    WHERE sv.user_id = p_user_id AND
                          sv.title_id = t.title_id
               ) THEN TRUE ELSE FALSE END AS is_saved
        FROM recommended r
        JOIN title t USING(title_id)
        LEFT JOIN series s ON t.title_id = s.title_id
        LEFT JOIN has_genre hg USING(title_id)
        LEFT JOIN genre g USING(genre_id)
        WHERE r.user_id = p_user_id
          AND t.title_id NOT IN (
              SELECT review.title_id FROM review WHERE review.user_id = p_user_id
          )
          AND t.title_id NOT IN (
              SELECT s.title_id FROM saved s 
              WHERE s.user_id = p_user_id 
              AND s.status IN ('Watched', 'Watching')
          )
        GROUP BY t.title_id, s.total_seasons, s.total_episodes, s.end_date, r.score
        ORDER BY r.score DESC
        LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;