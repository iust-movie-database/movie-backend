CREATE OR REPLACE PROCEDURE remove_user(p_user_id BIGINT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Reviews and saved titles will be deleted via CASCADE foreign keys
    DELETE FROM users WHERE user_id = p_user_id;
    
    IF NOT FOUND THEN
        RAISE NOTICE 'User not found';
    END IF;
END;
$$;