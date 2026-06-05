CREATE OR REPLACE FUNCTION get_title_reviews(p_title_id BIGINT, p_limit INT DEFAULT 10)
RETURNS TABLE (
    user_id BIGINT,
    username VARCHAR,
    user_photo VARCHAR,
    review_date DATE,
    comment TEXT,
    score INT,
    is_spoiler BOOLEAN
) AS $$
BEGIN
    RETURN QUERY
    SELECT u.user_id, u.username, u.photo_url,
           r.review_date, r.comment, r.score, r.is_spoiler
    FROM review r
    JOIN users u USING(user_id)
    WHERE r.title_id = p_title_id
    ORDER BY r.review_date DESC
    LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;