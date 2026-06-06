CREATE OR REPLACE PROCEDURE register_user(
    p_username VARCHAR,
    p_email VARCHAR,
    p_password_hash VARCHAR,
    p_photo_url VARCHAR DEFAULT NULL
)
AS $$
BEGIN
    INSERT INTO users (username, email, password_hash, photo_url, join_date)
    VALUES (p_username, p_email, p_password_hash, p_photo_url, CURRENT_DATE);
END;
$$ LANGUAGE plpgsql;