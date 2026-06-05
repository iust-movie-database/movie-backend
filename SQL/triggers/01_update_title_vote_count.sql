CREATE OR REPLACE FUNCTION update_title_vote_count()
RETURNS TRIGGER AS $$
DECLARE
    v_title_id BIGINT;
BEGIN
    IF TG_OP = 'DELETE' THEN
        v_title_id := OLD.title_id;
    ELSE
        v_title_id := NEW.title_id;
    END IF;
    
    UPDATE title
    SET vote_count = (
        SELECT COUNT(*)
        FROM review
        WHERE review.title_id = v_title_id
            AND review.score IS NOT NULL
    )
    WHERE title_id = v_title_id;
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_vote_count
	AFTER INSERT OR UPDATE OR DELETE ON review
	FOR EACH ROW
	EXECUTE FUNCTION update_title_vote_count();