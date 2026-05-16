-- =====================================================
-- 1.Query: TOP RATED MOVIES
-- =====================================================
-- Highest user-rated movies of all time (d.g. minimum 1000 votes)
SELECT 
    t.title_id,
    t.name AS title_name,
    t.name_en AS title_name_en,
    t.score AS average_rating,
    t.vote_count,
    t.release_date,
    t.duration,
    t.age_rating,
    ROUND(
        (t.score * t.vote_count + (SELECT AVG(score) FROM Title WHERE ttype = 'M' AND score IS NOT NULL) * 1000) 
        / (t.vote_count + 1000), 2
    ) AS weighted_rating
FROM 
    Title t
WHERE 
    t.ttype = 'M'
    AND t.status = 'Released'
    AND t.score IS NOT NULL
    AND t.vote_count >= 1000
ORDER BY 
    t.score DESC,
    t.vote_count DESC;

-- =====================================================
-- 2.Query: COMING SOON
-- =====================================================
-- Limited to next 90 days
SELECT 
    t.title_id,
    t.name AS title_name,
    t.name_en AS title_name_en,
    t.release_date,
    t.duration,
    t.age_rating,
    t.status,
    t.summary,
    (t.release_date - CURRENT_DATE) AS days_until_release,
    STRING_AGG(g.name, ', ' ORDER BY g.name) AS genres
FROM 
    Title t
    LEFT JOIN Has_Genre hg ON t.title_id = hg.title_id
    LEFT JOIN Genre g ON hg.genre_id = g.genre_id
WHERE 
    t.ttype = 'M'
    AND t.status != 'Released'
    AND t.release_date > CURRENT_DATE
    AND t.release_date <= CURRENT_DATE + INTERVAL '90 days'
GROUP BY 
    t.title_id, t.name, t.name_en, t.release_date, 
    t.duration, t.age_rating, t.status, t.summary
ORDER BY 
    t.release_date ASC;

-- =====================================================
-- 3.Query: POPULAR BY GENRE
-- =====================================================
-- Horizontal rows by genre: Top 5 movies per genre based on user ratings
WITH ranked_movies AS (
    SELECT 
        g.genre_id,
        g.name AS genre_name,
        g.name_en AS genre_name_en,
        t.title_id,
        t.name AS movie_name,
        t.name_en AS movie_name_en,
        t.score AS rating,
        t.vote_count,
        t.release_date,
        t.duration,
        t.age_rating,
        ROW_NUMBER() OVER (
            PARTITION BY g.genre_id 
            ORDER BY t.score DESC, t.vote_count DESC
        ) AS rank_in_genre
    FROM 
        Genre g
        INNER JOIN Has_Genre hg ON g.genre_id = hg.genre_id
        INNER JOIN Title t ON hg.title_id = t.title_id
    WHERE 
        t.ttype = 'M'
        AND t.status = 'Released'
        AND t.score IS NOT NULL
        AND t.vote_count >= 100
        AND g.name IN ('Action', 'Comedy', 'Drama', 'Horror', 'Sci-Fi', 'Romance', 'Thriller')
)
SELECT 
    genre_id,
    genre_name,
    genre_name_en,
    JSON_AGG(
        JSON_BUILD_OBJECT(
            'rank', rank_in_genre,
            'title_id', title_id,
            'name', movie_name,
            'name_en', movie_name_en,
            'rating', rating,
            'vote_count', vote_count,
            'year', EXTRACT(YEAR FROM release_date),
            'duration', duration,
            'age_rating', age_rating
        ) ORDER BY rank_in_genre
    ) AS top_movies
FROM 
    ranked_movies
WHERE 
    rank_in_genre <= 5
GROUP BY 
    genre_id, genre_name, genre_name_en
ORDER BY 
    genre_name;