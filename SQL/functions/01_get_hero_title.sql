CREATE OR REPLACE FUNCTION get_hero_title()
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
    end_year INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT t.title_id, t.name_fa, t.name_en, t.poster_url,
           STRING_AGG(g.name_fa, ', ') as genres,
           t.score, EXTRACT(YEAR FROM t.release_date)::INT, 
           t.age_rating, t.summary, t.t_type,
           t.duration_mins,
           s.total_seasons, s.total_episodes, EXTRACT(YEAR FROM s.end_date)::INT
    FROM title t
    LEFT JOIN has_genre hg ON t.title_id = hg.title_id
    LEFT JOIN genre g ON hg.genre_id = g.genre_id
    LEFT JOIN series s ON t.title_id = s.title_id
    WHERE t.score IS NOT NULL
        AND t.vote_count > 1000
        AND t.release_date >= CURRENT_DATE - INTERVAL '12 months'
    GROUP BY t.title_id, s.total_seasons, s.total_episodes, s.end_date
    ORDER BY t.score DESC, t.vote_count DESC
    LIMIT 1;
END;
$$ LANGUAGE plpgsql;