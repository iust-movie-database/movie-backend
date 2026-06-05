CREATE OR REPLACE FUNCTION get_similar_titles(
    p_title_id BIGINT,
    p_user_id BIGINT DEFAULT NULL,
    p_limit INT DEFAULT 10
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
    duration_mins INT,
    total_seasons INT,
    total_episodes INT,
    similarity_score INT,
    is_saved BOOLEAN
) AS $$
BEGIN
    RETURN QUERY
    SELECT st.similar_id,
           t.t_type, t.score, t.age_rating,
           t.name_fa, t.name_en, t.poster_url,
           STRING_AGG(DISTINCT g.name_fa, ', ') as genres,
           EXTRACT(YEAR FROM t.release_date)::INT,
           t.duration_mins,
           s.total_seasons, s.total_episodes,
           st.score as similarity_score,
           CASE WHEN p_user_id IS NOT NULL AND EXISTS (
               SELECT 1 FROM saved sv 
               WHERE sv.user_id = p_user_id AND sv.title_id = st.similar_id
           ) THEN TRUE ELSE FALSE END as is_saved
    FROM similar_to st
    JOIN title t ON st.similar_id = t.title_id
    LEFT JOIN series s ON t.title_id = s.title_id
    LEFT JOIN has_genre hg ON t.title_id = hg.title_id
    LEFT JOIN genre g ON hg.genre_id = g.genre_id
    WHERE st.title_id = p_title_id
    GROUP BY st.similar_id, t.title_id, s.total_seasons, s.total_episodes, st.score
    ORDER BY st.score DESC
    LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;