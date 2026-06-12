CREATE OR REPLACE PROCEDURE refresh_similar_titles()
LANGUAGE plpgsql
AS $$
DECLARE
    v_count INT;
BEGIN
    -- Clear existing data
    DELETE FROM similar_to;
    
    -- Insert new similarity scores using the weighted function
    INSERT INTO similar_to (title_id, similar_id, score, simil_date)
    SELECT 
        p_title_id,
        similar_id,
        similarity_score,
        CURRENT_DATE
    FROM (
        SELECT 
            t.title_id AS p_title_id,
            s.similar_id,
            s.similarity_score,
            ROW_NUMBER() OVER (PARTITION BY t.title_id ORDER BY s.similarity_score DESC) AS rn
        FROM title t
        CROSS JOIN LATERAL calculate_similar_titles_weighted(t.title_id, 30) s
    ) ranked
    WHERE rn <= 20;
    
    GET DIAGNOSTICS v_count = ROW_COUNT;
    RAISE NOTICE 'Similar titles refreshed: % entries', v_count;
END;
$$;