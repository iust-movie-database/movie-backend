-- Table 1: Person
CREATE TABLE Person(
    person_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birth_date DATE,
    death_date DATE
);

-- Table 2: Role
CREATE TABLE Role(
    role_id BIGSERIAL PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL UNIQUE
);

-- Table 3: Title
CREATE TABLE Title (
    title_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(500) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Released', 'Ongoing', 'Announced')),
    duration INTERVAL HOUR TO SECOND,
    release_date DATE,
    age_rating VARCHAR(5) CHECK (age_rating IN ('G', 'PG', 'PG-13', 'R', 'NC-17', 'NR')),
    summary TEXT,
    vote_count INTEGER DEFAULT 0,
    score DECIMAL(3,2) CHECK (score IS NULL OR (score >= 1 AND score <= 10))
);

-- Table 4: Genre
CREATE TABLE Genre (
    genre_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Table 5: Has Genre
CREATE TABLE Has_Genre (
    title_id BIGINT NOT NULL REFERENCES Title(title_id) ON DELETE CASCADE,
    genre_id BIGINT NOT NULL REFERENCES Genre(genre_id) ON DELETE CASCADE,
    PRIMARY KEY (title_id, genre_id)
);

-- Table 6: Cast_Member
CREATE TABLE Cast_Member (
    title_id BIGINT NOT NULL REFERENCES Title(title_id) ON DELETE CASCADE,
    person_id BIGINT NOT NULL REFERENCES Person(person_id) ON DELETE CASCADE,
    role_id BIGINT NOT NULL REFERENCES Role(role_id) ON DELETE CASCADE,
    char_name VARCHAR(255) NOT NULL,
    ordering INTEGER,
    PRIMARY KEY (title_id, person_id, role_id, char_name)
);

-- Table 7: Crew_Member
CREATE TABLE Crew_Member (
    title_id BIGINT NOT NULL REFERENCES Title(title_id) ON DELETE CASCADE,
    person_id BIGINT NOT NULL REFERENCES Person(person_id) ON DELETE CASCADE,
    role_id BIGINT NOT NULL REFERENCES Role(role_id) ON DELETE CASCADE,
    ordering INTEGER,
    PRIMARY KEY (title_id, person_id, role_id)
);

-- Table 8: Users
CREATE TABLE Users (
    user_id BIGSERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    password_hash VARCHAR(255) NOT NULL,
    join_date DATE DEFAULT CURRENT_DATE
);

-- Table 9: Series
CREATE TABLE Series (
    title_id BIGINT PRIMARY KEY REFERENCES Title(title_id) ON DELETE CASCADE,
    total_episodes INTEGER DEFAULT 0,
    total_seasons INTEGER DEFAULT 0,
    end_year INTEGER
);

-- Table 10: Season
CREATE TABLE Season (
    title_id BIGINT NOT NULL REFERENCES Title(title_id) ON DELETE CASCADE,
    season_number INTEGER NOT NULL CHECK (season_number >= 1),
    episodes_count INTEGER DEFAULT 0 CHECK (episodes_count >= 0),
    release_date DATE,
    PRIMARY KEY (title_id, season_number)
);

-- Table 11: Episode
CREATE TABLE Episode (
    title_id BIGINT NOT NULL REFERENCES Title(title_id) ON DELETE CASCADE,
    season_number INTEGER NOT NULL,
    episode_number INTEGER NOT NULL CHECK (episode_number >= 1),
    episode_name VARCHAR(500),
    score DECIMAL(3,2) CHECK (score IS NULL OR (score >= 1 AND score <= 10)),
    vote_count INTEGER DEFAULT 0 CHECK (vote_count >= 0),
    aired_date DATE,
    duration INTERVAL HOUR TO SECOND,
    summary TEXT,
    PRIMARY KEY (title_id, season_number, episode_number),
    FOREIGN KEY (title_id, season_number) REFERENCES Season(title_id, season_number) ON DELETE CASCADE
);

-- Table 12: Review (partitioned)
CREATE TABLE Review (
    review_id BIGSERIAL,
    score INTEGER CHECK (score IS NULL OR (score >= 1 AND score <= 10)),
    comment TEXT,
    date DATE DEFAULT CURRENT_DATE,
    is_spoiler BOOLEAN DEFAULT FALSE,
    user_id BIGINT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    type VARCHAR(1) NOT NULL CHECK (type IN ('T', 'E')),
    title_id BIGINT NOT NULL REFERENCES Title(title_id) ON DELETE CASCADE,
    season_number INTEGER,
    episode_number INTEGER,
    PRIMARY KEY (review_id, type),
    CHECK (
        (type = 'T' AND season_number IS NULL AND episode_number IS NULL) OR
        (type = 'E' AND season_number IS NOT NULL AND episode_number IS NOT NULL)
    ),
    FOREIGN KEY (title_id, season_number, episode_number) 
        REFERENCES Episode(title_id, season_number, episode_number) ON DELETE CASCADE
) PARTITION BY LIST (type);

CREATE TABLE Review_T PARTITION OF Review FOR VALUES IN ('T');
CREATE TABLE Review_E PARTITION OF Review FOR VALUES IN ('E');

-- Table 13: Saved
CREATE TABLE Saved (
    user_id BIGINT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    title_id BIGINT NOT NULL REFERENCES Title(title_id) ON DELETE CASCADE,
    added_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'Want to Watch' CHECK (status IN ('Want to Watch', 'Watching', 'Watched')),
    PRIMARY KEY (user_id, title_id)
);

-- Table 14: Recommended
CREATE TABLE Recommended (
    user_id BIGINT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    title_id BIGINT NOT NULL REFERENCES Title(title_id) ON DELETE CASCADE,
    date DATE DEFAULT CURRENT_DATE,
    score INTEGER,
    PRIMARY KEY (user_id, title_id)
);

-- Table 15: Award (partitioned)
CREATE TABLE Award (
    award_id BIGSERIAL,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(255),
    ceremony_date DATE,
    type VARCHAR(1) NOT NULL CHECK (type IN ('T', 'C', 'W')),
    title_id BIGINT NOT NULL REFERENCES Title(title_id) ON DELETE CASCADE,
    person_id BIGINT,
    role_id BIGINT,
    char_name VARCHAR(255),
    PRIMARY KEY (award_id, type),
    CHECK (
        (type = 'T' AND person_id IS NULL AND role_id IS NULL AND char_name IS NULL) OR
        (type = 'C' AND person_id IS NOT NULL AND role_id IS NOT NULL AND char_name IS NOT NULL) OR
        (type = 'W' AND person_id IS NOT NULL AND role_id IS NOT NULL AND char_name IS NULL)
    ),
    FOREIGN KEY (title_id, person_id, role_id, char_name) 
        REFERENCES Cast_Member(title_id, person_id, role_id, char_name) ON DELETE CASCADE,
    FOREIGN KEY (title_id, person_id, role_id) 
        REFERENCES Crew_Member(title_id, person_id, role_id) ON DELETE CASCADE
) PARTITION BY LIST (type);

CREATE TABLE Award_T PARTITION OF Award FOR VALUES IN ('T');
CREATE TABLE Award_C PARTITION OF Award FOR VALUES IN ('C');
CREATE TABLE Award_W PARTITION OF Award FOR VALUES IN ('W');

-- Add column english_name
ALTER TABLE Title ADD COLUMN name_en VARCHAR(500);
ALTER TABLE Episode ADD COLUMN episode_name_en VARCHAR(500);
ALTER TABLE Person ADD COLUMN name_en VARCHAR(500);
ALTER TABLE Cast_Member ADD COLUMN char_name_en VARCHAR(255);

-- Title table
ALTER TABLE Title ALTER COLUMN score SET DEFAULT NULL;

-- Episode table
ALTER TABLE Episode ALTER COLUMN score SET DEFAULT NULL;

-- Review table
ALTER TABLE Review ALTER COLUMN score SET DEFAULT NULL;

-- Drop the existing constraint
ALTER TABLE Title DROP CONSTRAINT title_age_rating_check;

-- Add new constraint with both MPAA and TV ratings
ALTER TABLE Title ADD CONSTRAINT title_age_rating_check CHECK (
    age_rating IN (
        -- MPAA movie ratings
        'G', 'PG', 'PG-13', 'R', 'NC-17', 'NR',
        -- TV ratings
        'TV-Y', 'TV-Y7', 'TV-G', 'TV-PG', 'TV-14', 'TV-MA'
    )
);


-- Step 1: Drop foreign keys from parent table
ALTER TABLE Award DROP CONSTRAINT award_title_id_person_id_role_id_char_name_fkey;
ALTER TABLE Award DROP CONSTRAINT award_title_id_person_id_role_id_fkey;

-- Step 2: Add foreign key to Cast_Member ONLY on Award_C partition
ALTER TABLE Award_C ADD CONSTRAINT award_c_cast_fk 
    FOREIGN KEY (title_id, person_id, role_id, char_name) 
    REFERENCES Cast_Member(title_id, person_id, role_id, char_name) ON DELETE CASCADE;

-- Step 3: Add foreign key to Crew_Member ONLY on Award_W partition
ALTER TABLE Award_W ADD CONSTRAINT award_w_crew_fk 
    FOREIGN KEY (title_id, person_id, role_id) 
    REFERENCES Crew_Member(title_id, person_id, role_id) ON DELETE CASCADE;


-- Step 1: Drop foreign keys from parent Review table
ALTER TABLE Review DROP CONSTRAINT review_title_id_season_number_episode_number_fkey;

-- Step 2: Add episode foreign key ONLY to Review_E partition
ALTER TABLE Review_E ADD CONSTRAINT review_e_episode_fk 
    FOREIGN KEY (title_id, season_number, episode_number) 
    REFERENCES Episode(title_id, season_number, episode_number) ON DELETE CASCADE;


-- =====================================================
-- 1. Update Series.total_episodes and total_seasons
-- =====================================================
CREATE OR REPLACE FUNCTION update_series_counts()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Series
    SET 
        total_episodes = (
            SELECT COUNT(*) FROM Episode 
            WHERE title_id = COALESCE(NEW.title_id, OLD.title_id)
        ),
        total_seasons = (
            SELECT COUNT(DISTINCT season_number) FROM Episode 
            WHERE title_id = COALESCE(NEW.title_id, OLD.title_id)
        )
    WHERE title_id = COALESCE(NEW.title_id, OLD.title_id);
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_series_counts
AFTER INSERT OR UPDATE OR DELETE ON Episode
FOR EACH ROW
EXECUTE FUNCTION update_series_counts();

-- =====================================================
-- 2. Update Title.vote_count and average score (fixed for DECIMAL(3,2))
-- =====================================================
CREATE OR REPLACE FUNCTION update_title_review_stats()
RETURNS TRIGGER AS $$
DECLARE
    avg_score NUMERIC;
BEGIN
    -- Calculate average score, handle NULL
    SELECT ROUND(AVG(score), 2) INTO avg_score
    FROM Review_T 
    WHERE title_id = COALESCE(NEW.title_id, OLD.title_id);
    
    -- Ensure score doesn't exceed 9.99 (DECIMAL(3,2) max)
    IF avg_score > 9.99 THEN
        avg_score := 9.99;
    END IF;
    
    UPDATE Title
    SET 
        vote_count = (
            SELECT COUNT(*) FROM Review_T 
            WHERE title_id = COALESCE(NEW.title_id, OLD.title_id)
        ),
        score = avg_score
    WHERE title_id = COALESCE(NEW.title_id, OLD.title_id);
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_title_stats
AFTER INSERT OR UPDATE OR DELETE ON Review_T
FOR EACH ROW
EXECUTE FUNCTION update_title_review_stats();

-- =====================================================
-- 3. Update Episode.vote_count and average score (fixed for DECIMAL(3,2))
-- =====================================================
CREATE OR REPLACE FUNCTION update_episode_review_stats()
RETURNS TRIGGER AS $$
DECLARE
    avg_score NUMERIC;
    ep_title_id BIGINT;
    ep_season INTEGER;
    ep_episode INTEGER;
BEGIN
    -- Get the episode identifiers
    ep_title_id := COALESCE(NEW.title_id, OLD.title_id);
    ep_season := COALESCE(NEW.season_number, OLD.season_number);
    ep_episode := COALESCE(NEW.episode_number, OLD.episode_number);
    
    -- Calculate average score, handle NULL
    SELECT ROUND(AVG(score), 2) INTO avg_score
    FROM Review_E 
    WHERE title_id = ep_title_id
      AND season_number = ep_season
      AND episode_number = ep_episode;
    
    -- Ensure score doesn't exceed 9.99 (DECIMAL(3,2) max)
    IF avg_score > 9.99 THEN
        avg_score := 9.99;
    END IF;
    
    UPDATE Episode
    SET 
        vote_count = (
            SELECT COUNT(*) FROM Review_E 
            WHERE title_id = ep_title_id
              AND season_number = ep_season
              AND episode_number = ep_episode
        ),
        score = avg_score
    WHERE title_id = ep_title_id
      AND season_number = ep_season
      AND episode_number = ep_episode;
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_episode_stats
AFTER INSERT OR UPDATE OR DELETE ON Review_E
FOR EACH ROW
EXECUTE FUNCTION update_episode_review_stats();

-- =====================================================
-- 4. Update Season.episodes_count
-- =====================================================
CREATE OR REPLACE FUNCTION update_season_episode_count()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Season
    SET episodes_count = (
        SELECT COUNT(*) FROM Episode 
        WHERE title_id = COALESCE(NEW.title_id, OLD.title_id)
          AND season_number = COALESCE(NEW.season_number, OLD.season_number)
    )
    WHERE title_id = COALESCE(NEW.title_id, OLD.title_id)
      AND season_number = COALESCE(NEW.season_number, OLD.season_number);
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_season_episode_count
AFTER INSERT OR UPDATE OR DELETE ON Episode
FOR EACH ROW
EXECUTE FUNCTION update_season_episode_count();