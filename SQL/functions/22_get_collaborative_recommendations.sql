CREATE OR REPLACE FUNCTION get_collaborative_recommendations(
    p_user_id BIGINT,
    p_limit INT DEFAULT 20
)
RETURNS TABLE (
    rec_title_id BIGINT,
    title_name VARCHAR,
    collab_score DECIMAL(5,2)
) AS $$
DECLARE
    v_similar_users BIGINT[];
BEGIN
    -- Find similar users (same ratings within 2 points, at least 2 common movies)
    SELECT ARRAY_AGG(DISTINCT r2.user_id)
    INTO v_similar_users
    FROM review r1
    JOIN review r2 ON r1.title_id = r2.title_id
    WHERE r1.user_id = p_user_id
      AND r2.user_id != p_user_id
      AND ABS(r1.score - r2.score) <= 2
    GROUP BY r2.user_id
    HAVING COUNT(*) >= 2;
    
    -- Return recommendations from similar users
    RETURN QUERY
    SELECT 
        r.title_id,
        t.name_en AS title_name,
        (AVG(r.score) * 10)::DECIMAL(5,2) AS collab_score
    FROM review r
    JOIN title t ON r.title_id = t.title_id
    WHERE r.user_id = ANY(v_similar_users)
      AND r.title_id NOT IN (SELECT title_id FROM review WHERE user_id = p_user_id)
      AND r.title_id NOT IN (SELECT title_id FROM saved WHERE user_id = p_user_id)
    GROUP BY r.title_id, t.name_en
    ORDER BY collab_score DESC
    LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;