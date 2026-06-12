CREATE OR REPLACE PROCEDURE register_user(
    p_username VARCHAR,
    p_email VARCHAR,
    p_password_hash VARCHAR,
    p_photo_url VARCHAR DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_user_id BIGINT;
BEGIN
    INSERT INTO users (username, email, password_hash, photo_url, join_date)
    VALUES (p_username, p_email, p_password_hash, p_photo_url, CURRENT_DATE)
    RETURNING user_id INTO v_user_id;
    
    -- Generate initial recommendations for new user
    CALL refresh_user_recommendations(v_user_id);
    
    RAISE NOTICE 'User registered with ID: %', v_user_id;
END;
$$;