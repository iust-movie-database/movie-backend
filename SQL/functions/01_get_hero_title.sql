CREATE OR REPLACE FUNCTION get_hero_title(
    p_user_id BIGINT DEFAULT NULL,
    p_limit BIGINT DEFAULT 1
)
RETURNS TABLE(
    id BIGINT,
    name_fa VARCHAR,
    name_en VARCHAR,
    poster_url VARCHAR,
    genres TEXT,
    score DECIMAL,
    release_year INT,
    age_rating VARCHAR,
    summary TEXT,
    t_type CHAR(1),
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
    SELECT t.title_id, t.name_fa, t.name_en, t.poster_url,
           STRING_AGG(g.name_fa, ', ') as genres,
           t.score, EXTRACT(YEAR FROM t.release_date)::INT, 
           t.age_rating, t.summary, t.t_type,
           t.duration_mins,
           s.total_seasons, s.total_episodes, EXTRACT(YEAR FROM s.end_date)::INT
           CASE WHEN p_user_id IS NOT NULL AND EXISTS(
                SELECT 1 FROM saved sv
                WHERE sv.user_is = p_user_id AND
                      sv.title_id = t.title_id
           ) THEN TRUE ELSE FALSE END AS is_saved
           
    FROM title t
    LEFT JOIN has_genre hg ON t.title_id = hg.title_id
    LEFT JOIN genre g ON hg.genre_id = g.genre_id
    LEFT JOIN series s ON t.title_id = s.title_id
    WHERE t.score IS NOT NULL
        AND t.vote_count > 1000
        AND t.release_date >= CURRENT_DATE - INTERVAL '12 months'
    GROUP BY t.title_id, s.total_seasons, s.total_episodes, s.end_date
    ORDER BY t.score DESC, t.vote_count DESC
    LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;