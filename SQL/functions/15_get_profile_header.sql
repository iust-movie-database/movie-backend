CREATE OR REPLACE FUNCTION get_profile_header(p_user_id BIGINT)
RETURNS TABLE(
    username VARCHAR,
    join_date DATE,
    photo_url VARCHAR,
    email VARCHAR,
    total_rated INT,
    total_written INT,
    total_want_to_watch INT,
    total_watching INT,
    total_watched INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT u.username, u.join_date, u.photo_url, u.email,
           (SELECT COUNT(*) FROM review r WHERE r.user_id = p_user_id AND r.score IS NOT NULL) AS total_rated,
           (SELECT COUNT(*) FROM review r WHERE r.user_id = p_user_id AND r.review_text IS NOT NULL AND r.review_text != '') AS total_written,
           (SELECT COUNT(*) FROM saved sv WHERE sv.user_id = p_user_id AND sv.status = 'Want to Watch') AS total_want_to_watch,
           (SELECT COUNT(*) FROM saved sv WHERE sv.user_id = p_user_id AND sv.status = 'Watching') AS total_watching,
           (SELECT COUNT(*) FROM saved sv WHERE sv.user_id = p_user_id AND sv.status = 'Watched') AS total_watched
    FROM users u
    WHERE u.user_id = p_user_id;
END;
$$ LANGUAGE plpgsql;