CREATE OR REPLACE PROCEDURE remove_user_with_verification(
    p_user_id BIGINT,
    p_password_hash VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_stored_hash VARCHAR;
BEGIN
    -- Get stored password hash
    SELECT password_hash INTO v_stored_hash
    FROM users
    WHERE user_id = p_user_id;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'User not found';
    END IF;
    
    -- Compare hashes (the hash passed from FastAPI is already hashed)
    IF v_stored_hash != p_password_hash THEN
        RAISE EXCEPTION 'Incorrect password';
    END IF;
    
    -- Delete user (cascade deletes reviews and saved items)
    DELETE FROM users WHERE user_id = p_user_id;
END;
$$;