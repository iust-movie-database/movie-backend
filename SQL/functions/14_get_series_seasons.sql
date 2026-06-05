CREATE OR REPLACE FUNCTION get_series_seasons(p_title_id BIGINT)
RETURNS TABLE (
    season_number INT,
    season_release_date DATE,
    season_end_date DATE,
    total_episodes INT,
    episode_number INT,
    episode_name_fa VARCHAR,
    episode_name_en VARCHAR,
    episode_duration INT,
    episode_release_date DATE,
    episode_summary TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT s.season_number, s.release_date, s.end_date, s.total_episodes,
           e.episode_number, e.episode_name_fa, e.episode_name_en,
           e.duration_mins, e.release_date, e.summary
    FROM season s
    LEFT JOIN episode e USING(title_id, season_number)
    WHERE s.title_id = p_title_id
    ORDER BY s.season_number, e.episode_number;
END;
$$ LANGUAGE plpgsql;