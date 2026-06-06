CREATE OR REPLACE PROCEDURE update_user_profile(
    p_user_id BIGINT,
    p_username VARCHAR DEFAULT NULL,
    p_photo_url VARCHAR DEFAULT NULL,
    p_password_hash VARCHAR DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE users
    SET username = COALESCE(p_username, username),
        photo_url = COALESCE(p_photo_url, photo_url),
        password_hash = COALESCE(p_password_hash, password_hash)
    WHERE user_id = p_user_id;
END;
$$;