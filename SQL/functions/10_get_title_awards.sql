CREATE OR REPLACE FUNCTION get_title_awards(p_title_id BIGINT)
RETURNS TABLE (
    award_name VARCHAR,
    category VARCHAR,
    ceremony_year INT,
    status VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT a.award_name, a.category,
           EXTRACT(YEAR FROM a.ceremony_date)::INT as ceremony_year,
           a.status
    FROM award a
    WHERE a.title_id = p_title_id
    ORDER BY a.ceremony_date DESC, a.award_name;
END;
$$ LANGUAGE plpgsql;