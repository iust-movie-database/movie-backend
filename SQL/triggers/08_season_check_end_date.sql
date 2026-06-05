CREATE OR REPLACE FUNCTION check_season_end_date()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.end_date IS NOT NULL THEN
        IF EXISTS (
            SELECT 1
            FROM series s
            WHERE s.title_id = NEW.title_id
            AND s.end_date IS NOT NULL
            AND NEW.end_date > s.end_date
        ) THEN 
            RAISE EXCEPTION 'Season end_date (%) cannot exceed Series end_date (%)',
                NEW.end_date,
                (SELECT s.end_date FROM series s WHERE s.title_id = NEW.title_id);
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_season_end_date
    BEFORE INSERT OR UPDATE ON season
    FOR EACH ROW
    EXECUTE FUNCTION check_season_end_date();