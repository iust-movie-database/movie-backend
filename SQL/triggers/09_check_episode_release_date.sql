CREATE OR REPLACE FUNCTION check_episode_release_date()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.release_date IS NOT NULL THEN
        -- Check if episode release_date is within season's date range
        IF EXISTS (
            SELECT 1
            FROM season s
            WHERE s.title_id = NEW.title_id
            AND s.season_number = NEW.season_number
            AND (
                NEW.release_date < s.release_date
                OR (s.end_date IS NOT NULL AND NEW.release_date > s.end_date)
            )
        ) THEN 
            RAISE EXCEPTION 'Episode release_date (%) must be between Season release_date (%) and end_date (%)',
                NEW.release_date,
                (SELECT s.release_date FROM season s 
                 WHERE s.title_id = NEW.title_id AND s.season_number = NEW.season_number),
                (SELECT s.end_date FROM season s 
                 WHERE s.title_id = NEW.title_id AND s.season_number = NEW.season_number);
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_episode_release_date
    BEFORE INSERT OR UPDATE ON episode
    FOR EACH ROW
    EXECUTE FUNCTION check_episode_release_date();