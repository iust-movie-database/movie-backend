CREATE OR REPLACE FUNCTION calculate_similar_titles_weighted(
    p_title_id BIGINT,
    p_limit INT DEFAULT 20
)
RETURNS TABLE (
    similar_id BIGINT,
    similarity_score DECIMAL(5,2),
    genre_score INT,
    lead_cast_score INT,
    supporting_cast_score INT,
    director_score INT,
    writer_score INT,
    year_score INT,
    rating_score INT,
    total_score DECIMAL(5,2)
) AS $$
DECLARE
    v_source_year INT;
    v_source_score DECIMAL;
    v_source_genres INT[];
    v_source_lead_cast INT[];
    v_source_supporting_cast INT[];
    v_source_directors INT[];
    v_source_writers INT[];
BEGIN
    -- Get source title info
    SELECT 
        EXTRACT(YEAR FROM release_date)::INT,
        score,
        ARRAY_AGG(DISTINCT hg.genre_id)
    INTO 
        v_source_year,
        v_source_score,
        v_source_genres
    FROM title t
    LEFT JOIN has_genre hg ON t.title_id = hg.title_id
    WHERE t.title_id = p_title_id
    GROUP BY t.title_id;
    
    -- Get source title lead cast (ordering <= 5 or NULL)
    SELECT ARRAY_AGG(DISTINCT person_id)
    INTO v_source_lead_cast
    FROM cast_member
    WHERE title_id = p_title_id
      AND (ordering <= 5 OR ordering IS NULL)
      AND person_id IS NOT NULL;
    
    -- Get source title supporting cast (ordering > 5)
    SELECT ARRAY_AGG(DISTINCT person_id)
    INTO v_source_supporting_cast
    FROM cast_member
    WHERE title_id = p_title_id
      AND ordering > 5
      AND person_id IS NOT NULL;
    
    -- Get source title directors
    SELECT ARRAY_AGG(DISTINCT cm.person_id)
    INTO v_source_directors
    FROM crew_member cm
    JOIN role r ON cm.role_id = r.role_id
    WHERE cm.title_id = p_title_id
      AND r.name_en = 'Director'
      AND cm.person_id IS NOT NULL;
    
    -- Get source title writers
    SELECT ARRAY_AGG(DISTINCT cm.person_id)
    INTO v_source_writers
    FROM crew_member cm
    JOIN role r ON cm.role_id = r.role_id
    WHERE cm.title_id = p_title_id
      AND r.name_en IN ('Writer', 'Screenwriter')
      AND cm.person_id IS NOT NULL;
    
    RETURN QUERY
    WITH candidate_scores AS (
        SELECT 
            t.title_id,
            
            -- Genre score (0-30 points)
            LEAST(COALESCE((
                SELECT COUNT(*) * 6
                FROM has_genre hg2
                WHERE hg2.title_id = t.title_id
                  AND hg2.genre_id = ANY(v_source_genres)
            ), 0), 30) AS genre_score,
            
            -- Lead cast score (0-25 points)
            LEAST(COALESCE((
                SELECT COUNT(*) * 5
                FROM cast_member cm2
                WHERE cm2.title_id = t.title_id
                  AND cm2.person_id = ANY(v_source_lead_cast)
                  AND cm2.person_id IS NOT NULL
            ), 0), 25) AS lead_cast_score,
            
            -- Supporting cast score (0-10 points)
            LEAST(COALESCE((
                SELECT COUNT(*) * 1
                FROM cast_member cm2
                WHERE cm2.title_id = t.title_id
                  AND cm2.person_id = ANY(v_source_supporting_cast)
                  AND cm2.person_id IS NOT NULL
            ), 0), 10) AS supporting_cast_score,
            
            -- Director score (0-15 points)
            LEAST(COALESCE((
                SELECT COUNT(*) * 8
                FROM crew_member cr2
                WHERE cr2.title_id = t.title_id
                  AND cr2.person_id = ANY(v_source_directors)
                  AND cr2.person_id IS NOT NULL
            ), 0), 15) AS director_score,
            
            -- Writer score (0-10 points)
            LEAST(COALESCE((
                SELECT COUNT(*) * 5
                FROM crew_member cr2
                WHERE cr2.title_id = t.title_id
                  AND cr2.person_id = ANY(v_source_writers)
                  AND cr2.person_id IS NOT NULL
            ), 0), 10) AS writer_score,
            
            -- Year proximity score (0-5 points)
            CASE 
                WHEN EXTRACT(YEAR FROM t.release_date) IS NULL THEN 0
                WHEN ABS(EXTRACT(YEAR FROM t.release_date) - v_source_year) <= 1 THEN 5
                WHEN ABS(EXTRACT(YEAR FROM t.release_date) - v_source_year) <= 3 THEN 3
                WHEN ABS(EXTRACT(YEAR FROM t.release_date) - v_source_year) <= 5 THEN 2
                WHEN ABS(EXTRACT(YEAR FROM t.release_date) - v_source_year) <= 10 THEN 1
                ELSE 0
            END AS year_score,
            
            -- Rating proximity score (0-5 points)
            CASE 
                WHEN t.score IS NULL OR v_source_score IS NULL THEN 0
                WHEN ABS(t.score - v_source_score) <= 0.5 THEN 5
                WHEN ABS(t.score - v_source_score) <= 1.0 THEN 3
                WHEN ABS(t.score - v_source_score) <= 2.0 THEN 1
                ELSE 0
            END AS rating_score
            
        FROM title t
        WHERE t.title_id != p_title_id
          AND t.title_id IS NOT NULL
    )
    SELECT 
        c.title_id,
        (c.genre_score + c.lead_cast_score + c.supporting_cast_score + 
         c.director_score + c.writer_score + c.year_score + c.rating_score)::DECIMAL(5,2) AS similarity_score,
        c.genre_score::INT,
        c.lead_cast_score::INT,
        c.supporting_cast_score::INT,
        c.director_score::INT,
        c.writer_score::INT,
        c.year_score::INT,
        c.rating_score::INT,
        (c.genre_score + c.lead_cast_score + c.supporting_cast_score + 
         c.director_score + c.writer_score + c.year_score + c.rating_score)::DECIMAL(5,2) AS total_score
    FROM candidate_scores c
    WHERE (c.genre_score + c.lead_cast_score + c.supporting_cast_score + 
           c.director_score + c.writer_score + c.year_score + c.rating_score) > 0
    ORDER BY 
        c.lead_cast_score DESC,
        c.director_score DESC,
        similarity_score DESC
    LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;