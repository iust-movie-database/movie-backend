CREATE TABLE title (
    title_id BIGSERIAL PRIMARY KEY,
    name_fa VARCHAR(500) NOT NULL,
    name_en VARCHAR(500),
    duration_mins INTEGER CHECK (duration_mins > 0),
    release_date DATE,
    poster_url VARCHAR(500),
    age_rating VARCHAR(5) CHECK (
        (t_type = 'M' AND age_rating IN ('G', 'PG', 'PG-13', 'R', 'NC-17', 'NR')) OR
        (t_type = 'S' AND age_rating IN ('TV-Y', 'TV-Y7', 'TV-G', 'TV-PG', 'TV-14', 'TV-MA'))
    ),
    summary TEXT,
    vote_count INTEGER DEFAULT 0,
    score DECIMAL(4,2) CHECK (score IS NULL OR (score >= 1 AND score <= 10)) DEFAULT NULL,
    t_type CHAR(1) NOT NULL CHECK (t_type IN ('M', 'S'))
);