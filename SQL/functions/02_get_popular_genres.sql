CREATE OR REPLACE FUNCTION get_popular_genres(p_limit INT DEFAULT 5)
RETURNS TABLE(
	genre_id BIGINT,
	genre_name VARCHAR,
	title_count BIGINT
) AS $$

BEGIN
	RETURN QUERY
		SELECT g.genre_id, g.name_fa, COUNT(title_id) AS title_count
		FROM genre g
		LEFT JOIN has_genre hg USING(genre_id)
		GROUP BY g.genre_id, g.name_fa
		ORDER BY title_count DESC
		LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;