CREATE OR REPLACE PROCEDURE remove_saved_title(
    p_user_id BIGINT,
    p_title_id BIGINT
)
AS $$
BEGIN
    DELETE FROM saved
    WHERE user_id = p_user_id AND title_id = p_title_id;
    
    IF NOT FOUND THEN
        RAISE NOTICE 'Title not found in watchlist';
    END IF;
END;
$$ LANGUAGE plpgsql;