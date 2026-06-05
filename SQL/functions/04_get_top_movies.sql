CREATE OR REPLACE FUNCTION get_top_movies(p_limit INT DEFAULT 5)
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
    duration_mins INT
) AS $$
BEGIN
    RETURN QUERY
        SELECT t.title_id, t.t_type, t.score, t.age_rating,
               t.name_fa, t.name_en, t.poster_url,
               STRING_AGG(g.name_fa, ', ') AS genres,
               EXTRACT(YEAR FROM t.release_date) AS release_year,
               t.duration_mins
        FROM title t
        LEFT JOIN has_genre hg USING(title_id)
        LEFT JOIN genre g USING(genre_id)
        WHERE t.vote_count > 1000 
          AND t.t_type = 'M' 
          AND t.score IS NOT NULL
        GROUP BY t.title_id
        ORDER BY t.score DESC, t.vote_count DESC
        LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;