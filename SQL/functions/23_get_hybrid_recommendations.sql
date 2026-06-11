CREATE OR REPLACE FUNCTION get_hybrid_recommendations(
    p_user_id BIGINT,
    p_content_weight DECIMAL DEFAULT 0.5,
    p_collab_weight DECIMAL DEFAULT 0.5,
    p_limit INT DEFAULT 30
)
RETURNS TABLE (
    rec_title_id BIGINT,
    title_name VARCHAR,
    hybrid_score DECIMAL(5,2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COALESCE(c.rec_title_id, col.rec_title_id) AS rec_title_id,
        COALESCE(c.title_name, col.title_name) AS title_name,
        (COALESCE(c.content_score, 0) * p_content_weight + 
         COALESCE(col.collab_score, 0) * p_collab_weight)::DECIMAL(5,2) AS hybrid_score
    FROM get_content_recommendations(p_user_id, p_limit) c
    FULL OUTER JOIN get_collaborative_recommendations(p_user_id, p_limit) col 
        ON c.rec_title_id = col.rec_title_id
    ORDER BY hybrid_score DESC
    LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;