CREATE OR REPLACE FUNCTION update_season_total_episodes()
RETURNS TRIGGER AS $$
DECLARE
    v_title_id BIGINT;
    v_season_number INT;
BEGIN
    -- Get the title_id and season_number from either NEW or OLD
    IF TG_OP = 'DELETE' THEN
        v_title_id := OLD.title_id;
        v_season_number := OLD.season_number;
    ELSE
        v_title_id := NEW.title_id;
        v_season_number := NEW.season_number;
    END IF;

    UPDATE season
    SET total_episodes = (
        SELECT COUNT(*)
        FROM episode
        WHERE episode.title_id = v_title_id
        AND episode.season_number = v_season_number
    )
    WHERE season.title_id = v_title_id
    AND season.season_number = v_season_number;
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_season_total_episodes
    AFTER INSERT OR UPDATE OR DELETE ON episode
    FOR EACH ROW
    EXECUTE FUNCTION update_season_total_episodes();