CREATE OR REPLACE FUNCTION check_series_end_date()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.end_date IS NOT NULL THEN
        IF EXISTS (
            SELECT 1
            FROM title
            WHERE title_id = NEW.title_id
            AND release_date > NEW.end_date
        ) THEN 
            RAISE EXCEPTION 'Series end_date (%) cannot be before release_date (%)',
                NEW.end_date,
                (SELECT release_date FROM title WHERE title_id = NEW.title_id);
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_series_end_date
    BEFORE INSERT OR UPDATE ON series
    FOR EACH ROW
    EXECUTE FUNCTION check_series_end_date();