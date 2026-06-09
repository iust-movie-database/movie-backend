CREATE OR REPLACE FUNCTION get_user_by_email(p_email VARCHAR)
RETURNS TABLE (
    user_id BIGINT,
    username VARCHAR,
    email VARCHAR,
    password_hash VARCHAR,
    join_date DATE
) AS $$
BEGIN
    RETURN QUERY
    SELECT u.user_id, u.username, u.email, u.password_hash, u.join_date
    FROM users u
    WHERE u.email = p_email;
END;
$$ LANGUAGE plpgsql;