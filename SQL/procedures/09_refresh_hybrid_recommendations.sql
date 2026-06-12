CREATE OR REPLACE PROCEDURE refresh_hybrid_recommendations()
LANGUAGE plpgsql
AS $$
DECLARE
    v_user RECORD;
    v_count INT := 0;
BEGIN
    -- Clear all recommendations first
    DELETE FROM recommended;
    
    -- Refresh recommendations for each user one by one
    FOR v_user IN SELECT user_id FROM users
    LOOP
        CALL refresh_user_recommendations(v_user.user_id);
        v_count := v_count + 1;
    END LOOP;
    
    RAISE NOTICE 'Refreshed recommendations for all % users', v_count;
END;
$$;