CREATE OR REPLACE FUNCTION get_series_seasons(p_title_id BIGINT)
RETURNS TABLE (
    season_number INT,
    season_release_date DATE,
    season_end_date DATE,
    total_episodes INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT s.season_number, s.release_date, s.end_date, s.total_episodes
    FROM season s
    WHERE s.title_id = p_title_id
    ORDER BY s.season_number;
END;
$$ LANGUAGE plpgsql;