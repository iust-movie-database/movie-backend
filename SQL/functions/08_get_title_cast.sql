CREATE OR REPLACE FUNCTION get_title_cast(p_title_id BIGINT)
RETURNS TABLE (
    person_id BIGINT,
    name_fa VARCHAR,
    name_en VARCHAR,
    photo_url VARCHAR,
    role_name VARCHAR,
    character_name_fa VARCHAR,
    character_name_en VARCHAR,
    ordering INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT p.person_id, p.name_fa, p.name_en, p.photo_url,
           r.name_fa as role_name,
           cm.char_name_fa, cm.char_name_en,
           cm.ordering
    FROM cast_member cm
    JOIN person p USING(person_id)
    JOIN role r USING(role_id)
    WHERE cm.title_id = p_title_id
    ORDER BY cm.ordering NULLS LAST, cm.char_name_fa;
END;
$$ LANGUAGE plpgsql;