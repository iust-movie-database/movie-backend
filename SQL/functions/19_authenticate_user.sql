CREATE OR REPLACE FUNCTION authenticate_user(
    p_email VARCHAR,
    p_password_hash VARCHAR
)
RETURNS TABLE (
    user_id BIGINT,
    username VARCHAR,
    email VARCHAR,
    photo_url VARCHAR,
    is_admin BOOLEAN
) AS $$
BEGIN
    RETURN QUERY
    SELECT u.user_id, u.username, u.email, u.photo_url, u.is_admin
    FROM users u
    WHERE u.email = p_email AND u.password_hash = p_password_hash;
END;
$$ LANGUAGE plpgsql;