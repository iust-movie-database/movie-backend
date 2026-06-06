CREATE OR REPLACE PROCEDURE add_review(
    p_user_id BIGINT,
    p_title_id BIGINT,
    p_score INT,
    p_comment TEXT DEFAULT NULL,
    p_is_spoiler BOOLEAN DEFAULT FALSE
) AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM review WHERE user_id = p_user_id AND title_id = p_title_id) THEN
        UPDATE review
        SET score = p_score,
            comment = p_comment,
            is_spoiler = p_is_spoiler,
            review_date = CURRENT_DATE
        WHERE user_id = p_user_id AND title_id = p_title_id;
    ELSE
        INSERT INTO review (user_id, title_id, score, comment, is_spoiler, review_date)
        VALUES (p_user_id, p_title_id, p_score, p_comment, p_is_spoiler, CURRENT_DATE);
    END IF;
END;
$$ LANGUAGE plpgsql;