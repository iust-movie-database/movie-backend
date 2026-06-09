CREATE OR REPLACE FUNCTION get_user_ratings(
    p_user_id BIGINT,
    p_limit INT DEFAULT 5,
    p_offset INT DEFAULT 0
)
RETURNS TABLE (
    title_id BIGINT,
    title_name_fa VARCHAR,
    title_name_en VARCHAR,
    poster_url VARCHAR,
    rating_score INT,
    rating_date DATE,
    review_text TEXT,
    is_spoiler BOOLEAN,
    t_type CHAR(1)
) AS $$
BEGIN
    RETURN QUERY
        SELECT t.title_id, t.name_fa, t.name_en, t.poster_url,
               r.score, r.review_date, r.comment, r.is_spoiler,
               t.t_type
        FROM review r
        JOIN title t USING(title_id)
        WHERE r.user_id = p_user_id
        ORDER BY r.review_date DESC
        LIMIT p_limit
        OFFSET p_offset;
END;
$$ LANGUAGE plpgsql;