CREATE OR REPLACE PROCEDURE refresh_hybrid_recommendations()
LANGUAGE plpgsql
AS $$
DECLARE
    v_user RECORD;
    v_rating_count INT;
    v_content_weight DECIMAL;
    v_collab_weight DECIMAL;
    v_user_count INT := 0;
BEGIN
    DELETE FROM recommended;
    
    FOR v_user IN SELECT user_id FROM users
    LOOP
        SELECT COUNT(*) INTO v_rating_count 
        FROM review WHERE user_id = v_user.user_id;
        
        -- Adjust weights based on rating count
        IF v_rating_count < 3 THEN
            v_content_weight := 1.0;
            v_collab_weight := 0.0;
        ELSIF v_rating_count < 10 THEN
            v_content_weight := 0.7;
            v_collab_weight := 0.3;
        ELSE
            v_content_weight := 0.4;
            v_collab_weight := 0.6;
        END IF;
        
        INSERT INTO recommended (user_id, title_id, score, recom_date)
        SELECT 
            v_user.user_id,
            rec_title_id,
            hybrid_score,
            CURRENT_DATE
        FROM get_hybrid_recommendations(v_user.user_id, v_content_weight, v_collab_weight, 30);
        
        v_user_count := v_user_count + 1;
    END LOOP;
    
    RAISE NOTICE 'Refreshed hybrid recommendations for % users', v_user_count;
END;
$$;