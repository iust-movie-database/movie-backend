CREATE OR REPLACE FUNCTION search_titles(
    p_search_text TEXT DEFAULT NULL,
    p_media_type CHAR(1) DEFAULT NULL,
    p_genre_ids BIGINT[] DEFAULT NULL,
    p_min_year INT DEFAULT NULL,
    p_max_year INT DEFAULT NULL,
    p_min_score DECIMAL DEFAULT NULL,
    p_min_votes INT DEFAULT NULL,
    p_sort_by VARCHAR DEFAULT 'score_desc',
    p_limit INT DEFAULT 20,
    p_offset INT DEFAULT 0,
    p_user_id BIGINT DEFAULT NULL
)
RETURNS TABLE (
    title_id BIGINT,
    t_type CHAR(1),
    name_fa VARCHAR,
    name_en VARCHAR,
    poster_url VARCHAR,
    release_year INT,
    year_end INT,
    score DECIMAL,
    vote_count INT,
    genres TEXT,
    duration_mins INT,
    total_seasons INT,
    total_episodes INT,
    is_saved BOOLEAN,
    total_count BIGINT
) AS $$
DECLARE
    v_total_count BIGINT;
BEGIN
    -- First, get the total count
    SELECT COUNT(DISTINCT t.title_id) INTO v_total_count
    FROM title t
    LEFT JOIN series s ON t.title_id = s.title_id
    WHERE (p_search_text IS NULL OR 
           t.name_fa ILIKE '%' || p_search_text || '%' OR
           t.name_en ILIKE '%' || p_search_text || '%' OR
           EXISTS (SELECT 1 FROM cast_member cm 
                   JOIN person p ON cm.person_id = p.person_id 
                   WHERE cm.title_id = t.title_id AND 
                         (p.name_fa ILIKE '%' || p_search_text || '%' OR
                          p.name_en ILIKE '%' || p_search_text || '%')) OR
           EXISTS (SELECT 1 FROM crew_member crm 
                   JOIN person p ON crm.person_id = p.person_id 
                   WHERE crm.title_id = t.title_id AND 
                         (p.name_fa ILIKE '%' || p_search_text || '%' OR
                          p.name_en ILIKE '%' || p_search_text || '%')))
      AND (p_media_type IS NULL OR t.t_type = p_media_type)
      AND (p_genre_ids IS NULL OR EXISTS (
          SELECT 1 FROM has_genre hg 
          WHERE hg.title_id = t.title_id AND hg.genre_id = ANY(p_genre_ids)))
      AND (p_min_year IS NULL OR EXTRACT(YEAR FROM t.release_date) >= p_min_year)
      AND (p_max_year IS NULL OR EXTRACT(YEAR FROM t.release_date) <= p_max_year)
      AND (p_min_score IS NULL OR t.score >= p_min_score)
      AND (p_min_votes IS NULL OR t.vote_count >= p_min_votes);

    -- Then return the paginated results
    RETURN QUERY
    SELECT t.title_id, t.t_type, t.name_fa, t.name_en, t.poster_url,
           EXTRACT(YEAR FROM t.release_date)::INT,
           EXTRACT(YEAR FROM s.end_date)::INT,
           t.score, t.vote_count,
           STRING_AGG(DISTINCT g.name_fa, ', ') as genres,
           t.duration_mins,
           s.total_seasons, s.total_episodes,
           CASE WHEN p_user_id IS NOT NULL AND EXISTS (
               SELECT 1 FROM saved sv 
               WHERE sv.user_id = p_user_id AND sv.title_id = t.title_id
           ) THEN TRUE ELSE FALSE END as is_saved,
           v_total_count as total_count
    FROM title t
    LEFT JOIN series s ON t.title_id = s.title_id
    LEFT JOIN has_genre hg ON t.title_id = hg.title_id
    LEFT JOIN genre g ON hg.genre_id = g.genre_id
    WHERE (p_search_text IS NULL OR 
           t.name_fa ILIKE '%' || p_search_text || '%' OR
           t.name_en ILIKE '%' || p_search_text || '%' OR
           EXISTS (SELECT 1 FROM cast_member cm 
                   JOIN person p ON cm.person_id = p.person_id 
                   WHERE cm.title_id = t.title_id AND 
                         (p.name_fa ILIKE '%' || p_search_text || '%' OR
                          p.name_en ILIKE '%' || p_search_text || '%')) OR
           EXISTS (SELECT 1 FROM crew_member crm 
                   JOIN person p ON crm.person_id = p.person_id 
                   WHERE crm.title_id = t.title_id AND 
                         (p.name_fa ILIKE '%' || p_search_text || '%' OR
                          p.name_en ILIKE '%' || p_search_text || '%')))
      AND (p_media_type IS NULL OR t.t_type = p_media_type)
      AND (p_genre_ids IS NULL OR EXISTS (
          SELECT 1 FROM has_genre hg2 
          WHERE hg2.title_id = t.title_id AND hg2.genre_id = ANY(p_genre_ids)))
      AND (p_min_year IS NULL OR EXTRACT(YEAR FROM t.release_date) >= p_min_year)
      AND (p_max_year IS NULL OR EXTRACT(YEAR FROM t.release_date) <= p_max_year)
      AND (p_min_score IS NULL OR t.score >= p_min_score)
      AND (p_min_votes IS NULL OR t.vote_count >= p_min_votes)
    GROUP BY t.title_id, s.end_date, s.total_seasons, s.total_episodes
    ORDER BY 
        CASE WHEN p_sort_by = 'score_desc' THEN t.score END DESC,
        CASE WHEN p_sort_by = 'votes_desc' THEN t.vote_count END DESC,
        CASE WHEN p_sort_by = 'year_desc' THEN t.release_date END DESC,
        CASE WHEN p_sort_by = 'year_asc' THEN t.release_date END ASC,
        CASE WHEN p_sort_by = 'title_asc' THEN t.name_en END ASC,
        CASE WHEN p_sort_by = 'title_desc' THEN t.name_en END DESC
    LIMIT p_limit
    OFFSET p_offset;
END;
$$ LANGUAGE plpgsql;