CREATE TABLE episode (
    title_id BIGINT NOT NULL REFERENCES title(title_id) ON DELETE CASCADE,
    season_number INTEGER NOT NULL,
    episode_number INTEGER NOT NULL CHECK (episode_number >= 1),
    episode_name_fa VARCHAR(500) NOT NULL,
    episode_name_en VARCHAR(500),
    duration_mins INTEGER CHECK (duration_mins > 0),
    release_date DATE,
    summary TEXT,
    vote_count INTEGER DEFAULT 0 CHECK (vote_count >= 0),
    score DECIMAL(4,2) CHECK (score IS NULL OR (score >= 1 AND score <= 10)) DEFAULT NULL,
    PRIMARY KEY (title_id, season_number, episode_number),
    FOREIGN KEY (title_id, season_number) 
        REFERENCES season(title_id, season_number) ON DELETE CASCADE
);