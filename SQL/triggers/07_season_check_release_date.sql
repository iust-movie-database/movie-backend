CREATE OR REPLACE FUNCTION check_seasons_release_date()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.release_date IS NOT NULL THEN
        IF EXISTS (
            SELECT 1
            FROM title
            WHERE title_id = NEW.title_id
            AND release_date > NEW.release_date
        ) THEN 
            RAISE EXCEPTION 'Season release_date (%) cannot be before Series release_date (%)',
                NEW.release_date,
                (SELECT release_date FROM title WHERE title_id = NEW.title_id);
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_seasons_release_date
    BEFORE INSERT OR UPDATE ON season
    FOR EACH ROW
    EXECUTE FUNCTION check_seasons_release_date();