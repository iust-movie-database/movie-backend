CREATE TABLE season (
    title_id BIGINT NOT NULL REFERENCES title(title_id) ON DELETE CASCADE,
    season_number INTEGER NOT NULL CHECK (season_number >= 1),
    total_episodes INTEGER DEFAULT 0 CHECK (total_episodes >= 0),
    release_date DATE,
    end_date DATE CHECK (end_date IS NULL OR end_date >= release_date),
    PRIMARY KEY (title_id, season_number)
);