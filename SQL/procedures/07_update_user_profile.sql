CREATE OR REPLACE PROCEDURE update_user_profile(
    p_user_id BIGINT,
    p_new_username VARCHAR DEFAULT NULL,
    p_new_email VARCHAR DEFAULT NULL,
    p_new_photo_url VARCHAR DEFAULT NULL,
    p_new_password_hash VARCHAR DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_stored_hash VARCHAR;
BEGIN
    -- Update user profile
    UPDATE users
    SET username = COALESCE(p_new_username, username),
        email = COALESCE(p_new_email, email),
        photo_url = COALESCE(p_new_photo_url, photo_url),
        password_hash = COALESCE(p_new_password_hash, password_hash)
    WHERE user_id = p_user_id;
    
    RAISE NOTICE 'Profile updated for user %', p_user_id;
END;
$$;