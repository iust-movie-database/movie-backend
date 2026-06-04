CREATE TABLE series (
    title_id BIGINT PRIMARY KEY REFERENCES title(title_id) ON DELETE CASCADE,
    total_seasons INTEGER DEFAULT 0 CHECK (total_seasons >= 0),
    total_episodes INTEGER DEFAULT 0 CHECK (total_episodes >= 0),
    end_date DATE
);