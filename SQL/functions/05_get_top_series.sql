CREATE OR REPLACE FUNCTION get_top_series(
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
    genres TEXT,
    release_year NUMERIC,
    end_year NUMERIC,
    total_episodes INT,
	is_saved BOOLEAN
) AS $$
BEGIN
    RETURN QUERY
        SELECT t.title_id, t.t_type, t.score, t.age_rating,
               t.name_fa, t.name_en, t.poster_url,
               STRING_AGG(g.name_fa, ', ') AS genres,
               EXTRACT(YEAR FROM t.release_date) AS release_year,
               EXTRACT(YEAR FROM s.end_date) AS end_year,
               s.total_episodes,
			   CASE WHEN p_user_id IS NOT NULL AND EXISTS(
					SELECT 1 FROM saved sv
					WHERE sv.user_id = p_user_id AND
						  sv.title_id = t.title_id
			   ) THEN TRUE ELSE FALSE END AS is_saved
        FROM title t
        JOIN series s USING(title_id)
        LEFT JOIN has_genre hg USING(title_id)
        LEFT JOIN genre g USING(genre_id)
        WHERE t.vote_count > 5
          AND t.t_type = 'S'
          AND t.score IS NOT NULL
        GROUP BY t.title_id, end_year, s.total_episodes
        ORDER BY t.score DESC, t.vote_count DESC
        LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;