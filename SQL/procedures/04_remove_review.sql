CREATE OR REPLACE PROCEDURE remove_review(
    p_user_id BIGINT,
    p_title_id BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM review
    WHERE user_id = p_user_id AND title_id = p_title_id;
    
    IF NOT FOUND THEN
        RAISE NOTICE 'Review not found';
    END IF;
END;
$$;