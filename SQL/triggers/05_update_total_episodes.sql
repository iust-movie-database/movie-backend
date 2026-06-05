CREATE OR REPLACE FUNCTION update_total_episodes()
RETURNS TRIGGER AS $$
DECLARE
	v_title_id BIGINT;
BEGIN
	IF TG_OP = 'DELETE' THEN
		v_title_id := OLD.title_id;
	ELSE
		v_title_id := NEW.title_id;
	END IF;

	UPDATE series
	SET total_episodes = (
		SELECT COUNT(*)
		FROM episode
		WHERE episode.title_id = v_title_id
	)
	WHERE series.title_id = v_title_id;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_total_episodes
	AFTER INSERT OR UPDATE OR DELETE ON episode
	FOR EACH ROW
	EXECUTE FUNCTION update_total_episodes();