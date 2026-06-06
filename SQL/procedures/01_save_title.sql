CREATE OR REPLACE PROCEDURE save_title(
    p_user_id BIGINT,
    p_title_id BIGINT,
    p_status VARCHAR DEFAULT 'Want to Watch'
)
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM saved WHERE user_id = p_user_id AND title_id = p_title_id) THEN
        UPDATE saved
        SET status = p_status,
            added_date = CURRENT_DATE
        WHERE user_id = p_user_id AND title_id = p_title_id;
    ELSE
        INSERT INTO saved (user_id, title_id, status, added_date)
        VALUES (p_user_id, p_title_id, p_status, CURRENT_DATE);
    END IF;
END;
$$ LANGUAGE plpgsql;