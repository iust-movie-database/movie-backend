CREATE OR REPLACE FUNCTION get_title_crew(p_title_id BIGINT)
RETURNS TABLE (
    person_id BIGINT,
    name_fa VARCHAR,
    name_en VARCHAR,
    photo_url VARCHAR,
    role_name VARCHAR,
    ordering INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT p.person_id, p.name_fa, p.name_en, p.photo_url,
           r.name_fa as role_name,
           cm.ordering
    FROM crew_member cm
    JOIN person p USING(person_id)
    JOIN role r USING(role_id)
    WHERE cm.title_id = p_title_id
    ORDER BY cm.ordering NULLS LAST, p.name_fa;
END;
$$ LANGUAGE plpgsql;