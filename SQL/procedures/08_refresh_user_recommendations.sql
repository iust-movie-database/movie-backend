CREATE OR REPLACE PROCEDURE refresh_user_recommendations(p_user_id BIGINT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_rating_count INT;
    v_content_weight DECIMAL;
    v_collab_weight DECIMAL;
BEGIN
    -- Delete old recommendations for this user
    DELETE FROM recommended WHERE user_id = p_user_id;
    
    -- Count user's ratings
    SELECT COUNT(*) INTO v_rating_count FROM review WHERE user_id = p_user_id;
    
    -- Set weights based on rating count
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
    
    -- Generate and insert recommendations
    INSERT INTO recommended (user_id, title_id, score, recom_date)
    SELECT 
        p_user_id,
        rec_title_id,
        hybrid_score,
        CURRENT_DATE
    FROM get_hybrid_recommendations(p_user_id, v_content_weight, v_collab_weight, 30);
    
    RAISE NOTICE 'Refreshed recommendations for user % (has % ratings)', p_user_id, v_rating_count;
END;
$$;